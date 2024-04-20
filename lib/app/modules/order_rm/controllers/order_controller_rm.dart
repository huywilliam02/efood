import 'dart:developer';

import 'package:citgroupvn_efood_table/base/base_common.dart';
import 'package:citgroupvn_efood_table/base/base_controller.dart';
import 'package:citgroupvn_efood_table/data/api/api_checker.dart';
import 'package:citgroupvn_efood_table/data/model/response/oders_list_details.dart';
import 'package:citgroupvn_efood_table/data/model/response/order_details_model.dart';
import 'package:citgroupvn_efood_table/data/repository/order_repo.dart';
import 'package:get/get.dart';

class OrderControllerRM extends BaseController {
  RxList<Order> orderList = <Order>[].obs;
  final isLoading = true.obs;

  final OrderRepo orderRepo =
      OrderRepo(apiClient: Get.find(), sharedPreferences: Get.find());

  @override
  Future<void> onInit() async {
    await getOrderList();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getOrderList() async {
    isLoading.value = true;
    Response response = await orderRepo.getAllOders(
      BaseCommon.instance.branchTableToken!,
    );
    if (response.statusCode == 200) {
      try {
        orderList.value = OrderList(
                    order: OrderList.fromJson(response.body)
                        .order
                        ?.reversed
                        .toList())
                .order ??
            [];
      } catch (e) {
        orderList.value = [];
      }
    } else {
      ApiChecker.checkApi(response);
    }
    log("message");
    isLoading.value = false;
  }
}
