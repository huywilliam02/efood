import 'package:citgroupvn_efood_table/app/helper/responsive_helper.dart';
import 'package:get/get.dart';

class Dimensions {
  static double fontSizeExtraSmall = Get.context!.width >= 1300
      ? 14
      : ResponsiveHelper.isSmallTab()
          ? 8
          : 10;
  static double fontSizeSmall = Get.context!.width >= 1300
      ? 16
      : ResponsiveHelper.isSmallTab()
          ? 10
          : 12;
  static double fontSizeDefault = Get.context!.width >= 1300
      ? 18
      : ResponsiveHelper.isSmallTab()
          ? 12
          : 14;
  static double fontSizeLarge = Get.context!.width >= 1300
      ? 20
      : ResponsiveHelper.isSmallTab()
          ? 14
          : 16;
  static double fontSizeExtraLarge = Get.context!.width >= 1300
      ? 22
      : ResponsiveHelper.isSmallTab()
          ? 16
          : 18;
  static double fontSizeOverLarge = Get.context!.width >= 1300
      ? 28
      : ResponsiveHelper.isSmallTab()
          ? 20
          : 24;

  static double paddingSizeExtraSmall = ResponsiveHelper.isSmallTab() ? 3 : 5.0;
  static double paddingSizeSmall = ResponsiveHelper.isSmallTab() ? 7 : 10.0;
  static double paddingSizeDefault = ResponsiveHelper.isSmallTab() ? 12 : 15.0;
  static double paddingSizeLarge = ResponsiveHelper.isSmallTab() ? 18 : 20.0;
  static double paddingSizeExtraLarge =
      ResponsiveHelper.isSmallTab() ? 20 : 25.0;

  static const double radiusSmall = 5.0;
  static const double radiusDefault = 10.0;
  static const double radiusLarge = 15.0;
  static double radiusExtraLarge = ResponsiveHelper.isSmallTab() ? 15 : 20.0;

  static const double webMaxWidth = 1170;
}
