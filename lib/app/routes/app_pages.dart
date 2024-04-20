import 'package:get/get.dart';

import '../modules/home/home_screen.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main_tabview/bindings/main_tabview_binding.dart';
import '../modules/main_tabview/main_tabview.dart';
import '../modules/order_detail_rm/bindings/order_detail_rm_binding.dart';
import '../modules/order_detail_rm/views/order_detail_rm_view.dart';
import '../modules/order_detail_update_rm/bindings/order_detail_update_rm_binding.dart';
import '../modules/order_detail_update_rm/views/order_detail_update_rm_view.dart';
import '../modules/order_rm/views/order_rm_view.dart';
import '../modules/settings/bindings/setting_binding.dart';
import '../modules/settings/setting_view.dart';
import '../modules/splash/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  static List<GetPage> routes = [
    GetPage(name: Routes.initial, page: () => const SplashScreen()),
    GetPage(name: Routes.splash, page: () => const SplashScreen()),
    GetPage(
      name: Routes.home,
      page: () => const HomeScreen(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.maintabview,
      page: () => MainTabView(),
      binding: MainTabviewBinding(),
    ),
    // GetPage(
    //   name: Routes.orderList,
    //   page: () => const OrderListView(),
    //   binding: OrderListBinding(),
    // ),
    GetPage(
      name: Routes.settings,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: Routes.ORDER_RM,
      page: () => const OrderRmView(),
      binding: MainTabviewBinding(),
    ),
    GetPage(
      name: Routes.ORDER_DETAIL_RM,
      page: () => const OrderDetailRmView(),
      binding: OrderDetailRmBinding(),
    ),
    GetPage(
      name: Routes.ORDER_DETAIL_UPDATE_RM,
      page: () => const OrderDetailUpdateRmView(),
      binding: OrderDetailUpdateRmBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
  ];
}
