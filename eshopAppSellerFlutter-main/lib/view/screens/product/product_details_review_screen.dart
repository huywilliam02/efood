import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:citgroupvn_eshop_seller/data/model/response/product_model.dart';
import 'package:citgroupvn_eshop_seller/data/model/response/product_review_model.dart';
import 'package:citgroupvn_eshop_seller/localization/language_constrants.dart';
import 'package:citgroupvn_eshop_seller/provider/localization_provider.dart';
import 'package:citgroupvn_eshop_seller/provider/product_provider.dart';
import 'package:citgroupvn_eshop_seller/utill/dimensions.dart';
import 'package:citgroupvn_eshop_seller/utill/styles.dart';
import 'package:citgroupvn_eshop_seller/view/base/rating_bar.dart';
import 'package:citgroupvn_eshop_seller/view/base/see_more_button.dart';
import 'package:citgroupvn_eshop_seller/view/screens/product/widget/product_review_item.dart';

class ProductReviewScreen extends StatefulWidget {
  final Product? productModel;
  const ProductReviewScreen({Key? key, this.productModel}) : super(key: key);
  @override
  State<ProductReviewScreen> createState() => _ProductReviewScreenState();
}

class _ProductReviewScreenState extends State<ProductReviewScreen> {
  late ScrollController _controller;
  String message = "";
  bool activated = false;
  bool endScroll = false;
  _onStartScroll(ScrollMetrics metrics) {
    setState(() {
      message = "start";
    });
  }

  _onUpdateScroll(ScrollMetrics metrics) {
    setState(() {
      message = "scrolling";
    });
  }

  _onEndScroll(ScrollMetrics metrics) {
    setState(() {
      message = "end";
    });
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        endScroll = true;
        message = "bottom";
      });
    }
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (message == 'end' && !endScroll) {
      Future.delayed(const Duration(seconds: 10), () {
        if (mounted) {
          setState(() {
            activated = true;
          });
        }
      });
    } else {
      activated = false;
    }
    return RefreshIndicator(
      onRefresh: () async {
        Provider.of<ProductProvider>(context, listen: false)
            .getProductWiseReviewList(context, 1, widget.productModel!.id);
      },
      child: Consumer<ProductProvider>(builder: (context, review, _) {
        double fiveStar = 0.0,
            fourStar = 0.0,
            threeStar = 0.0,
            twoStar = 0.0,
            oneStar = 0.0;

        if (review.productReviewModel != null &&
            review.productReviewModel!.groupWiseRating!.isNotEmpty) {
          List<GroupWiseRating> rating =
              review.productReviewModel!.groupWiseRating!;
          for (int i = 0; i < rating.length; i++) {
            if (rating[i].rating == 1) {
              oneStar =
                  (rating[i].rating! * rating[i].total!) / (rating.length * 5);
            }
            if (rating[i].rating == 2) {
              twoStar =
                  (rating[i].rating! * rating[i].total!) / (rating.length * 5);
            }
            if (rating[i].rating == 3) {
              threeStar =
                  (rating[i].rating! * rating[i].total!) / (rating.length * 5);
            }
            if (rating[i].rating == 4) {
              fourStar =
                  (rating[i].rating! * rating[i].total!) / (rating.length * 5);
            }
            if (rating[i].rating == 5) {
              fiveStar =
                  (rating[i].rating! * rating[i].total!) / (rating.length * 5);
            }
          }
        }

        return Stack(
          children: [
            NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollStartNotification) {
                  _onStartScroll(scrollNotification.metrics);
                } else if (scrollNotification is ScrollUpdateNotification) {
                  _onUpdateScroll(scrollNotification.metrics);
                } else if (scrollNotification is ScrollEndNotification) {
                  _onEndScroll(scrollNotification.metrics);
                }
                return false;
              },
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeDefault),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Align(
                                alignment: Provider.of<LocalizationProvider>(
                                            context,
                                            listen: false)
                                        .isLtr
                                    ? Alignment.centerLeft
                                    : Alignment.bottomRight,
                                child: Text(
                                    getTranslated('product_reviews', context)!,
                                    style: robotoMedium.copyWith(
                                        fontSize: Dimensions.fontSizeDefault))),
                            Text(
                                (review.productReviewModel?.averageRating ??
                                        review.productReviewModel?.averageRating
                                            .toString()) ??
                                    '',
                                style: robotoBold.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: Dimensions.fontSizeOverlarge)),
                            RatingBarIndicator(
                              rating:
                                  review.productReviewModel?.averageRating !=
                                          null
                                      ? double.parse(review
                                          .productReviewModel!.averageRating
                                          .toString())
                                      : 0,
                              itemBuilder: (context, index) => Icon(
                                  Icons.star_rate_rounded,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.75)),
                              itemCount: 5,
                              itemSize: Dimensions.iconSizeLarge,
                              unratedColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.35),
                              direction: Axis.horizontal,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: Dimensions.paddingSizeSmall),
                              child: Text(
                                "${review.productReviewModel?.totalSize} ${getTranslated('reviews', context)}",
                                style: robotoRegular.copyWith(),
                              ),
                            ),
                          ],
                        ),

                        _progressBar(
                          title: 'excellent',
                          colr: const Color(0xFF69B469),
                          percent: fiveStar,
                        ),
                        _progressBar(
                          title: 'good',
                          colr: const Color(0xFFB0DC4B),
                          percent: fourStar,
                        ),
                        _progressBar(
                          title: 'average',
                          colr: const Color(0xFFFFC700),
                          percent: threeStar,
                        ),
                        _progressBar(
                          title: 'below_average',
                          colr: const Color(0xFFF7A41E),
                          percent: twoStar,
                        ),
                        _progressBar(
                          title: 'poor',
                          colr: const Color(0xFFFF2828),
                          percent: oneStar,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: Dimensions.paddingSizeSmall),
                          child: Divider(),
                        ),

                        //ReviewList
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: review.productReviewList.length,
                            itemBuilder: (context, index) {
                              return ProductReviewItem(
                                  reviewModel: review.productReviewList[index]);
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            activated ? const SeeMoreButton() : const SizedBox(),
          ],
        );
      }),
    );
  }

  Widget _progressBar(
      {required String title, required double percent, required Color colr}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            getTranslated(title, context)!,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF8C8C8C)),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: SizedBox(
              width: 245,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                child: LinearProgressIndicator(
                  value: percent,
                  valueColor: AlwaysStoppedAnimation<Color>(colr),
                  backgroundColor: const Color(0xFFEAEAEA),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
