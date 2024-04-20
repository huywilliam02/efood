import 'package:efood_kitchen/helper/responsive_helper.dart';
import 'package:efood_kitchen/util/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackBar(String message, {bool isError = true}) {
  if(message.isNotEmpty) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: isError ? Colors.red : Colors.green,
      message: message,
      maxWidth: Dimensions.webMaxWidth,
      duration: const Duration(seconds: 3),
      snackStyle: SnackStyle.FLOATING,
      margin: ResponsiveHelper.isTab(Get.context)? EdgeInsets.symmetric(horizontal : Get.width/4) : const EdgeInsets.all(Dimensions.paddingSizeSmall),
      borderRadius: Dimensions.radiusSmall,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    ));
  }
}