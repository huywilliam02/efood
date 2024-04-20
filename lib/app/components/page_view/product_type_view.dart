import 'package:citgroupvn_efood_table/app/modules/splash/controller/splash_controller.dart';
import 'package:citgroupvn_efood_table/app/resources/dimens/dimensions.dart';
import 'package:citgroupvn_efood_table/app/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductTypeView extends StatelessWidget {
  final String? productType;
  const ProductTypeView({Key? key, this.productType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isVegNonVegActive =
        Get.find<SplashController>().configModel!.isVegNonVegActive!;
    return productType == null || !isVegNonVegActive
        ? const SizedBox()
        : Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                  Radius.circular(Dimensions.radiusSmall)),
              color: Theme.of(context).primaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2),
              child: Text(
                productType!.tr,
                style: robotoRegular.copyWith(color: Colors.white),
              ),
            ),
          );
  }
}
