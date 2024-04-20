import 'package:citgroupvn_efood_table/app/modules/product_image/product_controller.dart';
import 'package:citgroupvn_efood_table/data/model/response/product_model.dart';
import 'package:citgroupvn_efood_table/app/resources/dimens/dimensions.dart';
import 'package:citgroupvn_efood_table/app/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockTagView extends StatelessWidget {
  final Product product;
  const StockTagView({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find<ProductController>();

    return !productController.checkStock(product)
        ? Positioned.fill(
            child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                    gradient: LinearGradient(colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.black.withOpacity(0.35),
                    ]),
                  ),
                  child: Text('out_of_stock'.tr,
                      textAlign: TextAlign.center,
                      style: robotoRegular.copyWith(
                          color: Colors.white,
                          fontSize: Dimensions.fontSizeSmall)),
                )))
        : const SizedBox();
  }
}
