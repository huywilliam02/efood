import 'dart:convert';

import 'package:citgroupvn_efood_table/app/core/constants/app_constants.dart';
import 'package:citgroupvn_efood_table/app/modules/login/controllers/login_controller.dart';
import 'package:citgroupvn_efood_table/app/modules/order_rm/controllers/order_controller_rm.dart';
import 'package:citgroupvn_efood_table/app/modules/settings/settings_controller.dart';
import 'package:citgroupvn_efood_table/app/modules/order_list/controller/order_list_controller.dart';
import 'package:citgroupvn_efood_table/app/modules/main_tabview/controller/main_tabview_controller.dart';
import 'package:citgroupvn_efood_table/app/modules/cart/controller/cart_controller.dart';
import 'package:citgroupvn_efood_table/app/modules/language/language_controller.dart';
import 'package:citgroupvn_efood_table/app/modules/language/localization_controller.dart';
import 'package:citgroupvn_efood_table/app/modules/order/controller/order_controller.dart';
import 'package:citgroupvn_efood_table/app/modules/product_image/product_controller.dart';
import 'package:citgroupvn_efood_table/app/modules/promotional_page/promotional_controller.dart';
import 'package:citgroupvn_efood_table/app/modules/splash/controller/splash_controller.dart';
import 'package:citgroupvn_efood_table/app/modules/language/theme_controller.dart';
import 'package:citgroupvn_efood_table/data/repository/cart_repo.dart';
import 'package:citgroupvn_efood_table/data/repository/language_repo.dart';
import 'package:citgroupvn_efood_table/data/repository/order_repo.dart';
import 'package:citgroupvn_efood_table/data/repository/product_repo.dart';
import 'package:citgroupvn_efood_table/data/repository/splash_repo.dart';
import 'package:citgroupvn_efood_table/data/api/api_client.dart';
import 'package:citgroupvn_efood_table/data/model/response/language_model.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

Future<Map<String, Map<String, String>>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));

  // Repository
  Get.lazyPut(
      () => SplashRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => LanguageRepo());
  Get.lazyPut(() => ProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(
      () => OrderRepo(sharedPreferences: Get.find(), apiClient: Get.find()));

  // Controller
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(
      () => SplashController(splashRepo: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() => LanguageController(sharedPreferences: Get.find()));
  Get.lazyPut(() => ProductController(
        productRepo: Get.find(),
      ));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => PromotionalController());
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));

  Get.lazyPut(() => MainTabviewController());
  Get.lazyPut(() => OrderListController(orderRepo: Get.find()));
  Get.lazyPut(() => SettingsController());
  Get.lazyPut(() => OrderControllerRM());
  Get.lazyPut(() => LoginController());
  Get.lazyPut(() => OrderListController(orderRepo: Get.find()));

  // Retrieving localized data
  Map<String, Map<String, String>> languages = {};
  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = jsonDecode(jsonStringValues);
    Map<String, String> json = {};
    mappedJson.forEach((key, value) {
      json[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        json;
  }
  return languages;
}
