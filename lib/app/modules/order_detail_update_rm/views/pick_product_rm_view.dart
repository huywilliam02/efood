import 'package:citgroupvn_efood_table/app/components/custom_loader.dart';
import 'package:citgroupvn_efood_table/app/components/dialog/confirmation_dialog.dart';
import 'package:citgroupvn_efood_table/app/helper/dia_log_helper.dart';
import 'package:citgroupvn_efood_table/app/modules/home/widget/category_view.dart';
import 'package:citgroupvn_efood_table/app/modules/home/widget/filter_button_widget.dart';
import 'package:citgroupvn_efood_table/app/modules/home/widget/product_shimmer_list.dart';
import 'package:citgroupvn_efood_table/app/modules/home/widget/product_widget.dart';
import 'package:citgroupvn_efood_table/app/modules/order_detail_update_rm/controllers/order_detail_update_rm_controller.dart';
import 'package:citgroupvn_efood_table/app/modules/promotional_page/promotional.dart';
import 'package:citgroupvn_efood_table/app/modules/root/no_data_screen.dart';
import 'package:citgroupvn_efood_table/base/base_view.dart';
import 'package:flutter/material.dart';

class PickProduct extends BaseView<OrderDetailUpdateRmController> {
  const PickProduct({Key? key}) : super(key: key);
  @override
  Widget buildView(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: CustomButton(
          width: 300,
          // height: 50,
          buttonText: "Cập nhật",
          fontSize: Dimensions.fontSizeDefault,
          onPressed: () {
            controller.clearTemp();
            Get.back();
            // Get.to(
            //   () => CartUpdateView(
            //     isOrderDetails: true,
            //     oderId: controller.orderId.toString(),
            //   ),
            // );
          }),
      appBar: ResponsiveHelper.isTab(context)
          ? null
          : const CustomAppBar(
              isBackButtonExist: false,
              onBackPressed: null,
              showCart: false,
            ),
      body: homeMobileView(),
    );
  }

  Widget homeMobileView() {
    final _scrollController = ScrollController();
    TextEditingController searchController = TextEditingController();
    String selectedProductType = 'non_veg';
    return GetBuilder<ProductController>(builder: (productController) {
      return Column(
        children: <Widget>[
          SizedBox(
            height: Dimensions.paddingSizeDefault,
          ),
          // Padding(
          //   padding:
          //       EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
          //   child: SearchBarView(
          //       controller: searchController, type: selectedProductType),
          // ),
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
                                                .productList![index]!,
                                          )
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
                                  color: Theme.of(Get.context!).primaryColor,
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
}
