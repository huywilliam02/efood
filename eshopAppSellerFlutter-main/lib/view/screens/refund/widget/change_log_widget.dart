import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:citgroupvn_eshop_seller/helper/date_converter.dart';
import 'package:citgroupvn_eshop_seller/localization/language_constrants.dart';
import 'package:citgroupvn_eshop_seller/provider/refund_provider.dart';
import 'package:citgroupvn_eshop_seller/provider/theme_provider.dart';
import 'package:citgroupvn_eshop_seller/utill/color_resources.dart';
import 'package:citgroupvn_eshop_seller/utill/dimensions.dart';
import 'package:citgroupvn_eshop_seller/utill/styles.dart';
import 'package:citgroupvn_eshop_seller/view/base/custom_app_bar.dart';
import 'package:citgroupvn_eshop_seller/view/base/no_data_screen.dart';
import 'package:citgroupvn_eshop_seller/view/screens/addProduct/add_product_screen.dart';

import '../../../../utill/images.dart';

class ChangeLogWidget extends StatelessWidget {
  final String paidBy;
  const ChangeLogWidget({Key? key, required this.paidBy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated('change_log', context),
      ),
      body: Consumer<RefundProvider>(builder: (context, refundReq, _) {
        String payment = paidBy.replaceAll('_', ' ');

        return Container(
          padding:
              const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[
                      Provider.of<ThemeProvider>(context).darkTheme
                          ? 800
                          : 200]!,
                  spreadRadius: 0.5,
                  blurRadius: 0.3)
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeDefault,
                vertical: Dimensions.paddingSizeSmall),
            child: Column(
              children: [
                //ItemWidget(lestValue: 'order_placed',rightValue: DateConverter.localDateToIsoStringDate(DateTime.parse(refundReq.refundDetailsModel!.refundRequest![0].createdAt!))),
                if (refundReq.refundDetailsModel != null &&
                    refundReq.refundDetailsModel!.refundRequest != null &&
                    refundReq.refundDetailsModel!.refundRequest!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeSmall),
                    child: ItemWidget(
                        lestValue: 'refund_request',
                        rightValue: DateConverter.localDateToIsoStringDate(
                            DateTime.parse(refundReq.refundDetailsModel!
                                .refundRequest![0].createdAt!))),
                  ),
                ItemWidget(
                  lestValue: 'paid_by',
                  rightValue: payment.capitalize(),
                  isPayment: true,
                ),

                const SizedBox(height: Dimensions.paddingSizeButton),

                refundReq.refundDetailsModel != null
                    ? (refundReq.refundDetailsModel!.refundRequest != null &&
                            refundReq
                                .refundDetailsModel!.refundRequest!.isNotEmpty)
                        ? Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: refundReq.refundDetailsModel!
                                    .refundRequest![0].refundStatus!.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .circular(Dimensions
                                                            .paddingSizeLarge),
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                  child: Icon(
                                                      Icons.info_outline,
                                                      color: Theme.of(context)
                                                          .cardColor)),
                                              index ==
                                                      refundReq
                                                              .refundDetailsModel!
                                                              .refundRequest![0]
                                                              .refundStatus!
                                                              .length -
                                                          1
                                                  ? const SizedBox()
                                                  : Container(
                                                      height: 60,
                                                      width: 2,
                                                      color: Theme.of(context)
                                                          .primaryColor)
                                            ],
                                          )),
                                      Expanded(
                                        flex: 6,
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              left: Dimensions
                                                  .paddingSizeExtraSmall,
                                              right: Dimensions
                                                  .paddingSizeExtraSmall),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ItemWidget(
                                                    lestValue: 'status',
                                                    rightValue: refundReq
                                                        .refundDetailsModel!
                                                        .refundRequest![0]
                                                        .refundStatus![index]
                                                        .status!
                                                        .capitalize()),
                                                Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: Dimensions
                                                            .paddingSizeSmall),
                                                    child: ItemWidget(
                                                        lestValue: 'updated_by',
                                                        rightValue: refundReq
                                                                .refundDetailsModel!
                                                                .refundRequest![
                                                                    0]
                                                                .refundStatus![
                                                                    index]
                                                                .changeBy ??
                                                            '')),
                                                ItemWidget(
                                                    lestValue: 'reason',
                                                    rightValue: refundReq
                                                            .refundDetailsModel!
                                                            .refundRequest![0]
                                                            .refundStatus![
                                                                index]
                                                            .message ??
                                                        '')
                                              ]),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          )
                        : const NoDataScreen()
                    : const Expanded(
                        child: Expanded(
                            child: Center(child: CircularProgressIndicator()))),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class ItemWidget extends StatelessWidget {
  final String? lestValue;
  final String? rightValue;
  final bool isPayment;
  const ItemWidget(
      {Key? key,
      required this.lestValue,
      required this.rightValue,
      this.isPayment = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Text('${getTranslated(lestValue, context)} : ',
          style: titilliumRegular.copyWith(
              color: Theme.of(context).hintColor,
              fontSize: Dimensions.fontSizeDefault)),
      Text(rightValue ?? '',
          style: robotoBold.copyWith(
              color: rightValue! == 'Pending'
                  ? Theme.of(context).primaryColor
                  : rightValue! == 'Refunded'
                      ? ColorResources.getGreen(context)
                      : rightValue! == 'Rejected'
                          ? Theme.of(context).colorScheme.error
                          : rightValue! == 'Approved'
                              ? ColorResources.getGreen(context)
                              : isPayment
                                  ? ColorResources.getGreen(context)
                                  : ColorResources.getTextColor(context),
              fontSize: Dimensions.fontSizeDefault))
    ]);
  }
}
