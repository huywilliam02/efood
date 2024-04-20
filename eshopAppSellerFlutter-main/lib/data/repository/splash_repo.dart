import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:citgroupvn_eshop_seller/data/datasource/remote/dio/dio_client.dart';
import 'package:citgroupvn_eshop_seller/data/datasource/remote/exception/api_error_handler.dart';
import 'package:citgroupvn_eshop_seller/data/model/response/base/api_response.dart';
import 'package:citgroupvn_eshop_seller/utill/app_constants.dart';

class SplashRepo {
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;
  SplashRepo({required this.dioClient, required this.sharedPreferences});

  Future<ApiResponse> getConfig() async {
    try {
      final response = await dioClient!.get(AppConstants.configUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  void initSharedData() async {
    if (!sharedPreferences!.containsKey(AppConstants.cartList)) {
      sharedPreferences!.setStringList(AppConstants.cartList, []);
    }
    if (!sharedPreferences!.containsKey(AppConstants.searchAddress)) {
      sharedPreferences!.setStringList(AppConstants.searchAddress, []);
    }
    if (!sharedPreferences!.containsKey(AppConstants.currency)) {
      sharedPreferences!.setString(AppConstants.currency, '');
    }
  }

  String getCurrency() {
    return sharedPreferences!.getString(AppConstants.currency) ?? '';
  }

  void setCurrency(String currencyCode) {
    sharedPreferences!.setString(AppConstants.currency, currencyCode);
  }

  void setShippingType(String shippingType) {
    sharedPreferences!.setString(AppConstants.shippingType, shippingType);
  }

  Future<ApiResponse> getShippingTypeList(
      BuildContext context, String type) async {
    try {
      List<String> shippingTypeList = [];
      shippingTypeList = ['order_wise', 'product_wise', 'category_wise'];

      Response response = Response(
          requestOptions: RequestOptions(path: ''),
          data: shippingTypeList,
          statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
