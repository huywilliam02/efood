import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:citgroupvn_eshop_seller/localization/language_constrants.dart';
import 'package:citgroupvn_eshop_seller/provider/splash_provider.dart';
import 'package:citgroupvn_eshop_seller/provider/theme_provider.dart';
import 'package:citgroupvn_eshop_seller/utill/dimensions.dart';
import 'package:citgroupvn_eshop_seller/utill/images.dart';
import 'package:citgroupvn_eshop_seller/utill/styles.dart';
import 'package:citgroupvn_eshop_seller/view/base/custom_app_bar.dart';
import 'package:citgroupvn_eshop_seller/view/base/custom_dialog.dart';
import 'package:citgroupvn_eshop_seller/view/screens/langulage/change_language.dart';
import 'package:citgroupvn_eshop_seller/view/screens/settings/widget/choose_shipping_dialog.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<SplashProvider>(context, listen: false).setFromSetting(true);

    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated('settings', context),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
          TitleButton(
            icon: Images.language,
            title: getTranslated('choose_language', context),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => const ChooseLanguageScreen())),
          ),
          Provider.of<SplashProvider>(context, listen: false)
                      .configModel!
                      .shippingMethod ==
                  'sellerwise_shipping'
              ? TitleButton(
                  icon: Images.ship,
                  title: '${getTranslated('shipping_setting', context)}',
                  onTap: () =>
                      showAnimatedDialog(context, const ChooseShippingDialog()),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

class TitleButton extends StatelessWidget {
  final String icon;
  final String? title;
  final Function onTap;
  const TitleButton(
      {Key? key, required this.icon, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: Dimensions.paddingSizeExtraSmall),
      child: InkWell(
        onTap: onTap as void Function()?,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                  color: Provider.of<ThemeProvider>(context, listen: false)
                          .darkTheme
                      ? Theme.of(context).primaryColor.withOpacity(0)
                      : Colors.grey[
                          Provider.of<ThemeProvider>(context).darkTheme
                              ? 800
                              : 200]!,
                  spreadRadius: 0.5,
                  blurRadius: 0.3)
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: Dimensions.paddingSizeDefault,
                horizontal: Dimensions.paddingSizeLarge),
            child: Row(
              children: [
                SizedBox(
                    width: Dimensions.iconSizeLarge,
                    height: Dimensions.iconSizeLarge,
                    child: Image.asset(icon)),
                const SizedBox(
                  width: Dimensions.paddingSizeSmall,
                ),
                Text(title!,
                    style: titilliumRegular.copyWith(
                        fontSize: Dimensions.fontSizeLarge)),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).primaryColor,
                  size: Dimensions.iconSizeSmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
