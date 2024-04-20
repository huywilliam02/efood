import 'dart:developer';

import 'package:citgroupvn_efood_table/app/modules/cart/cart.dart';
import 'package:citgroupvn_efood_table/app/modules/order_detail_update_rm/model/FootSummary.dart';
import 'package:citgroupvn_efood_table/base/base_common.dart';
import 'package:citgroupvn_efood_table/base/base_controller.dart';
import 'package:citgroupvn_efood_table/data/api/api_checker.dart';
import 'package:citgroupvn_efood_table/data/model/response/oders_list_details.dart';
import 'package:citgroupvn_efood_table/data/model/response/order_details_model.dart';
import 'package:citgroupvn_efood_table/data/repository/order_repo.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:citgroupvn_efood_table/data/model/response/place_update_order_model.dart'
    as rm;

class OrderDetailRmController extends BaseController {
  //TODO: Implement OrderDetailRmController
  OrderDetailRmController(
      {required this.isOrderDetails, required this.orderId});
  final bool isOrderDetails;
  final String orderId;
  Rx<String> idOrder = ''.obs;
  final count = 0.obs;

  final isLoading = true.obs;
  final foundError = false.obs;
  RxList<Order> orderList = <Order>[].obs;
  Rx<OrderDetails> currentOrderDetails = OrderDetails().obs;
  Rx<FootSummary> footSummaryData = FootSummary().obs;
  RxList<rm.Product> listProductsAdded = <rm.Product>[].obs;

  final OrderRepo orderRepo =
      OrderRepo(apiClient: Get.find(), sharedPreferences: Get.find());
  final tableId = 0.obs;
  final peopleNum = 0.obs;
  @override
  Future<void> onInit() async {
    if (isOrderDetails) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    try {
      idOrder.value = orderId;
      await getOrderList();
      await getOrderDetail(orderId.toString());
      tableId.value = currentOrderDetails.value.order!.tableId!;
      peopleNum.value = currentOrderDetails.value.order!.numberOfPeople!;
      await convertOrderDetailToCart();
      recalculateFinalFoot();
      isLoading.value = false;
    } catch (e) {
      foundError(true);
      log(e.toString());
      isLoading.value = false;
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getOrderList() async {
    log(BaseCommon.instance.branchTableToken!);
    isLoading.value = true;
    Response response = await orderRepo.getAllOders(
      BaseCommon.instance.branchTableToken ?? '',
    );
    log(response.body.toString());
    if (response.statusCode == 200) {
      orderList.value = OrderList(
              order: OrderList.fromJson(response.body).order?.reversed.toList())
          .order!;
    } else {
      ApiChecker.checkApi(response);
    }
  }

  recalculateFinalFoot() {
    footSummaryData.value = FootSummary.fromOderDetail(
        listProduct: listProductsAdded.value,
        orderDetail: currentOrderDetails.value);
    ;
  }

  convertOrderDetailToCart() {
    currentOrderDetails.value.details!.forEach((element) {
      String name = element.productDetails!.name!;
      int productId = element.productDetails!.id!;
      int priceOrigin = element.productDetails!.price!.round();
      double price = element.price! * element.quantity!;
      List<dynamic> variant = [];
      List<Variation> variation = element.variations ?? [];
      int discount = element.discountOnProduct!.round();
      int? quantity = element.quantity;
      int? taxAmount = element.taxAmount?.toInt();
      List<int>? _addOnIds = [];
      List<int>? _addOnQtys = [];

      rm.Product data = rm.Product(
          name: name,
          productId: productId,
          priceOrigin: priceOrigin,
          price: price,
          variant: variant,
          variations: [],
          discountAmount: discount,
          quantity: quantity,
          taxAmount: taxAmount,
          addOnIds: [],
          addOnQtys: []);
      listProductsAdded.add(data);
    });
  }

  Future<void> getOrderDetail(String idOrder) async {
    Response response = await orderRepo.getOrderDetails(
      idOrder.toString(),
      BaseCommon.instance.branchTableToken ?? "",
    );
    if (response.statusCode == 200) {
      currentOrderDetails.value = OrderDetails.fromJson(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
  }

  fetchWithNewId(String id) async {
    try {
      idOrder.value = id;
      isLoading.value = true;
      await getOrderDetail(idOrder.toString());
      isLoading.value = false;
    } catch (e) {
      foundError(true);
      log(e.toString());
      isLoading.value = false;
    }
  }
}
