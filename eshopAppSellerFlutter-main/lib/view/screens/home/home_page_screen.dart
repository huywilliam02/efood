import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:citgroupvn_eshop_seller/data/model/response/product_model.dart';
import 'package:citgroupvn_eshop_seller/provider/bank_info_provider.dart';
import 'package:citgroupvn_eshop_seller/provider/delivery_man_provider.dart';
import 'package:citgroupvn_eshop_seller/provider/order_provider.dart';
import 'package:citgroupvn_eshop_seller/provider/product_provider.dart';
import 'package:citgroupvn_eshop_seller/provider/profile_provider.dart';
import 'package:citgroupvn_eshop_seller/provider/shipping_provider.dart';
import 'package:citgroupvn_eshop_seller/provider/splash_provider.dart';
import 'package:citgroupvn_eshop_seller/utill/color_resources.dart';
import 'package:citgroupvn_eshop_seller/utill/dimensions.dart';
import 'package:citgroupvn_eshop_seller/utill/images.dart';
import 'package:citgroupvn_eshop_seller/utill/styles.dart';
import 'package:citgroupvn_eshop_seller/view/base/custom_loader.dart';
import 'package:citgroupvn_eshop_seller/view/screens/home/widget/chart_widget.dart';
import 'package:citgroupvn_eshop_seller/view/screens/home/widget/completed_order_widget.dart';
import 'package:citgroupvn_eshop_seller/view/screens/home/widget/on_going_order_widget.dart';
import 'package:citgroupvn_eshop_seller/view/screens/home/widget/stock_out_product_widget.dart';
import 'package:citgroupvn_eshop_seller/view/screens/notification/notification_screen.dart';
import 'package:citgroupvn_eshop_seller/view/screens/product/most_popular_product.dart';
import 'package:citgroupvn_eshop_seller/view/screens/product/top_selling_product.dart';
import 'package:citgroupvn_eshop_seller/view/screens/top_delivery_man/top_delivery_man_view.dart';

class HomePageScreen extends StatefulWidget {
  final Function? callback;
  const HomePageScreen({Key? key, this.callback}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final ScrollController _scrollController = ScrollController();
  Future<void> _loadData(BuildContext context, bool reload) async {
    Provider.of<ProfileProvider>(context, listen: false).getSellerInfo();
    Provider.of<BankInfoProvider>(context, listen: false).getBankInfo(context);
    Provider.of<OrderProvider>(context, listen: false)
        .getOrderList(context, 1, 'all');
    Provider.of<OrderProvider>(context, listen: false)
        .getAnalyticsFilterData(context, 'overall');
    Provider.of<SplashProvider>(context, listen: false).getColorList();
    Provider.of<ProductProvider>(context, listen: false)
        .getStockOutProductList(1, 'en');
    Provider.of<ProductProvider>(context, listen: false)
        .getMostPopularProductList(1, context, 'en');
    Provider.of<ProductProvider>(context, listen: false)
        .getTopSellingProductList(1, context, 'en');
    Provider.of<ShippingProvider>(context, listen: false)
        .getCategoryWiseShippingMethod();
    Provider.of<ShippingProvider>(context, listen: false)
        .getSelectedShippingMethodType(context);
    Provider.of<DeliveryManProvider>(context, listen: false)
        .getTopDeliveryManList(context);
    Provider.of<BankInfoProvider>(context, listen: false)
        .getDashboardRevenueData(context, 'yearEarn');
    Provider.of<ProfileProvider>(context, listen: false).getNotificationList(1);
  }

  @override
  void initState() {
    _loadData(context, false);
    Provider.of<OrderProvider>(context, listen: false)
        .setAnalyticsFilterName(context, 'overall', false);
    Provider.of<OrderProvider>(context, listen: false)
        .setAnalyticsFilterType(0, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double limitedStockCardHeight = MediaQuery.of(context).size.width / 1.4;
    return Scaffold(
      body: Consumer<OrderProvider>(
        builder: (context, order, child) {
          return order.orderModel != null
              ? RefreshIndicator(
                  onRefresh: () async {
                    Provider.of<OrderProvider>(context, listen: false)
                        .setAnalyticsFilterName(context, 'overall', true);
                    Provider.of<OrderProvider>(context, listen: false)
                        .setAnalyticsFilterType(0, true);
                    await _loadData(context, true);
                  },
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverAppBar(
                        pinned: true,
                        floating: true,
                        elevation: 0,
                        centerTitle: false,
                        automaticallyImplyLeading: false,
                        backgroundColor: Theme.of(context).highlightColor,
                        title: Image.asset(Images.logoWithAppName, height: 35),
                        actions: [
                          Consumer<ProfileProvider>(
                              builder: (context, profileProvider, _) {
                            return InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const NotificationScreen())),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        Dimensions.paddingSizeDefault,
                                        Dimensions.paddingSizeSmall,
                                        Dimensions.paddingSizeDefault,
                                        0),
                                    child: Icon(CupertinoIcons.bell,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  Positioned(
                                      top: 5,
                                      right: 18,
                                      child: Align(
                                          alignment: Alignment.topRight,
                                          child: CircleAvatar(
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .error,
                                            radius: 8,
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(1.0),
                                                child: Text(
                                                  '${profileProvider.notificationModel?.newNotificationItem ?? 0}',
                                                  style: robotoRegular.copyWith(
                                                      fontSize: Dimensions
                                                          .fontSizeExtraSmall,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ))),
                                ],
                              ),
                            );
                          })
                        ],
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            OngoingOrderWidget(
                              callback: widget.callback,
                            ),
                            CompletedOrderWidget(callback: widget.callback),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            Consumer<ProductProvider>(
                                builder: (context, prodProvider, child) {
                              List<Product> productList;
                              productList = prodProvider.stockOutProductList;
                              return productList.isNotEmpty
                                  ? Container(
                                      height: limitedStockCardHeight,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        boxShadow: [
                                          BoxShadow(
                                              color: ColorResources.getPrimary(
                                                      context)
                                                  .withOpacity(.05),
                                              spreadRadius: -3,
                                              blurRadius: 12,
                                              offset:
                                                  Offset.fromDirection(0, 6))
                                        ],
                                      ),
                                      child: StockOutProductView(
                                          scrollController: _scrollController,
                                          isHome: true))
                                  : const SizedBox();
                            }),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            const ChartWidget(),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            const TopSellingProductScreen(isMain: true),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            Container(
                                color: Theme.of(context).primaryColor,
                                child: const MostPopularProductScreen(
                                    isMain: true)),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            const TopDeliveryManView(isMain: true)
                          ],
                        ),
                      )
                    ],
                  ),
                )
              : const CustomLoader();
        },
      ),
    );
  }
}
