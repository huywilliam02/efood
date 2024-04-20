import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:citgroupvn_eshop_seller/data/datasource/remote/dio/dio_client.dart';
import 'package:citgroupvn_eshop_seller/data/datasource/remote/exception/api_error_handler.dart';
import 'package:citgroupvn_eshop_seller/data/model/response/base/api_response.dart';
import 'package:citgroupvn_eshop_seller/data/model/response/shop_info_model.dart';
import 'package:citgroupvn_eshop_seller/main.dart';
import 'package:citgroupvn_eshop_seller/provider/auth_provider.dart';
import 'package:citgroupvn_eshop_seller/utill/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

class ShopRepo {
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;
  ShopRepo({required this.dioClient, required this.sharedPreferences});

  Future<ApiResponse> getShop() async {
    try {
      final response = await dioClient!.get(AppConstants.shopUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<http.StreamedResponse> updateShop(ShopModel userInfoModel, File? file,
      XFile? shopBanner, XFile? secondaryBanner, XFile? offerBanner,
      {String? minimumOrderAmount,
      String? freeDeliveryStatus,
      String? freeDeliveryOverAmount}) async {
    http.MultipartRequest request = http.MultipartRequest(
        'POST', Uri.parse('${AppConstants.baseUrl}${AppConstants.shopUpdate}'));
    request.headers.addAll(<String, String>{
      'Authorization':
          'Bearer ${Provider.of<AuthProvider>(Get.context!, listen: false).getUserToken()}'
    });
    if (file != null) {
      request.files.add(http.MultipartFile(
          'logo', file.readAsBytes().asStream(), file.lengthSync(),
          filename: file.path.split('/').last));
    }
    if (shopBanner != null) {
      Uint8List list = await shopBanner.readAsBytes();
      var part = http.MultipartFile(
          'banner', shopBanner.readAsBytes().asStream(), list.length,
          filename: basename(shopBanner.path));
      request.files.add(part);
    }
    if (secondaryBanner != null) {
      Uint8List list = await secondaryBanner.readAsBytes();
      var part = http.MultipartFile('bottom_banner',
          secondaryBanner.readAsBytes().asStream(), list.length,
          filename: basename(secondaryBanner.path));
      request.files.add(part);
    }
    if (offerBanner != null) {
      Uint8List list = await offerBanner.readAsBytes();
      var part = http.MultipartFile(
          'offer_banner', offerBanner.readAsBytes().asStream(), list.length,
          filename: basename(offerBanner.path));
      request.files.add(part);
    }
    Map<String, String> fields = {};
    fields.addAll(<String, String>{
      '_method': 'put',
      'name': userInfoModel.name!,
      'address': userInfoModel.address!,
      'contact': userInfoModel.contact!,
      'minimum_order_amount': minimumOrderAmount ?? '0',
      'free_delivery_status': freeDeliveryStatus ?? "false",
      'free_delivery_over_amount': freeDeliveryOverAmount ?? '0'
    });
    request.fields.addAll(fields);
    http.StreamedResponse response = await request.send();
    print("======>response body==> ${fields.toString()}");
    return response;
  }

  Future<ApiResponse> vacation(String? startDate, String? endDate,
      String? vacationNote, int status) async {
    try {
      final response = await dioClient!.post(AppConstants.vacation, data: {
        "vacation_start_date": startDate,
        "vacation_end_date": endDate,
        "vacation_note": vacationNote,
        "_method": "put",
        "vacation_status": status
      });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> temporaryClose(int status) async {
    try {
      final response = await dioClient!.post(AppConstants.temporaryClose,
          data: {'_method': "put", 'status': status});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
