import 'package:audioplayers/audioplayers.dart';
import 'package:efood_kitchen/controller/order_controller.dart';
import 'package:efood_kitchen/helper/responsive_helper.dart';
import 'package:efood_kitchen/util/dimensions.dart';
import 'package:efood_kitchen/util/styles.dart';
import 'package:efood_kitchen/view/base/custom_button.dart';
import 'package:efood_kitchen/view/screens/order/order_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationDialog extends StatefulWidget {
  final String title;
  final String body;
  final int orderId;
  const NotificationDialog(
      {super.key,
      required this.title,
      required this.body,
      required this.orderId});

  @override
  State<NotificationDialog> createState() => _NewRequestDialogState();
}

class _NewRequestDialogState extends State<NotificationDialog> {
  @override
  void initState() {
    super.initState();

    _startAlarm();
  }

  void _startAlarm() async {
    AudioCache audio = AudioCache();
    audio.load('notification.wav');
    
    // audio.play('notification.wav');
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
      //insetPadding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(Dimensions.paddingSizeExtraLarge),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.notifications_active,
              size: 60, color: Theme.of(context).primaryColor),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeLarge),
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
            ),
          ),
          const SizedBox(height: Dimensions.paddingSizeSmall),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeLarge),
            child: Text(
              widget.body,
              textAlign: TextAlign.center,
              style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge),
            ),
          ),
          const SizedBox(height: Dimensions.paddingSizeLarge),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Flexible(
              child: SizedBox(
                  width: 120,
                  height: 40,
                  child: TextButton(
                    onPressed: () => Get.back(),
                    style: TextButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).disabledColor.withOpacity(0.3),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radiusSmall)),
                    ),
                    child: Text(
                      'cancel'.tr,
                      textAlign: TextAlign.center,
                      style: robotoBold.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge?.color),
                    ),
                  )),
            ),
            const SizedBox(width: 20),
            Flexible(
                child: SizedBox(
              width: 120,
              child: CustomButton(
                height: 40,
                buttonText: 'view'.tr,
                onPressed: () {
                  Get.back();

                  if (ResponsiveHelper.isMobile(context)) {
                    Get.to(() => OrderDetailsScreen(
                          orderId: widget.orderId,
                        ));
                  } else {
                    Get.find<OrderController>()
                        .getOrderDetails(widget.orderId)
                        .then((orderModel) => Get.find<OrderController>()
                                .setOrderIdForOrderDetails(
                              widget.orderId,
                              orderModel.order.orderStatus,
                              orderModel.order.orderNote,
                            ));
                  }
                },
              ),
            )),
          ]),
        ]),
      ),
    );
  }
}
