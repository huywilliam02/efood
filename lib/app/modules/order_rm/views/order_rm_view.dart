import 'package:citgroupvn_efood_table/app/components/custom_loader.dart';
import 'package:citgroupvn_efood_table/app/core/constants/data_constant.dart';
import 'package:citgroupvn_efood_table/app/helper/price_converter.dart';
import 'package:citgroupvn_efood_table/app/util/icon_utils.dart';
import 'package:citgroupvn_efood_table/data/model/response/oders_list_details.dart';
import 'package:citgroupvn_efood_table/app/modules/order/payment.dart';
import 'package:citgroupvn_efood_table/app/modules/splash/splash.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../../base/base_view.dart';

import '../controllers/order_rm_controller.dart';

class OrderRmView extends BaseView<OrderRmController> {
  const OrderRmView({Key? key}) : super(key: key);
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveHelper.isTab(context)
          ? null
          : const CustomAppBar(
              isBackButtonExist: false,
              onBackPressed: null,
              showCart: true,
            ),
      body: !ResponsiveHelper.isTab(context)
          ? _body(context)
          : BodyTemplate(
              body: Flexible(child: _body(context)),
              isOrderDetails: true,
            ),
    );
  }

  Center _body(BuildContext context) {
    return Center(
      child: Obx(() => controller.isLoading.value
          ? Center(child: CustomLoader(color: Theme.of(context).primaryColor))
          : controller.orderList.isEmpty
              ? NoDataScreen(text: 'you_hove_no_order'.tr)
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: ListView.builder(
                    itemCount: controller.orderList.value.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.toNamed(Routes.ORDER_DETAIL_RM, parameters: {
                            "isOrderDetails": "true",
                            "idOrder":
                                controller.orderList.value[index].id.toString()
                          });
                          // Get.to(
                          //   () => const OrdersUpdateScreen(
                          //     isOrderDetails: true,
                          //   ),
                          // );
                        },
                        child:
                            _cardItem(order: controller.orderList.value[index]),
                      );
                    },
                  ),
                )),
    );
  }

  Card _cardItem({required Order order}) {
    return Card(
      elevation: 0.2,
      color: ColorConstant.backgroundColor,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Đơn hàng: #${order.id}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  IconsUtils.table,
                  color: Colors.grey,
                ),
                const SizedBox(width: 5),
                Text(
                  "Số bàn: ${order.tableId}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: 20),
                Icon(
                  IconsUtils.people,
                  color: Colors.grey,
                ),
                const SizedBox(width: 5),
                Text(
                  "Số người:  ${order.numberOfPeople}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "Tổng số tiền:${PriceConverter.convertPrice(order.orderAmount!.toDouble())}",
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
