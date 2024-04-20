import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';

class ResponsiveHelper {

  static bool isMobilePhone() {
    if (!kIsWeb) {
      return true;
    }else {
      return false;
    }
  }

  static bool isWeb() {
    return kIsWeb;
  }

  static bool isMobile(context) {
    final size = MediaQuery.of(context).size.width;
    if (size < 650) {
      return true;
    } else {
      return false;
    }
  }

  static bool isTab(context) {
    final size = MediaQuery.of(context).size.width;
    if (size < 1400 && size >= 650) {
      return true;
    } else {
      return false;
    }
  }

  static bool isDesktop(context) {
    final size = MediaQuery
        .of(context)
        .size
        .width;
    if (size >= 1300) {
      return true;
    } else {
      return false;
    }
  }

  static bool isSmallTab() => ResponsiveHelper.isTab(Get.context) && Get.context!.width < 970;

}