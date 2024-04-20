import 'package:citgroupvn_efood_table/app/modules/order_rm/controllers/order_rm_controller.dart';
import 'package:citgroupvn_efood_table/base/base_bindings.dart';
import 'package:get/get.dart';

import '../controller/main_tabview_controller.dart';

class MainTabviewBinding extends BaseBindings {
  @override
  void injectService() {
    Get.lazyPut<MainTabviewController>(
      () => MainTabviewController(),
    );
     Get.lazyPut<OrderRmController>(
      () => OrderRmController(),
    );
  }
}
