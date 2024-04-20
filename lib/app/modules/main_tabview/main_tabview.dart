import 'dart:math' as math;
import 'package:citgroupvn_efood_table/app/core/constants/color_constants.dart';
import 'package:citgroupvn_efood_table/app/modules/login/controllers/login_controller.dart';
import 'package:citgroupvn_efood_table/data/repository/order_repo.dart';
import 'package:citgroupvn_efood_table/app/modules/main_tabview/controller/main_tabview_controller.dart';
import 'package:citgroupvn_efood_table/app/util/icon_utils.dart';
import 'package:citgroupvn_efood_table/app/util/reponsive_utils.dart';
import 'package:citgroupvn_efood_table/base/base_view.dart';
import 'package:citgroupvn_efood_table/app/modules/order_list/controller/order_list_controller.dart';
import 'package:citgroupvn_efood_table/app/modules/settings/settings_controller.dart';
import 'package:citgroupvn_efood_table/app/modules/order_list/view/oder_details.dart';
import 'package:citgroupvn_efood_table/app/modules/order/payment.dart';

// ignore: must_be_immutable
class MainTabView extends BaseView<MainTabviewController> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  MainTabView({super.key});

  @override
  Widget buildView(BuildContext context) {
    Get.lazyPut(() => MainTabviewController());
    Get.lazyPut(() => OrderListController(orderRepo: Get.find()));
    Get.lazyPut(() => SettingsController());
    Get.lazyPut(() => const DetailsOrderScreen());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(
        () => OrderRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorConstant.backgroundColor,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Obx(
          () => controller.body.elementAt(
            controller.selectedIndex.value,
          ),
        ),
        bottomNavigationBar: Obx(
          () => BottomAppBar(
            color: ColorConstant.backgroundColor,
            shape: const CircularNotchedRectangle(),
            notchMargin: 0,
            child: SizedBox(
              height: UtilsReponsive.height(context, 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: MaterialButton(
                            onPressed: () {
                              controller.onItemTapped1(0);
                            },
                            minWidth: UtilsReponsive.width(context, 40),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    IconsUtils.home,
                                    color: controller.selectedIndex.value == 0
                                        ? Theme.of(context).primaryColor
                                        : ColorConstant.secondary1,
                                  ),
                                  Text(
                                    "Trang chủ",
                                    style: TextStyle(
                                      color: controller.selectedIndex.value == 0
                                          ? Theme.of(context).primaryColor
                                          : ColorConstant.secondary1,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: MaterialButton(
                            onPressed: () async {
                              await controller.onItemTapped1(1);
                            },
                            minWidth: UtilsReponsive.width(context, 40),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    IconsUtils.report,
                                    color: controller.selectedIndex.value == 1
                                        ? Theme.of(context).primaryColor
                                        : ColorConstant.secondary1,
                                  ),
                                  Text("Đơn hàng",
                                      style: TextStyle(
                                        color:
                                            controller.selectedIndex.value == 1
                                                ? Theme.of(context).primaryColor
                                                : ColorConstant.secondary1,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: MaterialButton(
                            onPressed: () {
                              controller.onItemTapped1(2);
                            },
                            minWidth: UtilsReponsive.width(context, 40),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    Images.order,
                                    color: controller.selectedIndex.value == 2
                                        ? Theme.of(context).primaryColor
                                        : ColorConstant.secondary1,
                                    height: 26,
                                  ),
                                  Text(
                                    "Chi tiết",
                                    style: TextStyle(
                                      color: controller.selectedIndex.value == 2
                                          ? Theme.of(context).primaryColor
                                          : ColorConstant.secondary1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: MaterialButton(
                            onPressed: () {
                              controller.onItemTapped1(3);
                            },
                            minWidth: UtilsReponsive.width(context, 40),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.settings_outlined,
                                    color: controller.selectedIndex.value == 3
                                        ? Theme.of(context).primaryColor
                                        : ColorConstant.secondary1,
                                  ),
                                  // Image.asset(
                                  //   IconsUtils.more,
                                  // ),
                                  Text(
                                    "Cài đặt",
                                    style: TextStyle(
                                      color: controller.selectedIndex.value == 3
                                          ? Theme.of(context).primaryColor
                                          : ColorConstant.secondary1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
