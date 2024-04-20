import 'dart:convert';
import 'dart:developer';

import 'package:citgroupvn_efood_table/app/modules/cart/cart.dart';
import 'package:citgroupvn_efood_table/app/modules/order_detail_update_rm/model/FootSummary.dart';
import 'package:citgroupvn_efood_table/app/modules/splash/controller/splash_controller.dart';
import 'package:citgroupvn_efood_table/app/util/number_format_utils.dart';
import 'package:citgroupvn_efood_table/base/base_common.dart';
import 'package:citgroupvn_efood_table/base/base_controller.dart';
import 'package:citgroupvn_efood_table/data/api/api_checker.dart';
import 'package:citgroupvn_efood_table/data/model/response/oders_list_details.dart';
import 'package:citgroupvn_efood_table/data/model/response/order_details_model.dart';
import 'package:citgroupvn_efood_table/data/model/response/order_success_model.dart';
import 'package:citgroupvn_efood_table/data/repository/order_repo.dart';
import 'package:get/get.dart';
import 'package:citgroupvn_efood_table/data/model/response/cart_model.dart';
import 'package:citgroupvn_efood_table/data/model/response/place_update_order_model.dart'
    as rm;

class OrderDetailUpdateRmController extends BaseController {
  //TODO: Implement OrderDetailUpdateRmController
  OrderDetailUpdateRmController({required this.orderId});
  final String orderId;
  Rx<String> idOrder = ''.obs;
  final count = 0.obs;

  final isLoading = true.obs;
  final foundError = false.obs;
  RxList<Order> orderList = <Order>[].obs;
  Rx<OrderDetails> currentOrderDetails = OrderDetails().obs;

  Rx<int> tableId = 0.obs;
  Rx<int> peopleNum = 0.obs;

  Rx<FootSummary> footSummaryData = FootSummary().obs;

  RxList<rm.Product> listProductsAdded = <rm.Product>[].obs;
  RxList<rm.Product> listProductsAddedNew = <rm.Product>[].obs;

  RxList<int> listIdTemp = <int>[].obs;
  List<String> listIdAdded = <String>[].obs;

  final OrderRepo orderRepo =
      OrderRepo(apiClient: Get.find(), sharedPreferences: Get.find());
  @override
  Future<void> onInit() async {
    // try {
    idOrder.value = orderId;
    await getOrderDetail(orderId.toString());
    await convertOrderDetailToCart();
    recalculateFinalFoot();

    tableId.value = currentOrderDetails.value.order!.tableId!;
    peopleNum.value = currentOrderDetails.value.order!.numberOfPeople!;

    isLoading.value = false;
    // } catch (e) {
    //   foundError(true);
    //   log(e.toString());
    //   isLoading.value = false;
    // }
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

  Future<void> getOrderDetail(String idOrder) async {
    Response response = await orderRepo.getOrderDetails(
      idOrder.toString(),
      BaseCommon.instance.branchTableToken ?? "",
    );
    log(jsonEncode(response.body));
    if (response.statusCode == 200) {
      currentOrderDetails.value = OrderDetails.fromJson(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
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

  removeProduct(rm.Product detail) async {
    listProductsAdded.remove(detail);
    recalculateFinalFoot();
  }

  recalculateFinalFoot() {
    footSummaryData.value = FootSummary.fromOderDetail(
        listProduct: listProductsAdded.value,
        orderDetail: currentOrderDetails.value);
    ;
  }

  clearTemp() {
    listProductsAdded.addAll(listProductsAddedNew);
    listIdTemp.clear();
    listProductsAddedNew.clear();
    recalculateFinalFoot();
  }

  addCartModel(CartModel cartModel) {
    rm.Product data = rm.Product.fromCartModel(cartModel);
    log(jsonEncode(cartModel));
    if (listIdTemp.indexOf(cartModel.product!.id!) != -1) {
      listProductsAddedNew[listIdTemp.indexOf(cartModel.product!.id!)] = data;
    } else {
      listIdTemp.add(cartModel.product!.id!);
      listProductsAddedNew.add(data);
    }
  }

  int getCartIndex(int id) {
    return listIdTemp.value.indexOf(id);
  }

  updateTable({required int idTable, required int numPeople}) {
    tableId.value = idTable;
    peopleNum.value = numPeople;
  }

  int getCartQty(int id) {
    int qty = 0;
    listProductsAddedNew.forEach((element) {
      if (element.productId == id) {
        qty = element.quantity!;
        return;
      }
    });
    return qty;
  }

  updateFinal() async {
    rm.PlaceUpdateOrderBody placeOrder = rm.PlaceUpdateOrderBody(
        products: listProductsAdded.value,
        branchTableToken: BaseCommon.instance.branchTableToken,
        numberOfPeople: peopleNum.value,
        orderAmount: footSummaryData.value.finalTotalValue,
        orderId: int.tryParse(orderId),
        orderNote: 'Test',
        paymentMethod: currentOrderDetails.value.order!.paymentMethod ?? "",
        paymentStatus: currentOrderDetails.value.order!.paymentStatus!,
        tableId: tableId.value);
    log(jsonEncode(placeOrder));

    Response response = await orderRepo.updatePlaceOrder(placeOrder);
    log(jsonEncode(response.body));
    if (response.statusCode == 200) {
      String message = response.body['message'];
      String orderID = response.body['order_id'].toString();
      log(response.body.toString());
      OrderSuccessModel orderSuccessModel = OrderSuccessModel(
        orderId: '${response.body['order_id']}',
        branchTableToken: response.body['branch_table_token'],
        changeAmount: 0,
        tableId: Get.find<SplashController>().getTableId().toString(),
        branchId: Get.find<SplashController>().getBranchId().toString(),
      );
      BaseCommon.instance.branchTableToken = orderSuccessModel.branchTableToken;
      Get.back();
      Get.snackbar(
        "Thông báo",
        "Cập nhật đơn thành công",
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
    }
  }
}
