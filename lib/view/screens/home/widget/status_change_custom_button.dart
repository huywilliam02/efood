import 'dart:math';
import 'package:efood_kitchen/controller/localization_controller.dart';
import 'package:efood_kitchen/controller/order_controller.dart';
import 'package:efood_kitchen/helper/responsive_helper.dart';
import 'package:efood_kitchen/util/dimensions.dart';
import 'package:efood_kitchen/util/images.dart';
import 'package:efood_kitchen/view/screens/home/widget/slider_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class StatusChangeCustomButton extends StatelessWidget {
  final int  orderId;
  final String orderStatus;
  const StatusChangeCustomButton({Key? key, required this.orderId, required this.orderStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Get.find<OrderController>().orderStatus == 'confirmed' || orderStatus == 'confirmed'?
    Container(
      margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      height: ResponsiveHelper.isSmallTab() ? 40 : 50,
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
        border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.5)),
        color: Theme.of(context).cardColor,
      ),
      child: Transform.rotate(
        angle: Get.find<LocalizationController>().isLtr ? pi * 2 : pi, // in radians
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: SliderButton(
            width: ResponsiveHelper.isSmallTab() ? 200 : ResponsiveHelper.isTab(context) ? 300 :  Get.width - 20,

            dismissible: false,
            action: () {
              Get.find<OrderController>().updateOrderStatusTabs(OrderStatusTabs.cooking);
              Get.find<OrderController>().orderStatusUpdate(orderId, 'cooking');
              Get.find<OrderController>().setOrderIdForOrderDetails(orderId, 'cooking','');
              Get.find<OrderController>().getOrderDetails(orderId);
            },


            label: Text('start_cooking'.tr,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).primaryColor,
                fontSize: Dimensions.fontSizeDefault,
              )),
            dismissThresholds: 0.5,
            icon: Center(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(Images.arrowButton),
            )),

            radius: 10,

            boxShadow: const BoxShadow(blurRadius: 0.0),
            buttonColor: Theme.of(context).primaryColor,
            backgroundColor: Theme.of(context).cardColor,
            baseColor: Theme.of(context).primaryColor,
          ),
        ),
      ),
    )
        : Get.find<OrderController>().orderStatus == 'cooking'  || orderStatus == 'cooking'?
    Container(
      height: ResponsiveHelper.isSmallTab() ? 40 : 50,
      margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
        border: Border.all(color: Theme.of(context).secondaryHeaderColor.withOpacity(.5)),
        color: Theme.of(context).cardColor,),
      child: Transform.rotate(
        angle: Get.find<LocalizationController>().isLtr ? pi * 2 : pi, // in radians
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: SliderButton(
            width: ResponsiveHelper.isSmallTab() ? 200 : ResponsiveHelper.isTab(context) ? 300 :  Get.width - 20,
            dismissible: false,
            action: () {
              Get.find<OrderController>().updateOrderStatusTabs(OrderStatusTabs.done);
              Get.find<OrderController>().orderStatusUpdate(orderId, 'done');
              Get.find<OrderController>().setOrderIdForOrderDetails(orderId, 'done','');
              Get.find<OrderController>().getOrderDetails(orderId);
            },

            label: Text('done_cooking'.tr,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: Dimensions.fontSizeDefault,

              )),
            dismissThresholds: 0.5,
            icon: Center(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(Images.arrowButton),
            )),

            radius: 10,
            boxShadow: const BoxShadow(blurRadius: 0.0),
            buttonColor: Theme.of(context).secondaryHeaderColor,
            backgroundColor: Theme.of(context).cardColor,
            baseColor: Theme.of(context).secondaryHeaderColor,
          ),
        ),
      ),
    )
        : const SizedBox.shrink();
  }
}
