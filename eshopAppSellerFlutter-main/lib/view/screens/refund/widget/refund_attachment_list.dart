import 'package:flutter/material.dart';
import 'package:citgroupvn_eshop_seller/data/model/response/refund_model.dart';
import 'package:citgroupvn_eshop_seller/utill/app_constants.dart';
import 'package:citgroupvn_eshop_seller/utill/dimensions.dart';
import 'package:citgroupvn_eshop_seller/view/base/custom_image.dart';
import 'image_diaglog.dart';

class RefundAttachmentList extends StatelessWidget {
  final RefundModel? refundModel;
  const RefundAttachmentList({Key? key, this.refundModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingEye),
      child: SizedBox(
        height: 90,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: refundModel!.images!.length,
          itemBuilder: (BuildContext context, index) {
            return refundModel!.images!.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        InkWell(
                          onTap: () => showDialog(
                            context: context,
                            builder: (ctx) => ImageDialog(
                                imageUrl:
                                    '${AppConstants.baseUrl}/storage/app/public/refund/'
                                    '${refundModel!.images![index]}'),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(
                                Dimensions.paddingSizeExtraSmall),
                            width: Dimensions.imageSize,
                            height: Dimensions.imageSize,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.125)),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                      Dimensions.paddingSizeExtraSmall)),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                      Dimensions.paddingSizeExtraSmall)),
                              child: CustomImage(
                                  image:
                                      '${AppConstants.baseUrl}/storage/app/public/refund/'
                                      '${refundModel!.images![index]}',
                                  fit: BoxFit.cover,
                                  width: Dimensions.imageSize,
                                  height: Dimensions.imageSize),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox();
          },
        ),
      ),
    );
  }
}
