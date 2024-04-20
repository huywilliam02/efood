import 'package:citgroupvn_efood_table/app/modules/splash/controller/splash_controller.dart';
import 'package:citgroupvn_efood_table/app/components/menu/custom_snackbar.dart';
import 'package:get/get.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      Get.find<SplashController>().removeSharedData();
      // TODO: Auth Login
    } else {
      showCustomSnackBar(response.statusText ?? '');
    }
  }
}
