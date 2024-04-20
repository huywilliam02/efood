import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:citgroupvn_eshop_seller/data/model/response/chat_model.dart';
import 'package:citgroupvn_eshop_seller/helper/date_converter.dart';
import 'package:citgroupvn_eshop_seller/provider/chat_provider.dart';
import 'package:citgroupvn_eshop_seller/provider/splash_provider.dart';
import 'package:citgroupvn_eshop_seller/utill/color_resources.dart';
import 'package:citgroupvn_eshop_seller/utill/dimensions.dart';
import 'package:citgroupvn_eshop_seller/utill/images.dart';
import 'package:citgroupvn_eshop_seller/utill/styles.dart';
import 'package:citgroupvn_eshop_seller/view/base/custom_snackbar.dart';
import 'package:citgroupvn_eshop_seller/view/screens/chat/chat_screen.dart';

class ChatCardWidget extends StatelessWidget {
  final Chat? chat;
  const ChatCardWidget({Key? key, this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? baseUrl =
        Provider.of<ChatProvider>(context, listen: false).userTypeIndex == 0
            ? Provider.of<SplashProvider>(context, listen: false)
                .baseUrls!
                .customerImageUrl
            : Provider.of<SplashProvider>(context, listen: false)
                .baseUrls!
                .deliveryManImageUrl;

    int? id =
        Provider.of<ChatProvider>(context, listen: false).userTypeIndex == 0
            ? chat!.customer?.id ?? -1
            : chat!.deliveryManId;

    String? image =
        Provider.of<ChatProvider>(context, listen: false).userTypeIndex == 0
            ? chat!.customer != null
                ? chat!.customer?.image
                : ''
            : chat!.deliveryMan?.image;

    String name = Provider.of<ChatProvider>(context, listen: false)
                .userTypeIndex ==
            0
        ? chat!.customer != null
            ? '${chat!.customer?.fName} ${chat!.customer?.lName}'
            : 'Customer Deleted'
        : '${chat!.deliveryMan?.fName ?? 'Deliveryman'} ${chat!.deliveryMan?.lName ?? 'Deleted'}';

    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: Dimensions.paddingSizeExtraSmall),
      child: InkWell(
        onTap: () {
          if (id != -1) {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return ChatScreen(userId: id, name: name);
            }));
          } else {
            showCustomSnackBar('Customer was deleted', context);
          }
        },
        child: Container(
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  errorWidget: (ctx, url, err) => Image.asset(
                    Images.placeholderImage,
                    height: Dimensions.chatImage,
                    width: Dimensions.chatImage,
                    fit: BoxFit.cover,
                  ),
                  placeholder: (ctx, url) =>
                      Image.asset(Images.placeholderImage),
                  imageUrl: '$baseUrl/$image',
                  fit: BoxFit.cover,
                  height: Dimensions.chatImage,
                  width: Dimensions.chatImage,
                ),
              ),
              const SizedBox(
                width: Dimensions.paddingSizeSmall,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(name,
                            style: titilliumSemiBold.copyWith(
                                color: ColorResources.titleColor(context))),
                      ],
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeExtraSmall,
                    ),
                    Text(
                      chat!.message ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: titilliumRegular.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          color: ColorResources.getTextColor(context)
                              .withOpacity(.8)),
                    ),
                    Text(
                        DateConverter.customTime(
                            DateTime.parse(chat!.createdAt!)),
                        style: robotoRegular.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).hintColor)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
