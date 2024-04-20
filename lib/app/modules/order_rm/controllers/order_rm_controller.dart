import 'dart:developer';

import 'package:citgroupvn_efood_table/base/base_common.dart';
import 'package:citgroupvn_efood_table/base/base_controller.dart';
import 'package:citgroupvn_efood_table/data/api/api_checker.dart';
import 'package:citgroupvn_efood_table/data/model/response/oders_list_details.dart';
import 'package:citgroupvn_efood_table/data/model/response/order_details_model.dart';
import 'package:citgroupvn_efood_table/data/repository/order_repo.dart';
import 'package:get/get.dart';

class OrderRmController extends BaseController {
  RxList<Order> orderList = <Order>[].obs;

  final isLoading = true.obs;

  final OrderRepo orderRepo =
      OrderRepo(apiClient: Get.find(), sharedPreferences: Get.find());

  @override
  Future<void> onInit() async {
    await getOrderList();
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

  // Future<void> getOrderList() async {
  //   try {
  //     log(BaseCommon.instance.branchTableToken!);
  //     isLoading.value = true;
  //     Response response = await orderRepo.getAllOders(
  //       BaseCommon.instance.branchTableToken ?? '',
  //     );
  //     log(response.body.toString());
  //     if (response.statusCode == 200) {
  //       orderList.value = OrderList(
  //                   order: OrderList.fromJson(response.body)
  //                       .order
  //                       ?.reversed
  //                       .toList())
  //               .order ??
  //           [];

  //     } else {
  //       ApiChecker.checkApi(response);
  //     }
  //     isLoading.value = false;
  //   } catch (e) {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> getOrderList() async {
    try {
      // Log token cho mục đích kiểm tra
      BaseCommon.instance.branchTableToken;

      // Đánh dấu là đang tải dữ liệu
      isLoading.value = true;

      // Gửi yêu cầu lấy dữ liệu từ API
      Response response = await orderRepo.getAllOders(
        BaseCommon.instance.branchTableToken ?? '',
      );

      // Log dữ liệu phản hồi từ API cho mục đích kiểm tra

      // Kiểm tra mã phản hồi từ server
      if (response.statusCode == 200) {
        // Chuyển đổi dữ liệu JSON thành đối tượng OrderList
        OrderList orderListData = OrderList.fromJson(response.body);

        // Cập nhật dữ liệu mới vào orderList
        orderList.value = orderListData.order?.reversed.toList() ?? [];
      } else {
        // Xử lý lỗi từ API nếu có
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      // Xử lý ngoại lệ nếu có
      // Ở đây bạn có thể thêm mã xử lý ngoại lệ phù hợp với ứng dụng của mình
    } finally {
      // Đánh dấu là không còn đang tải dữ liệu sau khi hoàn thành hoặc xảy ra lỗi
      isLoading.value = false;
    }
  }
}
