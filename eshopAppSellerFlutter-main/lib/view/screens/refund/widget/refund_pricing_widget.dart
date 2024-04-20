import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:citgroupvn_eshop_seller/helper/price_converter.dart';
import 'package:citgroupvn_eshop_seller/localization/language_constrants.dart';
import 'package:citgroupvn_eshop_seller/provider/refund_provider.dart';
import 'package:citgroupvn_eshop_seller/utill/dimensions.dart';
import 'package:citgroupvn_eshop_seller/utill/styles.dart';
import 'package:citgroupvn_eshop_seller/view/base/custom_divider.dart';
import 'package:citgroupvn_eshop_seller/view/screens/refund/widget/refund_details.dart';

class RefundPricingWidget extends StatelessWidget {
  const RefundPricingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
        child: Consumer<RefundProvider>(builder: (context, refund, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeSmall),
            child: refund.refundDetailsModel != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        ProductCalculationItem(
                          title: 'product_price',
                          price: refund.refundDetailsModel!.productPrice,
                          isQ: true,
                          isPositive: true,
                        ),
                        const SizedBox(
                          height: Dimensions.paddingSizeSmall,
                        ),
                        ProductCalculationItem(
                          title: 'product_discount',
                          price:
                              refund.refundDetailsModel!.productTotalDiscount,
                          isNegative: true,
                        ),
                        const SizedBox(
                          height: Dimensions.paddingSizeSmall,
                        ),
                        ProductCalculationItem(
                          title: 'coupon_discount',
                          price: refund.refundDetailsModel!.couponDiscount,
                          isNegative: true,
                        ),
                        const SizedBox(
                          height: Dimensions.paddingSizeSmall,
                        ),
                        ProductCalculationItem(
                          title: 'product_tax',
                          price: refund.refundDetailsModel!.productTotalTax,
                          isPositive: true,
                        ),
                        const SizedBox(
                          height: Dimensions.paddingSizeSmall,
                        ),
                        ProductCalculationItem(
                            title: 'subtotal',
                            price: refund.refundDetailsModel!.subtotal),
                        const SizedBox(
                          height: Dimensions.paddingSizeSmall,
                        ),
                        const CustomDivider(),
                        const SizedBox(
                          height: Dimensions.paddingSizeSmall,
                        ),
                        Row(
                          children: [
                            Text(
                              '${getTranslated('total_refund_amount', context)}',
                              style: robotoMedium.copyWith(
                                  fontSize: Dimensions.fontSizeDefault),
                            ),
                            const Spacer(),
                            Text(
                              PriceConverter.convertPrice(context,
                                  refund.refundDetailsModel!.refundAmount),
                              style: robotoMedium.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Dimensions.fontSizeLarge),
                            ),
                          ],
                        ),
                      ])
                : const SizedBox(),
          );
        }),
      ),
    );
  }
}
