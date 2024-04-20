import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:citgroupvn_eshop_seller/data/datasource/remote/dio/dio_client.dart';
import 'package:citgroupvn_eshop_seller/data/datasource/remote/exception/api_error_handler.dart';
import 'package:citgroupvn_eshop_seller/data/model/response/base/api_response.dart';
import 'package:citgroupvn_eshop_seller/data/model/response/coupon_model.dart';
import 'package:citgroupvn_eshop_seller/utill/app_constants.dart';

class CouponRepo {
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;

  CouponRepo({required this.dioClient, required this.sharedPreferences});

  Future<ApiResponse> getCouponList(int offset) async {
    try {
      final response = await dioClient!
          .get('${AppConstants.getCouponList}?limit=10&offset=$offset');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> addNewCoupon(Coupons coupons,
      {bool update = false}) async {
    try {
      Response response = await dioClient!.post(
          update
              ? '${AppConstants.updateCoupon}${coupons.id}'
              : AppConstants.addNewCoupon,
          data: update
              ? {
                  'coupon_type': coupons.couponType,
                  'customer_id': coupons.customerId,
                  'limit': coupons.limit,
                  'discount_type': coupons.discountType,
                  'discount': coupons.discount,
                  'min_purchase': coupons.minPurchase,
                  'max_discount': coupons.maxDiscount,
                  'code': coupons.code,
                  'title': coupons.title,
                  'start_date': coupons.startDate,
                  'expire_date': coupons.expireDate,
                  '_method': 'put'
                }
              : coupons.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> deleteCoupon(int? id) async {
    try {
      final response = await dioClient!
          .post('${AppConstants.deleteCoupon}$id', data: {'_method': 'delete'});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> updateCouponStatus(int? id, int status) async {
    try {
      final response = await dioClient!.post(
          '${AppConstants.couponStatusUpdate}$id',
          data: {'_method': 'put', 'status': status});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getCouponCustomerList(String search) async {
    try {
      final response =
          await dioClient!.get('${AppConstants.couponCustomerList}$search');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
