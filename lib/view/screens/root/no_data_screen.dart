import 'package:efood_kitchen/util/dimensions.dart';
import 'package:efood_kitchen/util/images.dart';
import 'package:efood_kitchen/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoDataScreen extends StatelessWidget {
  final bool isCart;
  final String text;
  const NoDataScreen({super.key, required this.text, this.isCart = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.stretch, children: [

        Image.asset(
          isCart ? Images.emptyCart : Images.emptyBox,
          width: MediaQuery.of(context).size.height*0.22, height: MediaQuery.of(context).size.height*0.22,
        ),
        SizedBox(height: MediaQuery.of(context).size.height*0.03),

        Text(
          isCart ? 'cart_is_empty'.tr : text,
          style: robotoMedium.copyWith(fontSize: MediaQuery.of(context).size.height*0.0175, color: Theme.of(context).disabledColor),
          textAlign: TextAlign.center,
        ),

      ]),
    );
  }
}
