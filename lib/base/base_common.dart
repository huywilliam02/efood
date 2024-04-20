import 'dart:convert';
import 'dart:developer';

import 'package:citgroupvn_efood_table/data/model/response/config_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseCommon {
  static BaseCommon? _instance;
  String? branchTableToken;
  String? baseUrl;

  BaseCommon._internal();

  static BaseCommon get instance {
    _instance ??= BaseCommon._internal();
    return _instance!;
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    branchTableToken = prefs.getString("token");
    return branchTableToken;
  }

  Future<bool> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString("token", token);
  }

  Future<bool> saveConfigData(ConfigModel config) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.setString("config", jsonEncode(config));
  }

  Future<ConfigModel> getConfigData() async {
    final prefs = await SharedPreferences.getInstance();
    // log("alo alo" + jsonDecode(prefs.getString("config")!).toString());

    return ConfigModel.fromJson(jsonDecode(prefs.getString("config") ?? ""));
  }

  Future<void> saveEndpointApiUrl(String branchName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('endpoint_api_url', branchName);
    baseUrl = branchName;
  }

  Future<String?> getEndpointApiUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    baseUrl = prefs.getString('endpoint_api_url');
    return baseUrl;
  }
}
