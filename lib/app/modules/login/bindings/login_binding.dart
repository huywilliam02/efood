import 'package:citgroupvn_efood_table/app/modules/cart/cart.dart';
import 'package:citgroupvn_efood_table/base/base_bindings.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends BaseBindings {
  @override
  void injectService() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.lazyPut<SplashController>(
      () => SplashController(apiClient: Get.find(), splashRepo: Get.find()),
    );
  }
}
