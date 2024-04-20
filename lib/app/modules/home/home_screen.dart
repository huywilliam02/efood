import 'dart:developer';

import 'package:citgroupvn_efood_table/app/helper/dia_log_helper.dart';
import 'package:citgroupvn_efood_table/app/modules/login/controllers/login_controller.dart';
import 'package:citgroupvn_efood_table/app/util/icon_utils.dart';
import 'package:citgroupvn_efood_table/app/modules/main_tabview/controller/main_tabview_controller.dart';
import 'package:citgroupvn_efood_table/app/modules/home/widget/product_widget.dart';
import 'package:citgroupvn_efood_table/app/modules/promotional_page/widget/setting_widget.dart';
import 'package:citgroupvn_efood_table/base/base_common.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  late String selectedProductType;
  final GlobalKey<FabCircularMenuState> _fabKey = GlobalKey();
  Timer? _timer;

  @override
  void initState() {
    MainTabviewController mainTabViewController =
        Get.put(MainTabviewController());
    final productController = Get.find<ProductController>();
    LoginController controller = Get.put(LoginController());
    SplashController splashController = Get.find<SplashController>();

    Get.find<OrderController>().getOrderList();
    selectedProductType = productController.productTypeList.first;
    productController.getCategoryList(true);
    productController.getProductList(false, false);

    searchController.addListener(() {
      if (searchController.text.trim().isNotEmpty) {
        productController.isSearchChange(false);
      } else {
        productController.isSearchChange(true);
        FocusScope.of(context).unfocus();
      }
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        int totalSize = (productController.totalSize! / 10).ceil();

        if (productController.productOffset < totalSize) {
          productController.productOffset++;

          productController.getProductList(
            false,
            true,
            offset: productController.productOffset,
            productType: selectedProductType,
            categoryId: productController.selectedCategory,
            searchPattern: searchController.text.trim().isEmpty
                ? null
                : searchController.text,
          );
        }
      }
    });
    _loadEndpointApiUrl();

    log(_endpointApiUrl.toString());
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    searchController.dispose();
    changeButtonState();
    super.dispose();
  }

  void changeButtonState() {
    if (_fabKey.currentState != null && _fabKey.currentState!.isOpen) {
      _fabKey.currentState?.close();
      _timer?.cancel();
      _timer = null;
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      changeButtonState();
      timer.cancel();
    });
  }

  String? _endpointApiUrl;
  Future<void> _loadEndpointApiUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _endpointApiUrl = prefs.getString('endpoint_api_url');
    log(_endpointApiUrl.toString());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (searchController.text.trim().isEmpty) {
          DialogHelper.openDialog(
              context,
              ConfirmationDialog(
                title: '${'exit'.tr} !',
                icon: Icons.question_mark_sharp,
                description: 'are_you_exit_the_app'.tr,
                onYesPressed: () => SystemNavigator.pop(),
                onNoPressed: () => Get.back(),
              ));
        } else {
          searchController.clear();
        }

        return Future.value(false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: ResponsiveHelper.isTab(context)
            ? null
            : const CustomAppBar(
                isBackButtonExist: false,
                onBackPressed: null,
                showCart: true,
              ),
        body: ResponsiveHelper.isTab(context)
            ? BodyTemplate(
                body: _bodyWidget(),
                showSetting: true,
                showOrderButton: true,
              )
            : homeMobileView(),
        floatingActionButton: ResponsiveHelper.isTab(context)
            ? null
            : Padding(
                padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: FloatingActionButton(
                  backgroundColor:
                      Theme.of(context).primaryColor, // Màu đỏ cho nút
                  onPressed: () {
                    Get.bottomSheet(
                      const SettingWidget(formSplash: false),
                      backgroundColor: Colors.transparent,
                    );
                  },
                  child: Icon(IconsUtils.storefrontoutline,
                      size: Dimensions.fontSizeExtraLarge, color: Colors.white),
                ),
              ),
      ),
    );
  }

  Widget homeMobileView() {
    return GetBuilder<ProductController>(builder: (productController) {
      return Column(
        children: <Widget>[
          SizedBox(
            height: Dimensions.paddingSizeDefault,
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
            child: SearchBarView(
                controller: searchController, type: selectedProductType),
          ),
          SizedBox(
            height: 90,
            child: CategoryView(onSelected: (id) {
              if (productController.selectedCategory == id) {
                productController.setSelectedCategory(null);
              } else {
                productController.setSelectedCategory(id);
              }
              productController.getProductList(
                true,
                true,
                categoryId: productController.selectedCategory,
                productType: selectedProductType,
                searchPattern: searchController.text.trim().isEmpty
                    ? null
                    : searchController.text,
              );
            }),
          ),
          SizedBox(
            height: Dimensions.paddingSizeSmall,
          ),
          IgnorePointer(
            ignoring: productController.productList == null,
            child: FilterButtonWidget(
              items: productController.productTypeList,
              type: selectedProductType,
              onSelected: (type) {
                selectedProductType = type;
                productController.setSelectedProductType = type;
                productController.getProductList(
                  true,
                  true,
                  categoryId: productController.selectedCategory,
                  productType: type,
                  searchPattern: searchController.text.trim().isEmpty
                      ? null
                      : searchController.text,
                );
              },
            ),
          ),
          SizedBox(
            height: Dimensions.paddingSizeSmall,
          ),
          Expanded(
            child: GetBuilder<ProductController>(builder: (productController) {
              final isBig = (Get.height / Get.width) > 1 &&
                  (Get.height / Get.width) < 1.7;

              return productController.productList == null
                  ? const ProductShimmerList()
                  : productController.productList!.isNotEmpty
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  selectedProductType =
                                      Get.find<ProductController>()
                                          .productTypeList
                                          .first;
                                  Get.find<ProductController>()
                                      .setSelectedCategory(null);
                                  await Get.find<ProductController>()
                                      .getProductList(
                                    true,
                                    true,
                                    offset: 1,
                                  );
                                },
                                child: GridView.builder(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  controller: _scrollController,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.paddingSizeLarge),
                                  itemCount:
                                      productController.productList?.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: isBig ? 3 : 2,
                                    crossAxisSpacing:
                                        Dimensions.paddingSizeDefault,
                                    mainAxisSpacing:
                                        Dimensions.paddingSizeDefault,
                                  ),
                                  itemBuilder: (context, index) {
                                    return productController
                                                .productList?[index] !=
                                            null
                                        ? ProductWidget(
                                            product: productController
                                                .productList![index]!)
                                        : Center(
                                            child: CustomLoader(
                                                color: Theme.of(context)
                                                    .primaryColor));
                                  },
                                ),
                              ),
                            ),
                            if (productController.isLoading)
                              Container(
                                color: Colors.transparent,
                                padding: EdgeInsets.all(
                                    Dimensions.paddingSizeDefault),
                                child: CustomLoader(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                          ],
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            selectedProductType = Get.find<ProductController>()
                                .productTypeList
                                .first;
                            Get.find<ProductController>()
                                .setSelectedCategory(null);
                            await Get.find<ProductController>().getProductList(
                              true,
                              true,
                              offset: 1,
                            );
                          },
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: NoDataScreen(text: 'no_food_available'.tr),
                          ),
                        );
            }),
          ),
        ],
      );
    });
  }

  Widget _bodyWidget() {
    return GetBuilder<ProductController>(builder: (productController) {
      int totalPage = 0;
      if (productController.productList != null) {
        totalPage = (productController.productList!.length /
                ResponsiveHelper.getLen(context))
            .ceil();
      }
      return Flexible(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SearchBarView(
                      controller: searchController, type: selectedProductType),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeDefault),
                  child: IgnorePointer(
                    ignoring: productController.productList == null,
                    child: FilterButtonWidget(
                      items: productController.productTypeList,
                      type: selectedProductType,
                      onSelected: (value) {
                        selectedProductType = value;
                        productController.setSelectedProductType = value;
                        productController.getProductList(
                          true,
                          true,
                          categoryId: productController.selectedCategory,
                          productType: value,
                          searchPattern: searchController.text.trim().isEmpty
                              ? null
                              : searchController.text,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
                height: ResponsiveHelper.isSmallTab() ? 80 : 100,
                child: CategoryView(onSelected: (id) {
                  if (productController.selectedCategory == id) {
                    productController.setSelectedCategory(null);
                  } else {
                    productController.setSelectedCategory(id);
                  }
                  productController.getProductList(
                    true,
                    true,
                    categoryId: productController.selectedCategory,
                    productType: selectedProductType,
                    searchPattern: searchController.text.trim().isEmpty
                        ? null
                        : searchController.text,
                  );
                })),
            Expanded(
              child: PageViewProduct(
                  totalPage: totalPage,
                  search: searchController.text.isEmpty
                      ? null
                      : searchController.text),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                child:
                    GetBuilder<ProductController>(builder: (productController) {
                  int totalPage = 0;
                  if (productController.productList != null) {
                    totalPage = (productController.totalSize! /
                            ResponsiveHelper.getLen(context))
                        .ceil();
                  }
                  List list = [for (var i = 0; i <= totalPage - 1; i++) i];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeLarge),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: list
                          .map(
                            (index) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                color: index ==
                                        productController.pageViewCurrentIndex
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).disabledColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(Dimensions.radiusSmall)),
                              ),
                              height: 5,
                              width: Dimensions.paddingSizeExtraLarge,
                            ),
                          )
                          .toList(),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      );
    });
  }
}
