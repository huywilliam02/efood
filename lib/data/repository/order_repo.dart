import 'dart:convert';

import 'package:citgroupvn_efood_table/data/api/api_client.dart';
import 'package:citgroupvn_efood_table/data/model/response/order_success_model.dart';
import 'package:citgroupvn_efood_table/data/model/response/place_order_body.dart';
import 'package:citgroupvn_efood_table/app/core/constants/app_constants.dart';
import 'package:citgroupvn_efood_table/data/model/response/place_update_order_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  OrderRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getOrderDetails(String orderID, String orderToken) async {
    return await apiClient.getData(
      '${AppConstants.orderDetailsUri}order_id=$orderID&branch_table_token=$orderToken',
    );
  }

  Future<Response> getAllOders(String orderToken) async {
    return await apiClient.getData('${AppConstants.orderListUri}$orderToken');
  }

  //
  Future<Response> placeOrder(PlaceOrderBody orderBody) async {
    return await apiClient.postData(
        AppConstants.placeOrderUri, orderBody.toJson());
  }

  Future<Response> updatePlaceOrder(PlaceUpdateOrderBody orderBody) async {
    return await apiClient.postData(
        AppConstants.updatePlaceOrderUri, orderBody.toJson());
  }

  void setOrderID(String orderInfo) {
    sharedPreferences.setString(AppConstants.orderInfo, orderInfo);
  }

  String getOrderInfo() {
    return sharedPreferences.getString(AppConstants.orderInfo) ?? '';
  }

  List<OrderSuccessModel> getOrderSuccessModelList() {
    List<String>? orderList = [];
    if (sharedPreferences.containsKey(AppConstants.orderInfo)) {
      orderList = sharedPreferences.getStringList(AppConstants.orderInfo);
    }
    List<OrderSuccessModel> orderSuccessList = [];
    orderList?.forEach((orderSuccessModel) => orderSuccessList
        .add(OrderSuccessModel.fromJson(jsonDecode(orderSuccessModel))));
    return orderSuccessList;
  }

  void addOrderModel(List<OrderSuccessModel> orderSuccessList) {
    List<String> orderList = [];
    for (var orderModel in orderSuccessList) {
      orderList.add(jsonEncode(orderModel));
    }
    sharedPreferences.setStringList(AppConstants.orderInfo, orderList);
  }
}
