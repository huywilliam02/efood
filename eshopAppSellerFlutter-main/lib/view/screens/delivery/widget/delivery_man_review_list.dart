import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:citgroupvn_eshop_seller/data/model/response/delivery_man_review_model.dart';
import 'package:citgroupvn_eshop_seller/data/model/response/top_delivery_man.dart';
import 'package:citgroupvn_eshop_seller/provider/delivery_man_provider.dart';
import 'package:citgroupvn_eshop_seller/view/base/no_data_screen.dart';
import 'package:citgroupvn_eshop_seller/view/screens/delivery/widget/delivery_man_review_card.dart';

class DeliveryManReviewList extends StatelessWidget {
  final DeliveryMan? deliveryMan;
  const DeliveryManReviewList({Key? key, this.deliveryMan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DeliveryManProvider>(builder: (context, review, _) {
      List<DeliveryManReview> reviewList = [];
      reviewList = review.deliveryManReviewList;
      return reviewList.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: reviewList.length,
              itemBuilder: (context, index) {
                return DeliveryManReviewItem(reviewModel: reviewList[index]);
              })
          : const NoDataScreen();
    });
  }
}
