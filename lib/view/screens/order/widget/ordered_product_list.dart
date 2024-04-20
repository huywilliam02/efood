import 'package:efood_kitchen/controller/order_controller.dart';
import 'package:efood_kitchen/controller/splash_controller.dart';
import 'package:efood_kitchen/data/model/response/config_model.dart';
import 'package:efood_kitchen/data/model/response/order_details_model.dart';
import 'package:efood_kitchen/helper/price_converter.dart';
import 'package:efood_kitchen/helper/responsive_helper.dart';
import 'package:efood_kitchen/util/dimensions.dart';
import 'package:efood_kitchen/util/styles.dart';
import 'package:efood_kitchen/view/base/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderedProductList extends StatelessWidget {
  final OrderController orderController;
  const OrderedProductList({Key? key, required this.orderController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ConfigModel configModel = Get.find<SplashController>().configModel;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
      child: ListView.builder(
        shrinkWrap: ResponsiveHelper.isMobile(context),
        physics: ResponsiveHelper.isMobile(context) ? const NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(),
        itemCount: orderController.orderDetails.details.length,
        itemBuilder: (context, index) {
          String variationText = '';
          List<AddOns> addOns = [];
          Details? orderDetails = orderController.orderDetails.details[index];
          List<AddOns> addonsData  = orderController.orderDetails.details[index].productDetails == null ? [] :
          orderController.orderDetails.details[index].productDetails!.addOns == null ? [] :
          orderController.orderDetails.details[index].productDetails!.addOns!;


          if(orderDetails.variations != null && orderDetails.variations!.isNotEmpty) {
            for(Variation variation in orderDetails.variations!) {
              variationText += '${variationText.isNotEmpty ? ', ' : ''}${variation.name} (';
              for(VariationValue value in variation.variationValues!) {
                variationText += '${variationText.endsWith('(') ? '' : ', '}${value.level}';
              }
              variationText += ')';
            }
          }else if(orderDetails.oldVariations != null && orderDetails.oldVariations!.isNotEmpty) {

            List<String> variationTypes = orderDetails.oldVariations![0].type != null
                ? orderDetails.oldVariations![0].type!.split('-') : [];

            if(variationTypes.length == orderDetails.productDetails?.choiceOptions?.length) {
              int index = 0;
              orderDetails.productDetails?.choiceOptions?.forEach((choice) {
                variationText = '$variationText${(index == 0) ? '' : ',  '}${choice.title} - ${variationTypes[index]}';
                index = index + 1;
              });
            }else {
              variationText = orderDetails.oldVariations?[0].type ?? '';
            }
          }


          for (var addOn in addonsData) {
            if (orderController.orderDetails.details[index].addOnIds!.contains(addOn.id)) {
              addOns.add(addOn);
            }
          }









          return Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [Row(children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Row(children: [
                      Expanded(child: Text(orderController.orderDetails.details[index].productDetails!.name!,
                        style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                        maxLines: 2, overflow: TextOverflow.ellipsis)),


                      Text(orderController.orderDetails.details[index].quantity.toString(), style: robotoRegular.copyWith()),
                      const SizedBox(width: Dimensions.paddingSizeExtraLarge),

                      Text(PriceConverter.convertPrice( context,
                          (orderController.orderDetails.details[index].price! * orderController.orderDetails.details[index].quantity!)),
                          style: robotoMedium.copyWith(),
                      ),
                    ],),

                      variationText != '' ? Text(
                        '${'variation'.tr} : $variationText', style: robotoRegular,
                      ) : const SizedBox(),

                     addOns.isNotEmpty ? SizedBox(
                        height: 30,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: addOns.length,
                          itemBuilder: (context, item) {
                            return Row(
                              children: [
                               if(item == 0) Text('${'add_ons'.tr} :', style: robotoRegular),
                                const SizedBox(width: 2),

                                Text(addOns[item].name ?? '', style: robotoRegular),
                                const SizedBox(width: 2),

                                Text('(${orderController.orderDetails.details[index].addOnQtys![item]})', style: robotoRegular),

                                if(item + 1 != addOns.length)const Text(' - ', style: robotoRegular),
                              ],
                            );

                          },
                        ),
                      ) : const SizedBox(),


                      // if(_addOnsList.isNotEmpty)

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                            child: Text(PriceConverter.convertPrice( context, orderController.orderDetails.details[index].price!),
                                style: robotoRegular.copyWith(color: Theme.of(context).hintColor))),

                         if(configModel.isVegNonVegActive! && orderController.orderDetails.details[index].productDetails!.productType != null)
                           Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0 ,vertical: 2),
                              child: Text('${orderController.orderDetails.details[index].productDetails!.productType}'.tr, style: robotoRegular.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: Dimensions.paddingSizeDefault),
                    ]),
              ),
            ]),
              const Padding(
                padding: EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                child: CustomDivider(height: .25,),
              ),
            ]);
      },
    ),);
  }
}
