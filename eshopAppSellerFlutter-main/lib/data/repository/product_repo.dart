import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:citgroupvn_eshop_seller/data/datasource/remote/dio/dio_client.dart';
import 'package:citgroupvn_eshop_seller/data/datasource/remote/exception/api_error_handler.dart';
import 'package:citgroupvn_eshop_seller/data/model/response/base/api_response.dart';
import 'package:citgroupvn_eshop_seller/data/model/response/product_model.dart';
import 'package:citgroupvn_eshop_seller/utill/app_constants.dart';

class ProductRepo {
  final DioClient? dioClient;
  ProductRepo({required this.dioClient});

  Future<ApiResponse> getSellerProductList(
      String sellerId, int offset, String languageCode, String search) async {
    try {
      final response = await dioClient!.get(
        '${AppConstants.sellerProductUri}$sellerId/all-products?limit=20&&offset=$offset&search=$search',
        options: Options(headers: {AppConstants.langKey: languageCode}),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getPosProductList(int offset, List<String> ids) async {
    try {
      final response = await dioClient!.get(
          '${AppConstants.posProductList}?limit=10&&offset=$offset&category_id=${jsonEncode(ids)}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getSearchedPosProductList(
      String search, List<String> ids) async {
    try {
      final response = await dioClient!.get(
          '${AppConstants.searchPosProductList}?limit=10&offset=1&name=$search&category_id=${jsonEncode(ids)}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getStockLimitedProductList(
      int offset, String languageCode) async {
    try {
      final response = await dioClient!.get(
        '${AppConstants.stockOutProductUri}$offset',
        options: Options(headers: {AppConstants.langKey: languageCode}),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getMostPopularProductList(
      int offset, String languageCode) async {
    try {
      final response = await dioClient!.get(
        '${AppConstants.mostPopularProduct}$offset',
        options: Options(headers: {AppConstants.langKey: languageCode}),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getTopSellingProductList(
      int offset, String languageCode) async {
    try {
      final response = await dioClient!.get(
        '${AppConstants.topSellingProduct}$offset',
        options: Options(headers: {AppConstants.langKey: languageCode}),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getProductWiseReviewList(
      int? productId, int offset) async {
    try {
      final response = await dioClient!.get(
        '${AppConstants.productWiseReviewList}$productId?limit=10&offset=$offset',
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getProductDetails(int? productId) async {
    try {
      final response = await dioClient!.get(
        '${AppConstants.productDetails}$productId',
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> productStatusOnOff(int? productId, int status) async {
    try {
      final response = await dioClient!.post(AppConstants.productStatusOnOff,
          data: {"id": productId, "status": status, "_method": "put"});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> barCodeDownLoad(int? id, int quantity) async {
    try {
      final response = await dioClient!.get(
        '${AppConstants.barCodeGenerateUri}?id=$id&quantity=$quantity',
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
