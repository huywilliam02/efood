import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:citgroupvn_eshop_seller/data/model/response/refund_model.dart';
import 'package:citgroupvn_eshop_seller/localization/language_constrants.dart';
import 'package:citgroupvn_eshop_seller/provider/splash_provider.dart';
import 'package:citgroupvn_eshop_seller/provider/theme_provider.dart';
import 'package:citgroupvn_eshop_seller/utill/color_resources.dart';
import 'package:citgroupvn_eshop_seller/utill/dimensions.dart';
import 'package:citgroupvn_eshop_seller/utill/images.dart';
import 'package:citgroupvn_eshop_seller/utill/styles.dart';
import 'package:citgroupvn_eshop_seller/view/base/custom_image.dart';

class CustomerInfoWidget extends StatelessWidget {
  final RefundModel? refundModel;
  const CustomerInfoWidget({Key? key, this.refundModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault,
          vertical: Dimensions.paddingSizeMedium),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
              color: Colors.grey[
                  Provider.of<ThemeProvider>(context).darkTheme ? 800 : 200]!,
              spreadRadius: 0.5,
              blurRadius: 0.3)
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(getTranslated('customer_information', context)!,
            style: robotoMedium.copyWith(
                color: ColorResources.getTextColor(context))),
        const SizedBox(height: Dimensions.paddingSizeMedium),
        Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CustomImage(
                    width: 50,
                    height: 50,
                    image:
                        '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.customerImageUrl}/${refundModel!.customer!.image}')),
            const SizedBox(width: Dimensions.paddingSizeSmall),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    '${refundModel!.customer!.fName ?? ''} ${refundModel!.customer!.lName ?? ''}',
                    style: robotoMedium.copyWith(
                        color: ColorResources.getTextColor(context),
                        fontSize: Dimensions.fontSizeDefault)),
                const SizedBox(
                  height: Dimensions.paddingSizeExtraSmall,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                      child: Image.asset(Images.callI),
                    ),
                    const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                    Text('${refundModel!.customer!.phone}',
                        style: titilliumRegular.copyWith(
                            color: ColorResources.titleColor(context),
                            fontSize: Dimensions.fontSizeDefault)),
                  ],
                ),
                const SizedBox(
                  height: Dimensions.paddingSizeSmall,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                      child: Image.asset(Images.emailI),
                    ),
                    const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                    Text(refundModel!.customer!.email ?? '',
                        style: titilliumRegular.copyWith(
                            color: ColorResources.titleColor(context),
                            fontSize: Dimensions.fontSizeDefault)),
                  ],
                ),
              ],
            ))
          ],
        )
      ]),
    );
  }
}
