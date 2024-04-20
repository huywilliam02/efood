import 'package:citgroupvn_efood_table/base/base_bindings.dart';
import 'package:get/get.dart';

import '../controllers/order_detail_rm_controller.dart';

class OrderDetailRmBinding extends BaseBindings {
  @override
  void injectService() {
  final Map<String, String> parameters = Get.parameters as Map<String, String>;
  final isOrderDetails = parameters["isOrderDetails"]?.toLowerCase() == "true";
  final String orderId = parameters["idOrder"]??"";
    Get.lazyPut<OrderDetailRmController>(
      () => OrderDetailRmController(isOrderDetails:isOrderDetails, orderId: orderId),
    );
  }
}
