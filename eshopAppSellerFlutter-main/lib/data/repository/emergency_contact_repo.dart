import 'package:flutter/foundation.dart';
import 'package:citgroupvn_eshop_seller/data/datasource/remote/dio/dio_client.dart';
import 'package:citgroupvn_eshop_seller/data/datasource/remote/exception/api_error_handler.dart';
import 'package:citgroupvn_eshop_seller/data/model/response/base/api_response.dart';
import 'package:citgroupvn_eshop_seller/utill/app_constants.dart';

class EmergencyContactRepo {
  final DioClient? dioClient;
  EmergencyContactRepo({required this.dioClient});

  Future<ApiResponse> getEmergencyContactListList() async {
    try {
      final response =
          await dioClient!.get(AppConstants.getEmergencyContactList);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> addNewEmergencyContact(String name, String phone, int? id,
      {bool isUpdate = false}) async {
    try {
      if (kDebugMode) {
        print('==id=$id, name=$name, phone = $phone, isUpdate=$isUpdate');
      }
      final response = await dioClient!.post(
          isUpdate
              ? AppConstants.emergencyContactUpdate
              : AppConstants.emergencyContactAdd,
          data: {
            'id': id,
            'name': name,
            'phone': phone,
            '_method': isUpdate ? 'put' : 'post'
          });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> statusOnOffEmergencyContact(int? id, int status) async {
    try {
      final response = await dioClient!.post(
          AppConstants.emergencyContactStatusOnOff,
          data: {'_method': 'put', 'id': id, 'status': status});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> deleteEmergencyContact(int? id) async {
    try {
      final response = await dioClient!.post(
          AppConstants.emergencyContactDelete,
          data: {'_method': 'delete', 'id': id});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
