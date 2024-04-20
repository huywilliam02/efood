import 'package:citgroupvn_efood_table/app/components/custom_loader.dart';
import 'package:citgroupvn_efood_table/app/core/constants/color_constants.dart';
import 'package:citgroupvn_efood_table/app/helper/dia_log_helper.dart';
import 'package:citgroupvn_efood_table/app/modules/cart/cart.dart';
import 'package:citgroupvn_efood_table/app/modules/order_detail_update_rm/model/FootSummary.dart';
import 'package:citgroupvn_efood_table/app/modules/order_detail_update_rm/views/pick_product_rm_view.dart';
import 'package:citgroupvn_efood_table/app/util/number_format_utils.dart';
import 'package:citgroupvn_efood_table/app/util/reponsive_utils.dart';
import 'package:citgroupvn_efood_table/data/model/response/order_details_model.dart';
import 'package:flutter/material.dart';
import 'package:citgroupvn_efood_table/data/model/response/place_update_order_model.dart'
    as rm;
import 'package:get/get.dart';

import '../controllers/order_detail_update_rm_controller.dart';

class OrderDetailUpdateRmView extends BaseView<OrderDetailUpdateRmController> {
  const OrderDetailUpdateRmView({Key? key}) : super(key: key);
  @override
  Widget buildView(BuildContext context) {
    return ResponsiveHelper.isTab(context)
        ? _tabletView(context)
        : _mobileView(context);
  }

  _tabletView(BuildContext context) {
    return controller.isLoading.value
        ? Center(
            child: CustomLoader(
            color: Theme.of(context).primaryColor,
          ))
        : !controller.foundError.value
            ? Column(
                children: [
                  SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  SizedBox(
                    height: Dimensions.paddingSizeSmall,
                  ),
                  Flexible(child: _mainData(context)),
                ],
              )
            : NoDataScreen(text: 'no_order_available'.tr);
  }

  _mobileView(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isBackButtonExist: true,
        showCart: false,
        onBackPressed: () => Get.back(),
      ),
      // bottomNavigationBar: CustomButton(
      //     width: 300,
      //     // height: 50,
      //     buttonText: "Cập nhật đơn hàng",
      //     fontSize: Dimensions.fontSizeDefault,
      //     onPressed: () async{
      //      await controller.updateFinal();
      //       // Get.to(
      //       //   () => CartUpdateView(
      //       //     isOrderDetails: true,
      //       //     oderId: controller.orderId.toString(),
      //       //   ),
      //       // );
      //     }),
      body: Obx(() => _tabletView(context)),
    );
  }

  _mainData(BuildContext context) {
    return controller.currentOrderDetails == null
        ? Center(child: CustomLoader(color: Theme.of(context).primaryColor))
        : SingleChildScrollView(
            padding:
                EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
            child: Column(
              children: [
                _headerSummary(context),
                const SizedBox(height: 40),
                Obx(() => ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: controller.listProductsAdded.value.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: _subItemDetail(context,
                            subItem: controller.listProductsAdded.value[index]),
                      );
                    })),
                SizedBox(
                  height: UtilsReponsive.height(context, 15),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Expanded(
                    //   child: CustomButton(
                    //       transparent: true,
                    //       buttonText: "Xoá Đơn Hàng",
                    //       fontSize: Dimensions.fontSizeDefault,
                    //       onPressed: () {}),
                    // ),
                    // SizedBox(
                    //   width: 10,
                    // ),

                    IconButton(
                      onPressed: () {
                        Get.to(() => PickProduct());
                      },
                      icon: Image.asset(
                        Images.orderFood,
                        height: 40,
                      ),
                    ),
                    // Expanded(
                    //   child: CustomButton(
                    //       // height: 50,
                    //       buttonText: "Thêm món",
                    //       fontSize: Dimensions.fontSizeDefault,
                    //       onPressed: () {
                    //         Get.to(() => PickProduct());
                    //       }
                    // ),
                    // ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: UtilsReponsive.height(context, 50)),
                  child: CustomDivider(
                    color: Theme.of(context).disabledColor,
                  ),
                ),
                Obx(() => _footSummary(context,
                    data: controller.footSummaryData.value)),
                SizedBox(
                  height: UtilsReponsive.height(context, 15),
                ),
                SizedBox(
                  height: Dimensions.paddingSizeDefault,
                ),
              ],
            ),
          );
  }

  Column _footSummary(BuildContext context, {required FootSummary data}) {
    return Column(
      children: [
        _rowTextFootSummary(title: "Giá sản phẩm", content: data.originTotal),
        SizedBox(
          height: UtilsReponsive.height(context, 15),
        ),
        _rowTextFootSummary(title: "Giảm giá", content: data.discount),
        SizedBox(
          height: UtilsReponsive.height(context, 15),
        ),
        _rowTextFootSummary(title: "VAT/Thuế", content: data.vat),
        SizedBox(
          height: UtilsReponsive.height(context, 15),
        ),
        _rowTextFootSummary(title: "Phụ gia", content: data.extra),
        SizedBox(
          height: UtilsReponsive.height(context, 15),
        ),
        _rowTextFootSummary(
            title: "Tổng", content: data.finalTotal, isBold: true),
        SizedBox(
          height: UtilsReponsive.height(context, 15),
        ),
        _rowTextFootSummary(
            title: "Số tiền đã thanh toán", content: data.payed),
        SizedBox(
          height: UtilsReponsive.height(context, 15),
        ),
        _rowTextFootSummary(title: "Thay đổi", content: data.change),
        SizedBox(
          height: UtilsReponsive.height(context, 20),
        ),
        CustomButton(
            width: 500,
            // height: 50,
            buttonText: "Cập nhật đơn hàng",
            fontSize: Dimensions.fontSizeDefault,
            onPressed: () async {
              await controller.updateFinal();

              // Get.to(
              //   () => CartUpdateView(
              //     isOrderDetails: true,
              //     oderId: controller.orderId.toString(),
              //   ),
              // );
            }),
      ],
    );
  }

  Row _rowTextFootSummary(
      {required String title, required String content, bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: isBold
              ? TextStyleConstant.black20RobotoBold
              : TextStyleConstant.black16Roboto,
        ),
        Text(
          content,
          style: isBold
              ? TextStyleConstant.black20RobotoBold
              : TextStyleConstant.black16Roboto,
        )
      ],
    );
  }

  SizedBox _subItemDetail(BuildContext context, {required rm.Product subItem}) {
    double totalPriceSubItem = subItem.price!;
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      '${subItem.name}',
                      style: TextStyleConstant.black16Roboto,
                    ),
                  )),
              Expanded(
                  child: Text(
                subItem.quantity.toString(),
                style: TextStyleConstant.black16Roboto,
              )),
              Expanded(
                  flex: 2,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        NumberFormatUtils.formatDong(
                            totalPriceSubItem.toString()),
                        style: TextStyleConstant.black16Roboto,
                      ))),
              IconButton(
                onPressed: () {
                  controller.removeProduct(subItem);
                },
                icon: Icon(Icons.delete,
                    color: Theme.of(context).colorScheme.error),
                alignment: Alignment.center,
                padding: EdgeInsets.zero,
                iconSize: Dimensions.paddingSizeLarge,
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                      NumberFormatUtils.formatDong(
                          subItem.priceOrigin!.toString()),
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                ),
              ),
              Expanded(child: SizedBox())
            ],
          )
        ],
      ),
    );
  }

  Row _headerSummary(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: SizedBox()),
                  Expanded(
                    child: Center(
                      child: Obx(() => Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      '${'table'.tr}  ${controller.tableId.value} | ',
                                  style: robotoMedium.copyWith(
                                    fontSize: Dimensions.fontSizeLarge,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '${controller.peopleNum.value} ${'people'.tr}',
                                  style: robotoRegular.copyWith(
                                    fontSize: Dimensions.fontSizeLarge,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      //Pick Số bàn
                      DialogHelper.openDialog(
                        context,
                        TableInputView(
                          callback: () async {
                            // await controller.updateTable();
                          },
                        ),
                      );
                    },
                    child: Image.asset(
                      Images.editIcon,
                      height: 30,
                      color: Theme.of(context).secondaryHeaderColor,
                      width: 30,
                    ),
                  )),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
