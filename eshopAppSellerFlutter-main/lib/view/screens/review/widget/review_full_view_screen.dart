import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:citgroupvn_eshop_seller/data/repository/ratting_model.dart';
import 'package:citgroupvn_eshop_seller/localization/language_constrants.dart';
import 'package:citgroupvn_eshop_seller/provider/product_review_provider.dart';
import 'package:citgroupvn_eshop_seller/view/base/custom_app_bar.dart';
import 'package:citgroupvn_eshop_seller/view/screens/review/widget/review_widget.dart';

class ReviewFullViewScreen extends StatelessWidget {
  final Reviews? reviewModel;
  final bool? isDetails;
  final int? index;
  const ReviewFullViewScreen(
      {Key? key, this.reviewModel, this.isDetails, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated('review_details', context),
        isAction: true,
        isSwitch: true,
        index: index,
        reviewSwitch: true,
        switchAction: (value) {
          if (value) {
            Provider.of<ProductReviewProvider>(context, listen: false)
                .reviewStatusOnOff(context, reviewModel!.id, 1, index);
          } else {
            Provider.of<ProductReviewProvider>(context, listen: false)
                .reviewStatusOnOff(context, reviewModel!.id, 0, index);
          }
        },
      ),
      body: ReviewWidget(reviewModel: reviewModel, isDetails: isDetails),
    );
  }
}
