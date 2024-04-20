import 'package:citgroupvn_efood_table/app/modules/login/views/login_view.dart';
import 'package:citgroupvn_efood_table/app/modules/splash/check_info.dart';
import 'package:citgroupvn_efood_table/base/base_controller.dart';
import 'package:citgroupvn_efood_table/data/database/database_local.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends BaseController {
  //TODO: Implement SettingController
  bool isDarkMode = false;
  final count = 0.obs;
  @override
  void onInit() {
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

  logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('branch');
    await DatabaseLocal.instance.removeJwtToken();
    Get.offAll(() => LoginView());
  }

  void increment() => count.value++;
}
