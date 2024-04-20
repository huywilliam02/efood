import 'package:efood_kitchen/controller/order_controller.dart';
import 'package:efood_kitchen/helper/responsive_helper.dart';
import 'package:efood_kitchen/util/dimensions.dart';
import 'package:efood_kitchen/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingStatusTabItem extends StatelessWidget {
  const BookingStatusTabItem({Key? key, required this.title}) : super(key: key);
  final String title;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: MediaQuery.of(context).size.width > 650 && MediaQuery.of(context).size.width < 1200?
      const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall):
      const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      decoration: BoxDecoration(
          color: Get.find<OrderController>().selectedBookingStatus.name != title? Colors.transparent : Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeExtraSmall))
      ),
      child: Row(
        children: [
          Text(title.tr, textAlign: TextAlign.center, style : robotoRegular.copyWith(fontSize: ResponsiveHelper.isSmallTab() ? Dimensions.fontSizeDefault : Dimensions.fontSizeSmall,
              color: Get.find<OrderController>().selectedBookingStatus.name != title? Theme.of(context).textTheme.bodyLarge!.color: Colors.white))
          //Color(0xFF758590)
        ],
      ),
    );
  }
}