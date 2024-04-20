import 'dart:async';
import 'package:efood_kitchen/data/api/api_client.dart';
import 'package:efood_kitchen/util/app_constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> login(String phone, String password) async {
    return await apiClient.postData(AppConstants.loginUri,
        {"email_or_phone": phone, "password": password});
  }
  Future<Response> profile () async {
    return await apiClient.getData(AppConstants.profileUri);
  }


  Future<bool?> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.token, token);
  }



  Future<void> saveBranchId(String branchId) async {
    try {
      await sharedPreferences.setString(AppConstants.branchId, branchId);
    } catch (e) {
      rethrow;
    }
  }


  String getBranchId() {
    return sharedPreferences.getString(AppConstants.branchId) ?? "";
  }


  Future<Response?> updateToken(String branchId) async {
    String? deviceToken;
    if (GetPlatform.isIOS) {
      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
      NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
        alert: true, announcement: false, badge: true, carPlay: false,
        criticalAlert: false, provisional: false, sound: true,
      );
      if(settings.authorizationStatus == AuthorizationStatus.authorized) {
        deviceToken = await _saveDeviceToken();
      }

    }else {
      deviceToken = await _saveDeviceToken();
    }
    if(!GetPlatform.isWeb) {
      FirebaseMessaging.instance.subscribeToTopic('${AppConstants.topic}-$branchId');

    }


    return await apiClient.postData(AppConstants.fcmTokenUri, {"_method": "put", "fcm_token": deviceToken});
  }

  Future<String?> _saveDeviceToken() async {
    String? deviceToken = '@';
    deviceToken = await FirebaseMessaging.instance.getToken();

    if (deviceToken != null) {
      debugPrint('--------Device Token---------- $deviceToken');
    }
    return deviceToken;
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.token) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.token);
  }

  Future<bool> clearSharedData() async {
    sharedPreferences.remove(AppConstants.token);
    FirebaseMessaging.instance.unsubscribeFromTopic(AppConstants.topic);
    return true;
  }

  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.userPassword, password);
      await sharedPreferences.setString(AppConstants.userNumber, number);
    } catch (e) {
      rethrow;
    }
  }


  Future<bool> clearUserNumberAndPassword() async {
    await sharedPreferences.remove(AppConstants.userPassword);
    return await sharedPreferences.remove(AppConstants.userNumber);
  }

  String getUserNumber() {
    return sharedPreferences.getString(AppConstants.userNumber) ?? "";
  }

  String getUserPassword() {
    return sharedPreferences.getString(AppConstants.userPassword) ?? "";
  }

}
