import 'dart:async';
import 'dart:developer';

import 'package:citgroupvn_efood_table/app/util/view_utils.dart';
import 'package:citgroupvn_efood_table/base/base_controller.dart';
import 'package:citgroupvn_efood_table/data/api/api_checker.dart';
import 'package:citgroupvn_efood_table/data/api/get_all_data_users_request.dart';
import 'package:citgroupvn_efood_table/data/model/response/oders_list_details.dart';
import 'package:citgroupvn_efood_table/data/model/response/order_details_model.dart';
import 'package:citgroupvn_efood_table/data/model/response/order_success_model.dart';
import 'package:citgroupvn_efood_table/data/repository/order_repo.dart';
import 'package:citgroupvn_efood_table/app/modules/cart/cart.dart';

class OrderListController extends BaseController implements GetxService {
  final OrderRepo orderRepo;
  OrderListController({required this.orderRepo});

  bool _isLoading = false;
  final List<String> _paymentMethodList = ['cash', 'card'];
  String _selectedMethod = 'cash';
  PlaceOrderBody? _placeOrderBody;
  String? _orderNote;
  String? _currentOrderId;
  String? _currentOrderToken;
  Duration _duration = const Duration();
  Timer? _timer;
  OderListDetails? _orderList;

  String get selectedMethod => _selectedMethod;
  List<String> get paymentMethodList => _paymentMethodList;
  PlaceOrderBody? get placeOrderBody => _placeOrderBody;
  String? get orderNote => _orderNote;
  String? get currentOrderId => _currentOrderId;
  String? get currentOrderToken => _currentOrderToken;
  Duration get duration => _duration;
  OderListDetails? get orderList => _orderList;

  RxBool isLoading = true.obs;
  RxBool lazyLoading = false.obs;
  RxBool noMoreRecord = false.obs;
  Rx<int> itemCount = 0.obs;

  RxList<OderListDetails> listUsers = <OderListDetails>[].obs;
  RxList<OderListDetails> listToView = <OderListDetails>[].obs;
  Rx<OderListDetails?> selectedUser = Rx<OderListDetails?>(null);

  int currentPage = 1;

  @override
  Future<void> onInit() async {
    try {
      isLoading(true);
      fetchMoreData();
    } catch (e) {
      ViewUtils.handleInitError(e);
    } finally {
      isLoading(false);
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

  void showAll() {
    listToView.clear();
    listToView.addAll(listUsers);
  }

  // void goToCart(OderListDetails user) {
  //   Get.to(
  //     () => const CartUpdateView(),
  //   );
  // }

  bool isFetching = false;
  DateTime? lastFetchTime;

  Future<void> fetchMoreDataThrottled() async {
    if (isFetching) return;

    final currentTime = DateTime.now();
    if (lastFetchTime != null &&
        currentTime.difference(lastFetchTime!) < const Duration(seconds: 2)) {
      return; // Throttle requests to every 2 seconds
    }
    try {
      isFetching = true;
      await fetchMoreData();
    } finally {
      isFetching = false;
      lastFetchTime = DateTime.now();
    }
  }

  OrderSuccessModel? _orderSuccessModel;

  Future<OderListDetails?> getOrderList() async {
    getOrderSuccessModel();
    _orderList = null;
    if (_orderSuccessModel?.orderId != '-1') {
      _isLoading = true;
      Response response = await orderRepo.getAllOders(
        _orderSuccessModel!.branchTableToken!,
      );
      if (response.statusCode == 200) {
        try {
          OderListDetails oderListDetails =
              oderListDetailsFromJson(response.body);
          _orderList = oderListDetails;
        } catch (e) {
          _orderList;
        }
      } else {
        ApiChecker.checkApi(response);
      }
      _isLoading = false;
      update();
    } else {
      _orderList;
    }

    return _orderList;
  }

  List<OrderSuccessModel>? getOrderSuccessModel() {
    List<OrderSuccessModel>? list;
    try {
      list = orderRepo.getOrderSuccessModelList();
      list = list.reversed.toList();
      _orderSuccessModel = list.firstWhere((model) {
        return model.tableId ==
                Get.find<SplashController>().getTableId().toString() &&
            Get.find<SplashController>().getBranchId().toString() ==
                model.branchId.toString();
      });
    } catch (e) {
      list = [
        OrderSuccessModel(
          orderId: '-1',
          branchTableToken: '',
        )
      ];
      _orderSuccessModel = list.first;
    }

    return list;
  }

  Future<void> fetchMoreData() async {
    try {
      if (noMoreRecord.value || lazyLoading.value) return;

      currentPage += 1;
      lazyLoading(true);

      await Future.delayed(const Duration(seconds: 1));

      var requestData = GetAllDataUsersRequest(currentPage);

      // Fetch data using the request
      OderListDetails? userData = await requestData.request();

      if (userData == null) {
        noMoreRecord(true);
        return;
      }

      // Update the state with the fetched data
      listUsers.add(userData);
      print('listUsers ${listUsers.length}');

      // Print the fetched data
      print('Fetched Data:');
      print('Order: ${userData.order}');
      print('Details:');
      userData.details?.forEach((detail) {
        print('ID: ${detail.id}');
        print('Product ID: ${detail.productId}');
        print('Order ID: ${detail.orderId}');
        // Print other properties as needed
      });
    } catch (e) {
      log('Error fetching more data: $e');
    } finally {
      lazyLoading(false);
    }
  }
}
