import 'package:citgroupvn_efood_table/base/base_bindings.dart';
import 'package:get/get.dart';

import '../controller/order_list_controller.dart';

class OrderListBinding extends BaseBindings {
  @override
  void injectService() {
    Get.lazyPut<OrderListController>(
      () => OrderListController(orderRepo: Get.find()),
    );
  }
}
