import 'package:citgroupvn_efood_table/base/base_bindings.dart';
import 'package:get/get.dart';

import '../settings_controller.dart';

class SettingsBinding extends BaseBindings {  
  @override
  void injectService() {
     Get.lazyPut<SettingsController>(
      () => SettingsController(),
    );
  }
}
