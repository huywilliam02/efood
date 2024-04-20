import 'package:efood_kitchen/controller/order_controller.dart';
import 'package:efood_kitchen/data/model/response/order_details_model.dart';
import 'package:efood_kitchen/helper/price_converter.dart';
import 'package:efood_kitchen/helper/responsive_helper.dart';
import 'package:efood_kitchen/util/dimensions.dart';
import 'package:efood_kitchen/util/styles.dart';
import 'package:efood_kitchen/view/base/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalculateAmountWidget extends StatelessWidget {
  final OrderController orderController;
  const CalculateAmountWidget({Key? key, required this.orderController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deliveryCharge = orderController.orderDetails.order.deliveryCharge?.toDouble() ?? 0;
    double couponDiscount = orderController.orderDetails.order.couponDiscountAmount?.toDouble() ?? 0;
    double extraDiscount = orderController.orderDetails.order.extraDiscount?.toDouble() ?? 0;
    double itemsPrice = 0;
    double discount = 0;
    double tax = 0;
    double addOns = 0;

    for(Details orderDetails in orderController.orderDetails.details) {
      itemsPrice = itemsPrice + (orderDetails.price! * orderDetails.quantity!);
      discount = discount + (orderDetails.discountOnProduct! * orderDetails.quantity!);
      tax = tax + (orderDetails.taxAmount! * orderDetails.quantity!) + orderDetails.addonTaxAmount!;

      List<int> ids = orderDetails.addOnIds ?? [];

      if(ids.length == orderDetails.addOnPrices?.length &&
          ids.length == orderDetails.addOnQtys?.length){
        for(int i = 0; i < ids.length; i++){
          addOns = addOns + (orderDetails.addOnPrices![i] * orderDetails.addOnQtys![i]);
        }
      }
    }



    double subTotal = itemsPrice;
    double total = (itemsPrice + addOns + tax + deliveryCharge) - (discount + couponDiscount + extraDiscount);

    return Column(children: [
      CalculateItem(title: 'items_price',amount: subTotal),
      if(couponDiscount > 0) CalculateItem(title: 'coupon_discount',amount: couponDiscount, isDiscount: true),
      CalculateItem(title: 'addons_price',amount: addOns),
      CalculateItem(title: 'discount',amount: discount, isDiscount: true),
      if(extraDiscount > 0) CalculateItem(title: 'extra_discount'.tr,amount: extraDiscount, isDiscount: true),

      CalculateItem(title: 'vat_tax',amount: tax),
     if(deliveryCharge > 0) CalculateItem(title: 'delivery_charge',amount: deliveryCharge),
      const CustomDivider(),
      const SizedBox(height: Dimensions.paddingSizeSmall),
      CalculateItem(title: 'total',amount: total, isTotal: true),
    ],);
  }
}
class CalculateItem extends StatelessWidget {
  final String title;
  final double amount;
  final bool isTotal;
  final bool isDiscount;
  const CalculateItem({
    Key? key, required this.title, required this.amount,
    this.isTotal = false, this.isDiscount = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmall =  ResponsiveHelper.isSmallTab();
    return Padding(
      padding:  EdgeInsets.only(
        bottom: isSmall ?
        Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeDefault,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        isTotal?
        Text(title.tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge)):
        Text(title.tr, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),

        isTotal?
        Text(PriceConverter.convertPrice(context, amount),
          style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
        ):Text('${isDiscount ? '(-) ' : ''}${PriceConverter.convertPrice(context, amount)}',
          style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge),
        ),
      ]),
    );
  }
}
