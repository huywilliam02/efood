import 'package:efood_kitchen/helper/responsive_helper.dart';

class Dimensions {
  static double fontSizeExtraSmall = ResponsiveHelper.isSmallTab() ? 5 : 8;
  static double fontSizeSmall = ResponsiveHelper.isSmallTab() ? 8 : 10;
  static double fontSizeDefault = ResponsiveHelper.isSmallTab() ? 12 : 14;
  static double fontSizeLarge = ResponsiveHelper.isSmallTab() ? 14 : 16;
  static double fontSizeExtraLarge = ResponsiveHelper.isSmallTab() ? 16 : 18;
  static double fontSizeOverLarge = ResponsiveHelper.isSmallTab() ? 20 : 24;

  static const double paddingSizeTinySmall = 2.0;
  static const double paddingSizeExtraSmall = 5.0;
  static const double paddingSizeTabs = 7.0;
  static const double paddingSizeSmall = 10.0;
  static const double paddingSizeDefault = 15.0;
  static const double paddingSizeLarge = 20.0;
  static const double paddingSizeExtraLarge = 25.0;

  static const double radiusSmall = 5.0;
  static const double radiusDefault = 10.0;
  static const double radiusLarge = 15.0;
  static const double radiusExtraLarge = 20.0;

  static const double iconSize = 20.0;
  static const double statusUpdateButtonWeight = 350.0;
  static const double statusUpdateButtonHeight = 70.0;

  static const double webMaxWidth = 1170;
}