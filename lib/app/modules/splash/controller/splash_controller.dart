import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:citgroupvn_efood_table/base/base_common.dart';
import 'package:citgroupvn_efood_table/base/base_controller.dart';
import 'package:citgroupvn_efood_table/app/modules/order/controller/order_controller.dart';
import 'package:citgroupvn_efood_table/data/api/api_checker.dart';
import 'package:citgroupvn_efood_table/data/api/api_client.dart';
import 'package:citgroupvn_efood_table/data/api/login/login_api.dart';
import 'package:citgroupvn_efood_table/data/database/database_local.dart';
import 'package:citgroupvn_efood_table/data/model/response/config_model.dart';
import 'package:citgroupvn_efood_table/data/repository/splash_repo.dart';
import 'package:citgroupvn_efood_table/app/modules/splash/splash.dart';

class SplashController extends BaseController implements GetxService {
  final SplashRepo splashRepo;
  final ApiClient apiClient;
  SplashController({required this.splashRepo, required this.apiClient});

  String accessToken = '';

  final DateTime _currentTime = DateTime.now();
  int? _selectedBranchId;
  int? _selectedTableId;
  bool _isFixTable = false;

  int? get selectedBranchId => _selectedBranchId;
  int? get selectedTableId => _selectedTableId;
  bool get isFixTable => _isFixTable;

  void updateBranchId(int? value, {bool isUpdate = true}) {
    _selectedBranchId = value;
    if (isUpdate) {
      update();
    }
  }

  TableModel? getTable(tableId, {int? branchId}) {
    TableModel? tableModel;
    try {
      tableModel = _configModel?.branch
          ?.firstWhere((branch) => branch.id == (branchId ?? getBranchId()))
          .table
          ?.firstWhere((table) => table.id == tableId);
    } catch (e) {
      debugPrint('table error : $e');
    }
    return tableModel;
  }

  void updateTableId(int? number, {bool isUpdate = true}) {
    _selectedTableId = number;
    if (isUpdate) {
      update();
    }
  }

  void updateFixTable(bool value, bool isUpdate) {
    _isFixTable = value;
    if (isUpdate) {
      update();
    }
  }

  DateTime get currentTime => _currentTime;
  bool _firstTimeConnectionCheck = true;
  bool get firstTimeConnectionCheck => _firstTimeConnectionCheck;

  ConfigModel? _configModel;
  ConfigModel? get configModel => _configModel;

  setConfigModel(ConfigModel value) {
    _configModel = value;
  }

  Future<bool> getConfigData() async {
    Response response = await splashRepo.getConfigData();
    log("hihi" + response.body.toString());
    bool isSuccess = false;
    if (response.statusCode == 200) {
      _configModel = ConfigModel.fromJson(response.body);
      bool check = await BaseCommon.instance.saveConfigData(_configModel!);
      log("haahc check" + check.toString());
      isSuccess = true;
    } else {
      ApiChecker.checkApi(response);
      if (response.statusText == ApiClient.noInternetMessage) {}
      isSuccess = false;
    }
    update();
    return isSuccess;
  }

  Future<bool> initSharedData() {
    return splashRepo.initSharedData();
  }

  Future<bool> removeSharedData() {
    return splashRepo.removeSharedData();
  }

  void setFirstTimeConnectionCheck(bool isChecked) {
    _firstTimeConnectionCheck = isChecked;
  }

  int getTableId() => splashRepo.getTable();

  int getBranchId() => splashRepo.getBranchId();
  bool getIsFixTable() => splashRepo.getFixTable();

  void setBranch(int id, {bool isUpdate = true}) async {
    splashRepo.setBranchId(id);
    apiClient.updateHeader();
    update();
  }

  void setTableId(int id) {
    splashRepo.satTable(id);
    Get.find<OrderController>().getOrderList();
    update();
  }

  void setFixTable(bool value) {
    splashRepo.setFixTable(value);
  }

  int? getSelectedTableCapacity() {
    // Implement the logic to get the selected table capacity
    // For example, if you have a model class named TableModel and a selectedTableId property in your controller:
    // TableModel? selectedTable = getTable(selectedTableId);
    // return selectedTable?.capacity;
    return null; // Replace null with the actual implementation
  }
}
