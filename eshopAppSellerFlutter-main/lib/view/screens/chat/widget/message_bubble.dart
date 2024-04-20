import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:citgroupvn_eshop_seller/data/model/response/message_model.dart';
import 'package:citgroupvn_eshop_seller/helper/date_converter.dart';
import 'package:citgroupvn_eshop_seller/provider/chat_provider.dart';
import 'package:citgroupvn_eshop_seller/provider/localization_provider.dart';
import 'package:citgroupvn_eshop_seller/provider/splash_provider.dart';
import 'package:citgroupvn_eshop_seller/utill/app_constants.dart';
import 'package:citgroupvn_eshop_seller/utill/color_resources.dart';
import 'package:citgroupvn_eshop_seller/utill/dimensions.dart';
import 'package:citgroupvn_eshop_seller/utill/images.dart';
import 'package:citgroupvn_eshop_seller/utill/styles.dart';
import 'package:citgroupvn_eshop_seller/view/base/custom_image.dart';
import 'package:citgroupvn_eshop_seller/view/base/image_diaglog.dart';

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMe = message.sentBySeller == 1;

    String? baseUrl =
        Provider.of<ChatProvider>(context, listen: false).userTypeIndex == 0
            ? Provider.of<SplashProvider>(context, listen: false)
                .baseUrls!
                .customerImageUrl
            : Provider.of<SplashProvider>(context, listen: false)
                .baseUrls!
                .sellerImageUrl;
    String? image =
        Provider.of<ChatProvider>(context, listen: false).userTypeIndex == 0
            ? message.customer != null
                ? message.customer?.image
                : ''
            : message.deliveryMan?.image;
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          isMe
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.only(
                      bottom: Dimensions.paddingSizeExtraLarge),
                  child: InkWell(
                      child: ClipOval(
                          child: Container(
                              color: Theme.of(context).highlightColor,
                              child: CustomImage(
                                image: '$baseUrl/$image',
                                height: Dimensions.chatImage,
                                width: Dimensions.chatImage,
                              )))),
                ),
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (message.message != null && message.message!.isNotEmpty)
                  Container(
                    margin: isMe
                        ? const EdgeInsets.fromLTRB(70, 5, 10, 5)
                        : const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: isMe
                                ? const Radius.circular(10)
                                : const Radius.circular(10),
                            bottomLeft: isMe
                                ? const Radius.circular(10)
                                : const Radius.circular(0),
                            bottomRight: isMe
                                ? const Radius.circular(0)
                                : const Radius.circular(10),
                            topRight: isMe
                                ? const Radius.circular(10)
                                : const Radius.circular(10)),
                        color: isMe
                            ? Theme.of(context).hintColor.withOpacity(.125)
                            : ColorResources.getPrimary(context)
                                .withOpacity(.10)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          (message.message != null &&
                                  message.message!.isNotEmpty)
                              ? Text(message.message!,
                                  style: titilliumRegular.copyWith(
                                      fontSize: Dimensions.fontSizeDefault,
                                      color: isMe
                                          ? ColorResources.getTextColor(context)
                                          : ColorResources.getTextColor(
                                              context)))
                              : const SizedBox.shrink(),
                        ]),
                  ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeExtraSmall),
                    child: Text(
                        DateConverter.customTime(
                            DateTime.parse(message.createdAt!)),
                        style: titilliumRegular.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color: ColorResources.getHint(context)))),
                if (message.attachment!.isNotEmpty)
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                message.attachment!.isNotEmpty
                    ? Directionality(
                        textDirection: Provider.of<LocalizationProvider>(
                                    context,
                                    listen: false)
                                .isLtr
                            ? isMe
                                ? TextDirection.rtl
                                : TextDirection.ltr
                            : isMe
                                ? TextDirection.ltr
                                : TextDirection.rtl,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 1,
                                  crossAxisCount: 3,
                                  mainAxisSpacing: Dimensions.paddingSizeSmall,
                                  crossAxisSpacing:
                                      Dimensions.paddingSizeSmall),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: message.attachment!.length,
                          itemBuilder: (BuildContext context, index) {
                            return InkWell(
                              onTap: () => showDialog(
                                  context: context,
                                  builder: (ctx) => ImageDialog(
                                      imageUrl:
                                          '${AppConstants.baseUrl}/storage/app/public/chatting/${message.attachment![index]}')),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: CustomImage(
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                      image:
                                          '${AppConstants.baseUrl}/storage/app/public/chatting/${message.attachment![index]}')),
                            );
                          },
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
