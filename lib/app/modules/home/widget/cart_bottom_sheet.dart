import 'package:citgroupvn_efood_table/app/components/button/custom_rounded_button.dart';
import 'package:citgroupvn_efood_table/app/components/custom_image.dart';
import 'package:citgroupvn_efood_table/app/components/page_view/stock_tag_view.dart';
import 'package:citgroupvn_efood_table/app/modules/cart/cart.dart';
import 'package:citgroupvn_efood_table/app/modules/home/widget/price_stack_tag.dart';
import 'package:citgroupvn_efood_table/app/modules/home/widget/quantity_button.dart';
import 'package:citgroupvn_efood_table/app/modules/order_detail_rm/controllers/order_detail_rm_controller.dart';
import 'package:citgroupvn_efood_table/app/modules/order_detail_update_rm/controllers/order_detail_update_rm_controller.dart';
import 'package:citgroupvn_efood_table/app/modules/order_detail_update_rm/views/pick_product_rm_view.dart';
import 'package:citgroupvn_efood_table/app/modules/product_image/image_screen.dart';
import 'package:citgroupvn_efood_table/app/modules/product_image/product_controller.dart';
import 'package:citgroupvn_efood_table/base/base_common.dart';
import 'package:citgroupvn_efood_table/data/model/response/cart_model.dart'
    as cart;
import 'package:expandable_text/expandable_text.dart';

class ProductBottomSheet extends StatefulWidget {
  final Product product;
  final CartModel? cart;
  final int? cartIndex;
  const ProductBottomSheet(
      {super.key, required this.product, this.cart, this.cartIndex});

  @override
  State<ProductBottomSheet> createState() => _ProductBottomSheetState();
}

class _ProductBottomSheetState extends State<ProductBottomSheet> {
  @override
  void initState() {
    super.initState();
    Get.find<ProductController>().initData(widget.product, widget.cart);
  }

  @override
  Widget build(BuildContext context) {
    final bool isTab = ResponsiveHelper.isTab(context);
    // late int _cartIndex;
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Stack(
        children: [
          Container(
            width: ResponsiveHelper.isSmallTab()
                ? 550
                : ResponsiveHelper.isTab(context)
                    ? 700
                    : 550,
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radiusExtraLarge),
                topRight: Radius.circular(Dimensions.radiusExtraLarge),
                bottomLeft: isTab
                    ? Radius.circular(Dimensions.radiusExtraLarge)
                    : Radius.zero,
                bottomRight: isTab
                    ? Radius.circular(Dimensions.radiusExtraLarge)
                    : Radius.zero,
              ),
            ),
            child: GetBuilder<CartController>(builder: (cartController) {
              return GetBuilder<ProductController>(
                  builder: (productController) {
                double variationPrice = 0;
                double price = widget.product.price ?? 0;
                double discount = widget.product.discount ?? 0;
                String discountType = widget.product.discountType ?? 'percent';
                List<Variation> variationList = [];

                if (widget.product.branchProduct != null &&
                    widget.product.branchProduct!.isAvailable!) {
                  variationList =
                      widget.product.branchProduct!.variations ?? [];
                  discount = widget.product.branchProduct?.discount ?? 0;
                  price = widget.product.branchProduct?.price ?? 0;
                  discountType =
                      widget.product.branchProduct?.discountType ?? 'percent';
                } else {
                  variationList = widget.product.variations ?? [];
                }

                for (int index = 0; index < variationList.length; index++) {
                  if (variationList[index].variationValues != null) {
                    for (int i = 0;
                        i < variationList[index].variationValues!.length;
                        i++) {
                      if (productController.selectedVariations[index][i]) {
                        variationPrice += variationList[index]
                                .variationValues![i]
                                .optionPrice ??
                            0;
                      }
                    }
                  }
                }

                double priceWithDiscount = PriceConverter.convertWithDiscount(
                  price,
                  discount,
                  discountType.toString(),
                );

                double addonsCost = 0;
                double addonsTax = 0;
                List<AddOn> addOnIdList = [];
                int addonLen = widget.product.addOns != null
                    ? widget.product.addOns!.length
                    : 0;

                for (int index = 0; index < addonLen; index++) {
                  if (productController.addOnActiveList[index]) {
                    double addonItemPrice =
                        widget.product.addOns![index].price! *
                            productController.addOnQtyList[index];
                    addonsCost = addonsCost + (addonItemPrice);
                    addonsTax = addonsTax +
                        (addonItemPrice -
                            PriceConverter.convertWithDiscount(
                                (addonItemPrice),
                                widget.product.addOns![index].tax ?? 0,
                                'percent'));

                    addOnIdList.add(AddOn(
                      id: widget.product.addOns![index].id,
                      quantity: productController.addOnQtyList[index],
                      name: widget.product.addOns![index].name,
                    ));
                  }
                }

                double priceWithAddonsVariation = addonsCost +
                    (PriceConverter.convertWithDiscount(
                            variationPrice + price, discount, discountType) *
                        productController.quantity);
                double priceWithAddonsVariationWithoutDiscount =
                    ((price + variationPrice) * productController.quantity) +
                        addonsCost;
                double priceWithVariation = price + variationPrice;
                // bool isAvailable = DateConverter.isAvailable(
                //     widget.product.availableTimeStarts,
                //     widget.product.availableTimeEnds);
                bool isAvailable = true;

                // _cartIndex = cartController.getCartIndex(widget.product);

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(isTab
                                  ? Dimensions.paddingSizeExtraLarge
                                  : Dimensions.paddingSizeLarge),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //Product
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                (widget.product.image != null &&
                                                        widget.product.image!
                                                            .isNotEmpty)
                                                    ? Stack(children: [
                                                        InkWell(
                                                          onTap: () => Get.to(
                                                              () => ProductImageScreen(
                                                                  product: widget
                                                                      .product),
                                                              transition:
                                                                  Transition
                                                                      .leftToRight,
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          300)),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimensions
                                                                        .radiusSmall),
                                                            child: CustomImage(
                                                              image:
                                                                  '${Get.find<SplashController>().configModel?.baseUrls?.productImageUrl}/${widget.product.image ?? ''}',
                                                              width: ResponsiveHelper
                                                                      .isSmallTab()
                                                                  ? 100
                                                                  : isTab
                                                                      ? 170
                                                                      : 100,
                                                              height: ResponsiveHelper
                                                                      .isSmallTab()
                                                                  ? 100
                                                                  : isTab
                                                                      ? 170
                                                                      : 100,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        if (discount > 0)
                                                          PriceStackTag(
                                                              value: PriceConverter
                                                                  .percentageCalculation(
                                                            price.toString(),
                                                            discount.toString(),
                                                            discountType,
                                                          )),
                                                        StockTagView(
                                                            product:
                                                                widget.product),
                                                      ])
                                                    : const SizedBox.shrink(),
                                                SizedBox(
                                                  width: Dimensions
                                                      .paddingSizeDefault,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          widget.product.name ??
                                                              '',
                                                          style: robotoBold
                                                              .copyWith(
                                                            fontSize: Dimensions
                                                                .fontSizeLarge,
                                                          ),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        SizedBox(
                                                          height: Dimensions
                                                              .paddingSizeSmall,
                                                        ),
                                                        Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    PriceConverter
                                                                        .convertPrice(
                                                                      price,
                                                                      discount:
                                                                          discount,
                                                                      discountType:
                                                                          discountType,
                                                                    ),
                                                                    style: robotoMedium.copyWith(
                                                                        fontSize:
                                                                            Dimensions.fontSizeLarge),
                                                                  ),
                                                                  SizedBox(
                                                                      width: Dimensions
                                                                          .paddingSizeExtraSmall),
                                                                  price > priceWithDiscount
                                                                      ? Text(
                                                                          PriceConverter.convertPrice(
                                                                              price),
                                                                          style: robotoMedium.copyWith(
                                                                              color: Theme.of(context).primaryColor,
                                                                              decoration: TextDecoration.lineThrough),
                                                                        )
                                                                      : const SizedBox(),
                                                                ],
                                                              ),
                                                            ]),
                                                        if (isTab)
                                                          _productDescription(),
                                                      ]),
                                                ),
                                              ]),
                                          if (!ResponsiveHelper.isSmallTab())
                                            SizedBox(
                                                height: Dimensions
                                                    .paddingSizeSmall),

                                          if (!isTab) _productDescription(),
                                          SizedBox(
                                              height: Dimensions
                                                  .paddingSizeDefault),

                                          variationList.isNotEmpty
                                              ? ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      variationList.length,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  padding: EdgeInsets.zero,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        variationList[index].name ??
                                                                            '',
                                                                        style: robotoMedium.copyWith(
                                                                            fontSize:
                                                                                Dimensions.fontSizeLarge),
                                                                      ),
                                                                      Text(
                                                                        ' (${variationList[index].isRequired! ? 'required'.tr : 'optional'.tr})',
                                                                        style: robotoMedium.copyWith(
                                                                            color:
                                                                                Theme.of(context).primaryColor,
                                                                            fontSize: Dimensions.fontSizeSmall),
                                                                      ),
                                                                    ]),
                                                                if (index == 0)
                                                                  ButtonWidget(
                                                                      cartIndex:
                                                                          widget.cartIndex ??
                                                                              -1,
                                                                      product:
                                                                          widget
                                                                              .product),
                                                              ]),
                                                          SizedBox(
                                                              height: Dimensions
                                                                  .paddingSizeExtraSmall),
                                                          Row(children: [
                                                            (variationList[
                                                                        index]
                                                                    .isMultiSelect!)
                                                                ? Text(
                                                                    '${'you_need_to_select_minimum'.tr} ${'${variationList[index].min}'
                                                                        ' ${'to_maximum'.tr} ${variationList[index].max} ${'options'.tr}'}',
                                                                    style: robotoMedium.copyWith(
                                                                        fontSize:
                                                                            Dimensions
                                                                                .fontSizeExtraSmall,
                                                                        color: Theme.of(context)
                                                                            .disabledColor),
                                                                  )
                                                                : const SizedBox(),
                                                          ]),
                                                          SizedBox(
                                                              height: (variationList[
                                                                          index]
                                                                      .isMultiSelect!)
                                                                  ? Dimensions
                                                                      .paddingSizeExtraSmall
                                                                  : 0),
                                                          if (variationList[
                                                                      index]
                                                                  .variationValues !=
                                                              null)
                                                            ListView.builder(
                                                              shrinkWrap: true,
                                                              physics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              itemCount:
                                                                  variationList[
                                                                          index]
                                                                      .variationValues
                                                                      ?.length,
                                                              itemBuilder:
                                                                  (context, i) {
                                                                return InkWell(
                                                                  onTap: () {
                                                                    productController.setCartVariationIndex(
                                                                        index,
                                                                        i,
                                                                        widget
                                                                            .product,
                                                                        variationList[index]
                                                                            .isMultiSelect!);
                                                                  },
                                                                  child: Row(
                                                                      children: [
                                                                        Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              variationList[index].isMultiSelect!
                                                                                  ? Checkbox(
                                                                                      value: productController.selectedVariations[index][i],
                                                                                      activeColor: Theme.of(context).primaryColor,
                                                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
                                                                                      onChanged: (bool? newValue) {
                                                                                        productController.setCartVariationIndex(
                                                                                          index,
                                                                                          i,
                                                                                          widget.product,
                                                                                          variationList[index].isMultiSelect!,
                                                                                        );
                                                                                      },
                                                                                      visualDensity: const VisualDensity(horizontal: -3, vertical: -3),
                                                                                    )
                                                                                  : Radio(
                                                                                      value: i,
                                                                                      groupValue: productController.selectedVariations[index].indexOf(true),
                                                                                      onChanged: (value) {
                                                                                        productController.setCartVariationIndex(
                                                                                          index,
                                                                                          i,
                                                                                          widget.product,
                                                                                          variationList[index].isMultiSelect!,
                                                                                        );
                                                                                      },
                                                                                      activeColor: Theme.of(context).primaryColor,
                                                                                      toggleable: false,
                                                                                      visualDensity: const VisualDensity(horizontal: -3, vertical: -3),
                                                                                    ),
                                                                              Text(
                                                                                variationList[index].variationValues![i].level != null ? variationList[index].variationValues![i].level!.trim() : '',
                                                                                maxLines: 1,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: productController.selectedVariations[index][i] ? robotoMedium : robotoRegular,
                                                                              ),
                                                                            ]),
                                                                        const Spacer(),
                                                                        Text(
                                                                          variationList[index].variationValues![i].optionPrice! > 0
                                                                              ? '+${PriceConverter.convertPrice(variationList[index].variationValues![i].optionPrice ?? 0)}'
                                                                              : 'free'.tr,
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: productController.selectedVariations[index][i]
                                                                              ? robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraSmall)
                                                                              : robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor),
                                                                        ),
                                                                      ]),
                                                                );
                                                              },
                                                            ),
                                                          SizedBox(
                                                              height: index !=
                                                                      variationList
                                                                              .length -
                                                                          1
                                                                  ? Dimensions
                                                                      .paddingSizeLarge
                                                                  : 0),
                                                        ]);
                                                  },
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                      ButtonWidget(
                                                          cartIndex: widget
                                                                  .cartIndex ??
                                                              -1,
                                                          product:
                                                              widget.product),
                                                    ]),

                                          // Variation

                                          SizedBox(
                                              height: widget.product
                                                      .choiceOptions!.isNotEmpty
                                                  ? Dimensions
                                                      .paddingSizeDefault
                                                  : 0),

                                          // Addons
                                          widget.product.addOns != null &&
                                                  widget.product.addOns!
                                                      .isNotEmpty
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'addons'.tr,
                                                            style: robotoMedium
                                                                .copyWith(
                                                              fontSize: Dimensions
                                                                  .fontSizeLarge,
                                                              color: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge!
                                                                  .color,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: Dimensions
                                                                .paddingSizeExtraSmall,
                                                          ),
                                                          Text(
                                                            '(${'optional'.tr})',
                                                            style: robotoRegular
                                                                .copyWith(
                                                              fontSize: Dimensions
                                                                  .fontSizeLarge,
                                                              color: Theme.of(
                                                                      context)
                                                                  .hintColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                          height: Dimensions
                                                              .paddingSizeDefault),
                                                      SizedBox(
                                                        height: 100,
                                                        child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount: widget
                                                              .product
                                                              .addOns!
                                                              .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return InkWell(
                                                              onTap: () {
                                                                if (!productController
                                                                        .addOnActiveList[
                                                                    index]) {
                                                                  productController
                                                                      .addAddOn(
                                                                          true,
                                                                          index);
                                                                } else if (productController
                                                                            .addOnQtyList[
                                                                        index] ==
                                                                    1) {
                                                                  productController
                                                                      .addAddOn(
                                                                          false,
                                                                          index);
                                                                }
                                                              },
                                                              child: Container(
                                                                width: 100,
                                                                height: 100,
                                                                margin: EdgeInsets.only(
                                                                    right: Dimensions
                                                                        .paddingSizeDefault),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: productController
                                                                              .addOnActiveList[
                                                                          index]
                                                                      ? Theme.of(
                                                                              context)
                                                                          .primaryColor
                                                                      : Theme.of(
                                                                              context)
                                                                          .hintColor
                                                                          .withOpacity(
                                                                              0.15),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          Dimensions
                                                                              .radiusSmall),
                                                                  boxShadow:
                                                                      productController
                                                                              .addOnActiveList[index]
                                                                          ? [
                                                                              BoxShadow(color: Colors.grey[Get.isDarkMode ? 700 : 300]!, blurRadius: 5, spreadRadius: 1)
                                                                            ]
                                                                          : null,
                                                                ),
                                                                child: Column(
                                                                    children: [
                                                                      Expanded(
                                                                        child: Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Text(
                                                                                widget.product.addOns![index].name ?? '',
                                                                                maxLines: 2,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                textAlign: TextAlign.center,
                                                                                style: robotoMedium.copyWith(
                                                                                  color: productController.addOnActiveList[index] ? Colors.white : Theme.of(context).textTheme.bodyLarge!.color,
                                                                                  fontSize: Dimensions.fontSizeSmall,
                                                                                ),
                                                                              ),
                                                                              const SizedBox(height: 5),
                                                                              Text(
                                                                                widget.product.addOns![index].price! > 0 ? PriceConverter.convertPrice(widget.product.addOns![index].price!) : 'free'.tr,
                                                                                maxLines: 1,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: robotoRegular.copyWith(
                                                                                  color: productController.addOnActiveList[index] ? Colors.white : Theme.of(context).textTheme.bodyLarge!.color,
                                                                                  fontSize: Dimensions.fontSizeExtraSmall,
                                                                                ),
                                                                              ),
                                                                            ]),
                                                                      ),
                                                                      productController
                                                                              .addOnActiveList[index]
                                                                          ? Container(
                                                                              padding: const EdgeInsets.symmetric(vertical: 6),
                                                                              margin: EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                                                                color: Theme.of(context).canvasColor,
                                                                              ),
                                                                              child: Row(children: [
                                                                                Expanded(
                                                                                  child: InkWell(
                                                                                    onTap: () {
                                                                                      if (productController.addOnQtyList[index] > 1) {
                                                                                        productController.setAddOnQuantity(false, index);
                                                                                      } else {
                                                                                        productController.addAddOn(false, index);
                                                                                      }
                                                                                    },
                                                                                    child: Center(child: Icon(Icons.remove, size: Dimensions.paddingSizeLarge)),
                                                                                  ),
                                                                                ),
                                                                                Text(
                                                                                  productController.addOnQtyList[index].toString(),
                                                                                  style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                                                                                ),
                                                                                Expanded(
                                                                                  child: InkWell(
                                                                                    onTap: () => productController.setAddOnQuantity(true, index),
                                                                                    child: Center(child: Icon(Icons.add, size: Dimensions.paddingSizeLarge)),
                                                                                  ),
                                                                                ),
                                                                              ]),
                                                                            )
                                                                          : const SizedBox(),
                                                                    ]),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ])
                                              : const SizedBox(),
                                        ]),
                                  ]),
                            ),
                            if (!ResponsiveHelper.isSmallTab())
                              SizedBox(height: Dimensions.paddingSizeSmall),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight:
                              Radius.circular(Dimensions.radiusExtraLarge),
                          bottomLeft:
                              Radius.circular(Dimensions.radiusExtraLarge),
                        ),
                        color: Theme.of(context).canvasColor,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .color!
                                .withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, -4),
                          )
                        ],
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                        child: Row(
                          children: [
                            isTab
                                ? Flexible(
                                    flex: 2,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('total'.tr,
                                            style: robotoRegular.copyWith(
                                                fontSize:
                                                    Dimensions.fontSizeLarge)),
                                        SizedBox(
                                            width: Dimensions.paddingSizeSmall),
                                        SizedBox(
                                            width: Dimensions.paddingSizeSmall),
                                        Text(
                                            PriceConverter.convertPrice(
                                                priceWithAddonsVariation),
                                            style: robotoBold.copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                        SizedBox(
                                            width: Dimensions
                                                .paddingSizeExtraSmall),
                                        (priceWithAddonsVariationWithoutDiscount >
                                                priceWithAddonsVariation)
                                            ? Text(
                                                '(${PriceConverter.convertPrice(priceWithAddonsVariationWithoutDiscount)})',
                                                style: robotoMedium.copyWith(
                                                    color: Theme.of(context)
                                                        .disabledColor,
                                                    fontSize: Dimensions
                                                        .fontSizeSmall,
                                                    decoration: TextDecoration
                                                        .lineThrough),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.paddingSizeDefault),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('total'.tr,
                                              style: robotoRegular.copyWith(
                                                  fontSize: Dimensions
                                                      .fontSizeLarge)),
                                          SizedBox(
                                              width: Dimensions
                                                  .paddingSizeExtraSmall),
                                          Text(
                                              PriceConverter.convertPrice(
                                                  priceWithAddonsVariation),
                                              style: robotoBold.copyWith(
                                                  fontSize: Dimensions
                                                      .fontSizeExtraLarge)),
                                          SizedBox(
                                              width: Dimensions
                                                  .paddingSizeExtraSmall),
                                          (priceWithAddonsVariationWithoutDiscount >
                                                  priceWithAddonsVariation)
                                              ? Text(
                                                  '(${PriceConverter.convertPrice(priceWithAddonsVariationWithoutDiscount)})',
                                                  style: robotoMedium.copyWith(
                                                      color: Theme.of(context)
                                                          .disabledColor,
                                                      fontSize: Dimensions
                                                          .fontSizeSmall,
                                                      decoration: TextDecoration
                                                          .lineThrough),
                                                )
                                              : const SizedBox(),
                                        ]),
                                  ),
                            Flexible(
                              flex: 3,
                              child: CustomButton(
                                margin: EdgeInsets.all(
                                    ResponsiveHelper.isSmallTab()
                                        ? 5
                                        : Dimensions.paddingSizeSmall),
                                buttonText: isAvailable
                                    ? (widget.cart != null)
                                        ? 'update_in_cart'.tr
                                        : 'add_to_cart'.tr
                                    : 'not_available'.tr,
                                onPressed: widget.cart == null &&
                                        !productController.checkStock(
                                            widget.product,
                                            quantity: cartController
                                                .getCartProductQuantityCount(
                                                    widget.product))
                                    ? null
                                    : isAvailable
                                        ? () {
                                            if (variationList.isNotEmpty) {
                                              for (int index = 0;
                                                  index < variationList.length;
                                                  index++) {
                                                if (!variationList[index]
                                                        .isMultiSelect! &&
                                                    variationList[index]
                                                        .isRequired! &&
                                                    !productController
                                                        .selectedVariations[
                                                            index]
                                                        .contains(true)) {
                                                  showCustomSnackBar(
                                                      '${'choose_a_variation_from'.tr} ${variationList[index].name}',
                                                      isToast: true,
                                                      isError: true);
                                                  return;
                                                } else if (variationList[index]
                                                        .isMultiSelect! &&
                                                    (variationList[index]
                                                            .isRequired! ||
                                                        productController
                                                            .selectedVariations[
                                                                index]
                                                            .contains(true)) &&
                                                    variationList[index].min! >
                                                        productController
                                                            .selectedVariationLength(
                                                                productController
                                                                    .selectedVariations,
                                                                index)) {
                                                  showCustomSnackBar(
                                                      '${'you_need_to_select_minimum'.tr} ${variationList[index].min} '
                                                      '${'to_maximum'.tr} ${variationList[index].max} ${'options_from'.tr} ${variationList[index].name} ${'variation'.tr}',
                                                      isError: true,
                                                      isToast: true);
                                                  return;
                                                }
                                              }
                                            }

                                            cart.CartModel cartModel =
                                                CartModel(
                                              price: priceWithVariation,
                                              discountedPrice:
                                                  priceWithDiscount,
                                              variation: [],
                                              discountAmount:
                                                  priceWithVariation -
                                                      PriceConverter
                                                          .convertWithDiscount(
                                                        priceWithVariation,
                                                        discount,
                                                        discountType,
                                                      ),
                                              quantity:
                                                  productController.quantity,
                                              taxAmount: (priceWithVariation -
                                                  PriceConverter
                                                      .convertWithDiscount(
                                                          priceWithVariation,
                                                          widget.product.tax!,
                                                          widget.product
                                                              .taxType!) +
                                                  addonsTax),
                                              addOnIds: addOnIdList,
                                              product: widget.product,
                                              variations: productController
                                                  .selectedVariations,
                                            );

                                            Get.back();
                                            if (Get.isRegistered<
                                                OrderDetailUpdateRmController>()) {
                                              Get.find<
                                                      OrderDetailUpdateRmController>()
                                                  .addCartModel(cartModel);
                                            } else {
                                              cartController.addToCart(
                                                  cartModel,
                                                  widget.cart != null
                                                      ? widget.cartIndex!
                                                      : productController
                                                          .cartIndex);
                                            }
                                            showCustomSnackBar(
                                                'item_added_to_cart'.tr,
                                                isError: false,
                                                isToast: true);
                                            productController.update();
                                          }
                                        : null,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              });
            }),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomRoundedButton(
                  widget: const Icon(Icons.close_outlined, size: 15),
                  image: '',
                  onTap: () => Get.back(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _productDescription() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'description'.tr,
              style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
            ),
            VegTagView(product: widget.product),
          ],
        ),
        SizedBox(
          height: Dimensions.paddingSizeSmall,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: ExpandableText(
            widget.product.description ?? '',
            expandText: 'show_more'.tr,
            collapseText: 'show_less'.tr,
            maxLines: 2,
            linkColor: Colors.blue,
            animation: true,
            animationDuration: const Duration(milliseconds: 500),
            collapseOnTextTap: true,
            urlStyle: const TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    );
  }
}

class VegTagView extends StatelessWidget {
  const VegTagView({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (splashController) {
      return splashController.configModel!.isVegNonVegActive!
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5,
                      color: Theme.of(context).cardColor.withOpacity(0.05))
                ],
              ),
              child: product.productType == null
                  ? const SizedBox()
                  : SizedBox(
                      height: ResponsiveHelper.isSmallTab() ? 25 : 30,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(
                                Dimensions.paddingSizeExtraSmall),
                            child: Image.asset(
                              fit: BoxFit.fitHeight,
                              Images.getImageUrl(product.productType!),
                            ),
                          ),
                          SizedBox(width: Dimensions.paddingSizeSmall),
                          Text(
                            product.productType!.tr,
                            style: robotoRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall),
                          ),
                          SizedBox(width: Dimensions.paddingSizeExtraSmall),
                        ],
                      ),
                    ),
            )
          : const SizedBox();
    });
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required int cartIndex,
    this.product,
  }) : _cartIndex = cartIndex;

  final int _cartIndex;
  final Product? product;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (productController) {
      return Row(children: [
        QuantityButton(
            isIncrement: false,
            onTap: () {
              if (productController.quantity == 1 && _cartIndex != -1) {
                Get.find<CartController>().removeFromCart(_cartIndex);
                Get.back();
              } else if (productController.quantity > 1) {
                productController.setQuantity(false);
              }
            }),
        SizedBox(width: Dimensions.paddingSizeExtraSmall),
        Text(
          productController.quantity.toString(),
          style: robotoBold.copyWith(color: Theme.of(context).primaryColor),
        ),
        SizedBox(width: Dimensions.paddingSizeExtraSmall),
        QuantityButton(
            isIncrement: true,
            onTap: () {
              final CartController cartController = Get.find<CartController>();
              int quantity = cartController.getCartProductQuantityCount(
                  _cartIndex != -1
                      ? cartController.cartList[_cartIndex].product
                      : product);

              if (productController.checkStock(
                _cartIndex != -1
                    ? cartController.cartList[_cartIndex].product
                    : product,
                quantity: productController.quantity + quantity,
              )) {
                productController.setQuantity(true);
              } else {
                showCustomSnackBar('out_of_stock'.tr, isToast: true);
              }
            }),
      ]);
    });
  }
}
