import 'package:citgroupvn_efood_table/data/model/response/oders_list_details.dart';
import 'package:citgroupvn_efood_table/app/modules/order/payment.dart';

class DetailsOrderScreen extends StatefulWidget {
  final bool fromPlaceOrder;

  const DetailsOrderScreen({
    Key? key,
    this.fromPlaceOrder = false,
  }) : super(key: key);

  @override
  State<DetailsOrderScreen> createState() => _DetailsOrderScreenState();
}

class _DetailsOrderScreenState extends State<DetailsOrderScreen> {
  int currentMinute = 0;

  @override
  void initState() {
    // print('order success call');
    // Get.find<OrderController>().getOrderSuccessModel();
    Get.find<OrderController>().setCurrentOrderId = null;

    Get.find<OrderController>().getOrderList().then((List<Order>? list) {
      if (list != null && list.isNotEmpty) {
        Get.find<OrderController>().getCurrentOrder('${list.first.id}').then(
              (value) => Get.find<OrderController>().countDownTimer(),
            );
      } else {
        Get.find<OrderController>().getCurrentOrder(null);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    Get.find<OrderController>().cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveHelper.isTab(context)
          ? null
          : const CustomAppBar(
              isBackButtonExist: false,
              onBackPressed: null,
              showCart: true,
            ),
      body: !ResponsiveHelper.isTab(context)
          ? _body(context)
          : BodyTemplate(
              body: Flexible(child: _body(context)),
              isOrderDetails: true,
            ),
    );
  }

  Center _body(BuildContext context) {
    return Center(
      child: GetBuilder<OrderController>(builder: (orderController) {
        int days = 0, hours = 0, minutes = 0;
        days = orderController.duration.inDays;
        hours = orderController.duration.inHours - days * 24;
        minutes = orderController.duration.inMinutes -
            (24 * days * 60) -
            (hours * 60);

        return orderController.isLoading
            ? Center(child: CustomLoader(color: Theme.of(context).primaryColor))
            : orderController.currentOrderDetails == null &&
                    !orderController.isLoading
                ? NoDataScreen(text: 'you_hove_no_order'.tr)
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).viewPadding.top + 55,
                      ),
                      Column(
                        children: [
                          orderController.currentOrderDetails != null
                              ? Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    minutes < 5
                                        ? 'be_prepared_your_food'.tr
                                        : 'your_food_delivery'.tr,
                                    style: robotoRegular.copyWith(
                                        color: Theme.of(context).hintColor),
                                    maxLines: 10,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center, // Đặt căn giữa
                                  ),
                                )
                              : Text(
                                  'your_order_has_been_received'.tr,
                                  style: robotoRegular.copyWith(
                                      fontSize: Dimensions.fontSizeExtraLarge),
                                ),
                          Lottie.asset(
                            width: 100,
                            fit: BoxFit.fitWidth,
                            Images.successAnimation,
                          ),
                          Text(
                            'estimated_serving_time'.tr,
                            style: robotoRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color:
                                  Theme.of(context).textTheme.titleSmall!.color,
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.paddingSizeDefault,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${minutes < 5 ? 0 : minutes - 5} - ${minutes < 5 ? 5 : minutes}',
                                style: robotoBold.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 35,
                                ),
                              ),
                              SizedBox(
                                width: Dimensions.paddingSizeSmall,
                              ),
                              Text(
                                'min_s'.tr,
                                style: robotoBold.copyWith(
                                  fontSize: 35,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Dimensions.paddingSizeDefault,
                          ),
                          if (!ResponsiveHelper.isTab(context))
                            CustomButton(
                              width: 300,
                              height: ResponsiveHelper.isSmallTab() ? 40 : 50,
                              buttonText: 'order_details'.tr,
                              fontSize: Dimensions.fontSizeDefault,
                              onPressed: () => Get.to(() => const OrderScreen(
                                    isOrderDetails: true,
                                  )),
                            ),
                        ],
                      ),
                    ],
                  );
      }),
    );
  }
}
