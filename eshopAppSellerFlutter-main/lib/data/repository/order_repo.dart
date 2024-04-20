import 'package:dio/dio.dart';
import 'package:citgroupvn_eshop_seller/data/datasource/remote/dio/dio_client.dart';
import 'package:citgroupvn_eshop_seller/data/datasource/remote/exception/api_error_handler.dart';
import 'package:citgroupvn_eshop_seller/data/model/response/base/api_response.dart';
import 'package:citgroupvn_eshop_seller/utill/app_constants.dart';

class OrderRepo {
  final DioClient? dioClient;
  OrderRepo({required this.dioClient});

  Future<ApiResponse> getOrderList(int offset, String status) async {
    try {
      final response = await dioClient!.get(
          '${AppConstants.orderListUri}?limit=10&offset=$offset&status=$status');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getOrderDetails(String orderID) async {
    try {
      final response =
          await dioClient!.get('${AppConstants.orderDetails}$orderID');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> setDeliveryCharge(int? orderID, String? deliveryCharge,
      String? expectedDeliveryDate) async {
    try {
      final response =
          await dioClient!.post(AppConstants.deliveryChargeForDelivery, data: {
        "order_id": orderID,
        "_method": "put",
        "deliveryman_charge": deliveryCharge,
        "expected_delivery_date": expectedDeliveryDate
      });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> orderStatus(int? orderID, String? status) async {
    try {
      Response response = await dioClient!.post(
        '${AppConstants.updateOrderStatus}$orderID',
        data: {'_method': 'put', 'order_status': status},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getOrderStatusList(String type) async {
    try {
      List<String> addressTypeList = [];
      if (type == 'inhouse_shipping') {
        addressTypeList = ['pending', 'confirmed', 'processing'];
      } else {
        addressTypeList = [
          'pending',
          'confirmed',
          'processing',
          'out_for_delivery',
          'delivered',
          'returned',
          'failed',
          'canceled',
        ];
      }

      Response response = Response(
          requestOptions: RequestOptions(path: ''),
          data: addressTypeList,
          statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> updatePaymentStatus(
      {int? orderId, String? status}) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.paymentStatusUpdate,
        data: {"order_id": orderId, "payment_status": status},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getInvoiceData(int? orderId) async {
    try {
      final response =
          await dioClient!.get('${AppConstants.invoice}?id=$orderId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getOrderFilterData(String? type) async {
    try {
      final response =
          await dioClient!.get('${AppConstants.businessAnalytics}$type');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> assignThirdPartyDeliveryMan(
      String name, String trackingId, int? orderId) async {
    try {
      final response = await dioClient!
          .post(AppConstants.thirdPartyDeliveryManAssign, data: {
        'delivery_service_name': name,
        'third_party_delivery_tracking_id': trackingId,
        'order_id': orderId
      });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> orderAddressEdit({
    String? orderID,
    String? addressType,
    String? contactPersonName,
    String? phone,
    String? city,
    String? zip,
    String? address,
    String? email,
    String? latitude,
    String? longitude,
  }) async {
    try {
      final response =
          await dioClient!.post(AppConstants.orderAddressEdit, data: {
        "order_id": orderID,
        "contact_person_name": contactPersonName,
        "phone": phone,
        "city": city,
        "zip": zip,
        "email": email,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "address_type": addressType,
      });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
