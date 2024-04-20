import 'dart:developer' as dev;
import 'package:citgroupvn_efood_table/data/model/response/login_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseLocal {
  DatabaseLocal._privateConstructor();

  static final DatabaseLocal _instance = DatabaseLocal._privateConstructor();

  static DatabaseLocal get instance => _instance;

  Future<Locale> getLocale() async {
    final prefs = await SharedPreferences.getInstance();
    String? tmp = prefs.getString('language');
    if (tmp != null) {
      switch (tmp) {
        case "en":
          return const Locale("en");
        case "vi":
          return const Locale("vi");
        default:
      }
    }
    return const Locale("en", "UK");
  }

  Future<void> updateLocale(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', key);
  }

  Future<String> getJwtToken() async {
    String accessToken = "";
    final prefs = await SharedPreferences.getInstance();
    String? tmp = prefs.getString('token');
    if (tmp != null) {
      accessToken = tmp;
    }
    return Future<String>.value(accessToken);
  }

  Future<void> saveRefeshToken(String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("token", refreshToken);
  }

  // Future<void> getJwtToken(String accessToken) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString("accessToken", accessToken);
  // }

  Future<String?> getRefeshToken() async {
    await Future.delayed(const Duration(seconds: 3));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<String?> getaccessToken() async {
    await Future.delayed(const Duration(seconds: 3));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> setJwtToken(String accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', accessToken);
  }

  Future<void> removeJwtToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<LoginModel> getLoginModel() async {
    LoginModel rs = LoginModel();
    try {
      Box boxLogin = await Hive.openBox("loginModel");
      if (boxLogin.values.isNotEmpty) {
        rs = await boxLogin.getAt(0) as LoginModel;
      } else {}
    } catch (e) {
      dev.log("HiveDb -getLoginModel-${e.toString()}");
      return Future<LoginModel>.value(rs);
    }
    return Future<LoginModel>.value(rs);
  }

  Future<bool> reNewLoginModel(LoginModel modelLogin) async {
    try {
      Box boxLogin = await Hive.openBox("loginModel");
      await boxLogin.clear();
      await boxLogin.add(modelLogin);
      await boxLogin.close();
    } catch (e) {
      dev.log("HiveDb -reNewLoginModel-${e.toString()}");
      return Future<bool>.value(false);
    }
    return Future<bool>.value(true);
  }

  Future<bool> updateLoginModel(LoginModel modelLogin) async {
    try {
      Box boxLogin = await Hive.openBox("loginModel");
      await boxLogin.clear();
      await boxLogin.add(modelLogin);
      // modelLogin.save();
      // await boxLogin.close();
    } catch (e) {
      dev.log("HiveDb -updateLoginModel-${e.toString()}");
      return Future<bool>.value(false);
    }
    return Future<bool>.value(true);
  }
}
