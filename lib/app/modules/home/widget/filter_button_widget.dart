import 'dart:developer';

import 'package:citgroupvn_efood_table/app/modules/home/home.dart';

class FilterButtonWidget extends StatelessWidget {
  final String type;
  final List<String> items;
  final bool isBorder;
  final bool isSmall;
  final Function(String value) onSelected;

  const FilterButtonWidget({
    super.key,
    required this.type,
    required this.onSelected,
    required this.items,
    this.isBorder = false,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool ltr = Get.find<LocalizationController>().isLtr;
    bool isVegFilter = Get.find<ProductController>().productTypeList == items;

    return GetBuilder<SplashController>(builder: (splashController) {
      print(
          "hihi" + splashController.configModel!.isVegNonVegActive.toString());
      return (isVegFilter && !splashController.configModel!.isVegNonVegActive!)
          ? const SizedBox()
          : Align(
              alignment: Alignment.center,
              child: Container(
                height: ResponsiveHelper.isSmallTab()
                    ? 35
                    : ResponsiveHelper.isTab(context)
                        ? 50
                        : 40,
                margin:
                    EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                decoration: isBorder
                    ? null
                    : BoxDecoration(
                        borderRadius: const BorderRadius.all(
                            Radius.circular(Dimensions.radiusSmall)),
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                      ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => onSelected(items[index]),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeDefault),
                        margin: isBorder
                            ? EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingSizeExtraSmall)
                            : EdgeInsets.zero,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: isBorder
                              ? const BorderRadius.all(
                                  Radius.circular(Dimensions.radiusSmall))
                              : BorderRadius.horizontal(
                                  left: Radius.circular(
                                    ltr
                                        ? index == 0 && items[index] != type
                                            ? Dimensions.radiusSmall
                                            : 0
                                        : index == items.length - 1
                                            ? Dimensions.radiusSmall
                                            : 0,
                                  ),
                                  right: Radius.circular(
                                    ltr
                                        ? index == items.length - 1 &&
                                                items[index] != type
                                            ? Dimensions.radiusSmall
                                            : 0
                                        : index == 0
                                            ? Dimensions.radiusSmall
                                            : 0,
                                  ),
                                ),
                          color: items[index] == type
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).canvasColor,
                          border: isBorder
                              ? Border.all(
                                  width: 1.3,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.4))
                              : null,
                        ),
                        child: Row(
                          children: [
                            items[index] != items[0] && isVegFilter
                                ? Padding(
                                    padding: EdgeInsets.all(
                                        Dimensions.paddingSizeExtraSmall),
                                    child: Image.asset(
                                      Images.getImageUrl(items[index]),
                                    ),
                                  )
                                : const SizedBox(),
                            Text(
                              items[index].tr,
                              style: items[index] == type
                                  ? robotoMedium.copyWith(
                                      fontSize: Dimensions.fontSizeLarge,
                                      color: Colors.white)
                                  : robotoRegular.copyWith(
                                      fontSize: Dimensions.fontSizeDefault,
                                      color: Theme.of(context).hintColor),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ));
    });
  }
}
// import 'package:flutter/material.dart';
// import 'package:citgroupvn_efood_table/app/modules/home/home.dart';

// class FilterButtonWidget extends StatelessWidget {
//   final String type;
//   final List<String> items;
//   final bool isBorder;
//   final bool isSmall;
//   final Function(String value) onSelected;

//   const FilterButtonWidget({
//     super.key,
//     required this.type,
//     required this.onSelected,
//     required this.items,
//     this.isBorder = false,
//     this.isSmall = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final bool ltr = Get.find<LocalizationController>().isLtr;
//     bool isVegFilter = Get.find<ProductController>().productTypeList == items;
//     SplashController splashController = Get.find<SplashController>();

//     return GetBuilder<SplashController>(builder: (splashController) {
//       if (splashController.configModel != null) {
//         return (isVegFilter &&
//                 !splashController.configModel!.isVegNonVegActive!)
//             ? const SizedBox()
//             : Align(
//                 alignment: Alignment.center,
//                 child: Container(
//                   height: ResponsiveHelper.isSmallTab()
//                       ? 35
//                       : ResponsiveHelper.isTab(context)
//                           ? 50
//                           : 40,
//                   margin: EdgeInsets.symmetric(
//                       vertical: Dimensions.paddingSizeSmall),
//                   decoration: isBorder
//                       ? null
//                       : BoxDecoration(
//                           borderRadius: const BorderRadius.all(
//                               Radius.circular(Dimensions.radiusSmall)),
//                           border:
//                               Border.all(color: Theme.of(context).primaryColor),
//                         ),
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: items.length,
//                     shrinkWrap: true,
//                     itemBuilder: (context, index) {
//                       return InkWell(
//                         onTap: () => onSelected(items[index]),
//                         child: Container(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: Dimensions.paddingSizeDefault),
//                           margin: isBorder
//                               ? EdgeInsets.symmetric(
//                                   horizontal: Dimensions.paddingSizeExtraSmall)
//                               : EdgeInsets.zero,
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             borderRadius: isBorder
//                                 ? const BorderRadius.all(
//                                     Radius.circular(Dimensions.radiusSmall))
//                                 : BorderRadius.horizontal(
//                                     left: Radius.circular(
//                                       ltr
//                                           ? index == 0 && items[index] != type
//                                               ? Dimensions.radiusSmall
//                                               : 0
//                                           : index == items.length - 1
//                                               ? Dimensions.radiusSmall
//                                               : 0,
//                                     ),
//                                     right: Radius.circular(
//                                       ltr
//                                           ? index == items.length - 1 &&
//                                                   items[index] != type
//                                               ? Dimensions.radiusSmall
//                                               : 0
//                                           : index == 0
//                                               ? Dimensions.radiusSmall
//                                               : 0,
//                                     ),
//                                   ),
//                             color: items[index] == type
//                                 ? Theme.of(context).primaryColor
//                                 : Theme.of(context).canvasColor,
//                             border: isBorder
//                                 ? Border.all(
//                                     width: 1.3,
//                                     color: Theme.of(context)
//                                         .primaryColor
//                                         .withOpacity(0.4))
//                                 : null,
//                           ),
//                           child: Row(
//                             children: [
//                               items[index] != items[0] && isVegFilter
//                                   ? Padding(
//                                       padding: EdgeInsets.all(
//                                           Dimensions.paddingSizeExtraSmall),
//                                       child: Image.asset(
//                                         Images.getImageUrl(items[index]),
//                                       ),
//                                     )
//                                   : const SizedBox(),
//                               Text(
//                                 items[index].tr,
//                                 style: items[index] == type
//                                     ? robotoMedium.copyWith(
//                                         fontSize: Dimensions.fontSizeLarge,
//                                         color: Colors.white)
//                                     : robotoRegular.copyWith(
//                                         fontSize: Dimensions.fontSizeDefault,
//                                         color: Theme.of(context).hintColor),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               );
//       } else {
//         return const SizedBox(); // Trả về một SizedBox nếu configModel là null
//       }
//     });
//   }
// }
