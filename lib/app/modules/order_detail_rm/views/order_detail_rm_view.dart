import 'dart:developer';

import 'package:citgroupvn_efood_table/app/components/button/custom_button.dart';
import 'package:citgroupvn_efood_table/app/components/custom_loader.dart';
import 'package:citgroupvn_efood_table/app/components/divider/custom_divider.dart';
import 'package:citgroupvn_efood_table/app/components/menu/custom_app_bar.dart';
import 'package:citgroupvn_efood_table/app/core/constants/color_constants.dart';
import 'package:citgroupvn_efood_table/app/helper/responsive_helper.dart';
import 'package:citgroupvn_efood_table/app/modules/home/widget/filter_button_widget.dart';
import 'package:citgroupvn_efood_table/app/modules/order_detail_update_rm/model/FootSummary.dart';
import 'package:citgroupvn_efood_table/app/modules/root/no_data_screen.dart';
import 'package:citgroupvn_efood_table/app/resources/dimens/dimensions.dart';
import 'package:citgroupvn_efood_table/app/routes/app_routes.dart';
import 'package:citgroupvn_efood_table/app/util/number_format_utils.dart';
import 'package:citgroupvn_efood_table/app/util/reponsive_utils.dart';
import 'package:citgroupvn_efood_table/app/util/styles.dart';
import 'package:citgroupvn_efood_table/base/base_view.dart';
import 'package:citgroupvn_efood_table/data/model/response/order_details_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/order_detail_rm_controller.dart';

class OrderDetailRmView extends BaseView<OrderDetailRmController> {
  const OrderDetailRmView({Key? key}) : super(key: key);
  @override
  Widget buildView(BuildContext context) {
    OrderDetailRmController controller = Get.put(OrderDetailRmController(
        isOrderDetails: true, orderId: Get.parameters["idOrder"]!));
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
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.paddingSizeLarge),
                    child: Obx(() => FilterButtonWidget(
                          type: controller.idOrder.value,
                          onSelected: (id) async {
                            await controller.fetchWithNewId(id);
                          },
                          items: controller.orderList.value
                              .map((order) => '${'order'.tr}# ${order.id}')
                              .toList(),
                          isBorder: true,
                        )),
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
      //     buttonText: "Chỉnh sửa đơn hàng",
      //     fontSize: Dimensions.fontSizeDefault,
      //     onPressed: () {
      //       Get.toNamed(Routes.ORDER_DETAIL_UPDATE_RM,
      //           parameters: {"idOrder": controller.orderId});
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
                ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount:
                        controller.currentOrderDetails.value.details?.length,
                    itemBuilder: (context, index) {
                      return _subItemDetail(context,
                          subItem: controller
                              .currentOrderDetails.value.details![index]);
                    }),
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
          height: UtilsReponsive.height(context, 15),
        ),
        CustomButton(
            width: 500,
            // height: 50,
            buttonText: "Chỉnh sửa đơn hàng",
            fontSize: Dimensions.fontSizeDefault,
            onPressed: () {
              Get.toNamed(Routes.ORDER_DETAIL_UPDATE_RM,
                  parameters: {"idOrder": controller.orderId});
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

  SizedBox _subItemDetail(BuildContext context, {required Details subItem}) {
    double totalPriceSubItem =
        subItem.productDetails!.price! * subItem.quantity!;
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      subItem.productDetails!.name!,
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
                      )))
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
                          subItem.productDetails!.price!.toString()),
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                ),
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(
                        UtilsReponsive.height(context, 10))),
                alignment: Alignment.center,
                // margin:,
                child: Text(
                  subItem.productDetails!.productType!.tr,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              )),
            ],
          ),
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
              Column(
                children: [
                  Text(
                    'order_summary'.tr,
                    style: robotoBold.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.paddingSizeSmall,
                  ),
                  Text(
                    '${'order'.tr}# ${controller.currentOrderDetails.value.order?.id}',
                    style: robotoBold.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                  ),
                ],
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${'table'.tr} ${controller.tableId} |',
                      style: robotoMedium.copyWith(
                        fontSize: Dimensions.fontSizeLarge,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                    ),
                    TextSpan(
                      text:
                          '${controller.peopleNum ?? 'add'.tr} ${'people'.tr}',
                      style: robotoRegular.copyWith(
                        fontSize: Dimensions.fontSizeLarge,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
