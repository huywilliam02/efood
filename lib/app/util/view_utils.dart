import 'dart:developer';

import 'package:citgroupvn_efood_table/app/core/constants/duration_constants.dart';
import 'package:citgroupvn_efood_table/app/util/object_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class ViewUtils {
  const ViewUtils._();
  static void showSnackbarMessage(String message, bool isSuccess) {
    Get.snackbar(
      'Thông báo',
      message,
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(seconds: 2),
      icon: isSuccess
          ? Image.asset("assets/icons/checked.png", height: 30, width: 20)
          : Image.asset("assets/icons/close.png", height: 30, width: 20),
      backgroundColor: isSuccess ? Colors.green.withOpacity(0.7) : Colors.red,
      colorText: Colors.white,
      margin: const EdgeInsets.all(15),
      // snackPosition: SnackPosition.BOTTOM,
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  static void handleError() {
    Get.back();
    Get.snackbar(
      "Lỗi",
      "Có gì đó không đúng",
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
      colorText: Colors.white,
    );
  }

 static void handleInitError(dynamic error) {
    Get.back();
    Get.snackbar("Initialization Error", error.toString());
    log(error.toString());
  }


  static void showAppSnackBar(
    BuildContext context,
    String message, {
    Duration? duration,
    Color? backgroundColor,
  }) {
    final messengerState = ScaffoldMessenger.maybeOf(context);
    if (messengerState == null) {
      return;
    }
    messengerState.hideCurrentSnackBar();
    messengerState.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? DurationConstants.defaultSnackBarDuration,
        backgroundColor: backgroundColor,
      ),
    );
  }

  static void hideKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  static Future<void> setPreferredOrientations(
      List<DeviceOrientation> orientations) {
    return SystemChrome.setPreferredOrientations(orientations);
  }

  /// set status bar color & navigation bar color
  static void setSystemUIOverlayStyle(
      SystemUiOverlayStyle systemUiOverlayStyle) {
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  static Offset? getWidgetPosition(GlobalKey globalKey) {
    return (globalKey.currentContext?.findRenderObject() as RenderBox?)
        ?.let((it) => it.localToGlobal(Offset.zero));
  }

  static double? getWidgetWidth(GlobalKey globalKey) {
    return (globalKey.currentContext?.findRenderObject() as RenderBox?)
        ?.let((it) => it.size.width);
  }

  static double? getWidgetHeight(GlobalKey globalKey) {
    return (globalKey.currentContext?.findRenderObject() as RenderBox?)
        ?.let((it) => it.size.height);
  }
}
