import 'package:citgroupvn_efood_table/base/base_bindings.dart';
import 'package:get/get.dart';

import '../controllers/order_detail_update_rm_controller.dart';

class OrderDetailUpdateRmBinding extends BaseBindings {
  @override
  void injectService() {
    final parameters = Get.parameters;
    final String orderId = parameters["idOrder"]??"";
    Get.lazyPut<OrderDetailUpdateRmController>(
      () => OrderDetailUpdateRmController(orderId:orderId),
    );
  }
}
