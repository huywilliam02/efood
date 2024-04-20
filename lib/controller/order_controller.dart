import 'package:efood_kitchen/data/api/api_checker.dart';
import 'package:efood_kitchen/data/model/response/order_details_model.dart';
import 'package:efood_kitchen/data/model/response/order_model.dart';
import 'package:efood_kitchen/data/repository/order_repo.dart';
import 'package:efood_kitchen/view/base/custom_snackbar.dart';
import 'package:efood_kitchen/view/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum OrderStatusTabs {all, confirmed, cooking, done }
class OrderController extends GetxController implements GetxService{
  final OrderRepo orderRepo;
  OrderController({required this.orderRepo});

  List<Orders>? _orderList =[];
  List<Orders>? get orderList => _orderList;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final int _orderListLength = 0;
  int get orderListLength => _orderListLength;
  bool _isFirst = true;
  bool get isFirst => _isFirst;
  final double _discountOnProduct = 0;
  double get discountOnProduct => _discountOnProduct;
  final double _totalTaxAmount = 0;
  double get totalTaxAmount => _totalTaxAmount;
  OrderStatusTabs _selectedBookingStatus = OrderStatusTabs.all;
  OrderStatusTabs get selectedBookingStatus =>_selectedBookingStatus;
  int _orderId = 0;
  int get orderId => _orderId;
  String _orderStatus = '';
  String get orderStatus => _orderStatus;
  String _orderNote = '';
  String get orderNote => _orderNote;

  OrderDetailsModel _orderDetails = OrderDetailsModel(details: [],
      order: Order(id: 0, tableId: 0, numberOfPeople: 0, tableOrderId: 0, orderNote: '', orderStatus: ''));
  OrderDetailsModel get orderDetails => _orderDetails;

  int _offset = 1;
  int get offset => _offset;
  int _pageSize = 1;
  int get pageSize => _pageSize;
  int _orderLength = 1;
  int get orderLength => _orderLength;
  bool _isShadow = true;
  bool get isShadow => _isShadow;
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  bool _isDetails = true;
  bool get isDetails => _isDetails;



  final ScrollController scrollController = ScrollController();
  final TextEditingController searchEditingController = TextEditingController();


  @override
  void onInit(){
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (_offset < _pageSize) {
          _offset++;
          if(_currentIndex == 0){
            getOrderList(_offset, reload: false);
          }else if(_currentIndex == 1){
            filterOrder("confirmed", offset, reload: false);
          }else if(_currentIndex == 2){
            filterOrder("cooking", offset, reload: false);
          }else if(_currentIndex == 3){
            filterOrder("done", offset, reload: false);
          }

        }else{
          _isShadow = false;
          update();
        }
      }
    });
  }

  final List<Tab> orderTypeList = <Tab>[
    Tab(text: 'all'.tr),
    Tab(text: 'confirmed'.tr),
    Tab(text: 'cooking'.tr),
    Tab(text: 'done'.tr),
  ];



  Future<void> getOrderList(int offset, {bool reload = true}) async {
    _offset = offset;
    _isLoading = true;

    if(reload || (offset == 1)){
      _orderList = null;
      _isFirst = true;
      updateOrderStatusTabs(OrderStatusTabs.all);
      setIndex(0);
    }else{
      update();
    }

    Response response = await orderRepo.getOrderList(offset);
    if(response.statusCode == 200) {
      if(reload){
        _orderList = [];
      }
      OrderModel orderModel = OrderModel.fromJson(response.body);
      for (var order in orderModel.data!) {
        _orderList!.add(order);
      }
      _pageSize = orderModel.lastPage!;
      _orderLength = orderModel.total!;

    }else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  Future<void> searchOrder(String orderId) async {
    _isFirst = true;
    _orderList = null;
    setIndex(0);
    updateOrderStatusTabs(OrderStatusTabs.all);
    Response response = await orderRepo.searchOrder(orderId);
    if(response.statusCode == 200) {
      _orderList =[];
      OrderModel orderModel = OrderModel.fromJson(response.body);
      for (var order in orderModel.data!) {
        _orderList!.add(order);
      }

      _isLoading = false;
      _isFirst = false;
    }else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> filterOrder(String orderType, int offset, {bool reload = true}) async {
    _offset = offset;
    _isLoading = true;

    if(reload || (offset == 1)){
      _orderList = null;
      _isFirst = true;
    }

    setIndex(orderType == 'confirmed' ? 1 : orderType == 'cooking' ? 2 : 3);
    Response response = await orderRepo.filterOrder(orderType, offset);
    if(response.statusCode == 200) {
      if(reload || (offset == 1)){
        _orderList =[];
      }
      OrderModel orderModel = OrderModel.fromJson(response.body);
      for (var order in orderModel.data!) {
        _orderList!.add(order);
      }

    }else {

      ApiChecker.checkApi(response);
    }
    _isFirst = false;
    _isLoading = false;
    update();
  }

  Future<OrderDetailsModel> getOrderDetails(int orderID) async {
    _isDetails = true;
    Response apiResponse = await orderRepo.getOrderDetails(orderID);
    if ( apiResponse.statusCode == 200) {
      if(apiResponse.body['order']['order_status']  != 'delivered' && apiResponse.body['order']['order_status'] != 'out_for_delivery') {
        _orderDetails = OrderDetailsModel.fromJson(apiResponse.body);
      }

    } else {
      ApiChecker.checkApi(apiResponse);
    }
    _isDetails = false;
    update();
    return _orderDetails;
  }


  Future<void> orderStatusUpdate(int orderId, String orderStatus) async {
    _isLoading = true;
    Response response = await orderRepo.updateOrderStatus(orderId, orderStatus);
    if(response.statusCode == 200) {
      if(orderStatus == "cooking"){
        setIndex(2);
        filterOrder('cooking',1);

      }else{
        setIndex(3);
        filterOrder('done',1);
      }
      showCustomSnackBar("order_status_updated_successfully".tr, isError: false);
      if(Get.width < 640){
        Get.to(const HomeScreen(fromFilter: true));
      }

    }else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void updateOrderStatusTabs(OrderStatusTabs bookingStatusTabs){
    // _isFirst = true;
    _selectedBookingStatus = bookingStatusTabs;
    // _orderList = [];
    // _isFirst = true;

  }

  void setOrderIdForOrderDetails(int orderId, String orderStatus, String orderNote){
    _orderId = orderId;
    _orderStatus = orderStatus;
    _orderNote = orderNote;
    update();
  }


  void showBottomLoader() {
    _isLoading = true;
    update();
  }

  void removeFirstLoading() {
    _isFirst = true;
    update();
  }

  void setIndex(int index){
    _currentIndex = index;
    update();
  }

}