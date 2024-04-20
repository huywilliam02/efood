import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:citgroupvn_eshop_seller/data/model/body/seller_body.dart';
import 'package:citgroupvn_eshop_seller/data/model/response/base/api_response.dart';
import 'package:citgroupvn_eshop_seller/data/model/response/response_model.dart';
import 'package:citgroupvn_eshop_seller/data/model/response/seller_info.dart';
import 'package:citgroupvn_eshop_seller/data/model/response/withdraw_model.dart';
import 'package:citgroupvn_eshop_seller/data/repository/profile_repo.dart';
import 'package:citgroupvn_eshop_seller/helper/api_checker.dart';
import 'package:http/http.dart' as http;
import 'package:citgroupvn_eshop_seller/localization/language_constrants.dart';
import 'package:citgroupvn_eshop_seller/main.dart';
import 'package:citgroupvn_eshop_seller/view/base/custom_snackbar.dart';
import 'package:citgroupvn_eshop_seller/view/screens/notification/model/notification_model.dart';

class ProfileProvider with ChangeNotifier {
  final ProfileRepo? profileRepo;

  ProfileProvider({required this.profileRepo});

  SellerModel? _userInfoModel;
  SellerModel? get userInfoModel => _userInfoModel;
  int? _userId;
  int? get userId => _userId;
  String? _profileImage;
  String? get profileImage => _profileImage;
  bool _isDeleting = false;
  bool get isDeleting => _isDeleting;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  WithdrawModel? withdrawModel;
  List<WithdrawModel> methodList = [];
  int? methodSelectedIndex = 0;
  List<int?> methodsIds = [];

  Future<ResponseModel> getSellerInfo() async {
    ResponseModel responseModel;
    ApiResponse apiResponse = await profileRepo!.getSellerInfo();
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      _userInfoModel = SellerModel.fromJson(apiResponse.response!.data);
      _userId = _userInfoModel!.id;
      _profileImage = _userInfoModel!.image;
      responseModel = ResponseModel(true, 'successful');
    } else {
      String? errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        errorMessage = apiResponse.error.errors[0].message;
      }
      if (kDebugMode) {
        print(errorMessage);
      }
      responseModel = ResponseModel(false, errorMessage);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
    return responseModel;
  }

  setFreeDeliveryStatus(String val) {
    _userInfoModel?.freeOverDeliveryAmountStatus = int.parse(val);
    notifyListeners();
  }

  Future<ResponseModel> updateUserInfo(SellerModel updateUserModel,
      SellerBody seller, File? file, String token, String password) async {
    _isLoading = true;
    notifyListeners();

    ResponseModel responseModel;
    http.StreamedResponse response = await profileRepo!
        .updateProfile(updateUserModel, seller, file, token, password);
    _isLoading = false;
    if (response.statusCode == 200) {
      String message = 'Success';
      _userInfoModel = updateUserModel;
      responseModel = ResponseModel(true, message);
      if (kDebugMode) {
        print(message);
      }
    } else {
      if (kDebugMode) {
        print('${response.statusCode} ${response.reasonPhrase}');
      }
      responseModel = ResponseModel(
          false, '${response.statusCode} ${response.reasonPhrase}');
    }
    notifyListeners();
    return responseModel;
  }

  List<String> inputValueList = [];
  bool validityCheck = false;

  void checkValidity() {
    for (int i = 0; i < inputValueList.length; i++) {
      if (inputValueList[i].isEmpty) {
        inputValueList.clear();
        validityCheck = true;
        notifyListeners();
      }
    }
  }

  Future<ApiResponse> updateBalance(
      String balance, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    for (TextEditingController textEditingController
        in inputFieldControllerList) {
      inputValueList.add(textEditingController.text.trim());
    }
    ApiResponse apiResponse = await profileRepo!.withdrawBalance(
        keyList, inputValueList, methodList[methodSelectedIndex!].id, balance);
    if (kDebugMode) {
      print(
          '$balance/${keyList.toString()}/${inputValueList.toString()}/${methodList[methodSelectedIndex!].id}');
    }

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      Navigator.pop(Get.context!);
      inputValueList.clear();
      inputFieldControllerList.clear();
      getSellerInfo();
      _isLoading = false;
      showCustomSnackBar(
          getTranslated('withdraw_request_sent_successfully', Get.context!),
          Get.context!,
          isToaster: true,
          isError: false);
    } else {
      _isLoading = false;
    }

    notifyListeners();
    return apiResponse;
  }

  Future<ApiResponse> deleteCustomerAccount(BuildContext context) async {
    _isDeleting = true;
    notifyListeners();
    ApiResponse apiResponse = await profileRepo!.deleteUserAccount();
    if (apiResponse.response!.statusCode == 200) {
      _isLoading = false;
      Map map = apiResponse.response!.data;
      String? message = map['message'];
      showCustomSnackBar(message, Get.context!,
          isToaster: true, isError: false);
    } else {
      _isLoading = false;
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }

  void setTitle(int index, String title) {
    inputFieldControllerList[index].text = title;
  }

  List<TextEditingController> inputFieldControllerList = [];
  void getInputFieldList() {
    inputFieldControllerList = [];
    if (methodList.isNotEmpty) {
      for (int i = 0;
          i < methodList[methodSelectedIndex!].methodFields!.length;
          i++) {
        inputFieldControllerList.add(TextEditingController());
      }
    }
  }

  List<String?> keyList = [];

  void setMethodTypeIndex(int? index, {bool notify = true}) {
    methodSelectedIndex = index;
    keyList = [];
    if (methodList.isNotEmpty) {
      for (int i = 0;
          i < methodList[methodSelectedIndex!].methodFields!.length;
          i++) {
        keyList
            .add(methodList[methodSelectedIndex!].methodFields![i].inputName);
      }
      getInputFieldList();
    }

    if (notify) {
      notifyListeners();
    }
  }

  Future<void> getWithdrawMethods(BuildContext context) async {
    methodList = [];
    methodsIds = [];
    ApiResponse response = await profileRepo!.getDynamicWithDrawMethod();
    if (response.response!.statusCode == 200) {
      response.response!.data
          .forEach((method) => methodList.add(WithdrawModel.fromJson(method)));
      methodSelectedIndex = 0;
      getInputFieldList();
      for (int index = 0; index < methodList.length; index++) {
        methodsIds.add(methodList[index].id);
      }
    } else {
      ApiChecker.checkApi(response);
    }

    notifyListeners();
  }

  NotificationItemModel? notificationModel;
  Future<void> getNotificationList(int offset) async {
    ApiResponse response = await profileRepo!.getNotificationList(offset);
    if (response.response!.statusCode == 200) {
      if (offset == 1) {
        notificationModel =
            NotificationItemModel.fromJson(response.response?.data);
      } else {
        notificationModel?.notification?.addAll(
            NotificationItemModel.fromJson(response.response?.data)
                .notification!);
        notificationModel?.offset =
            NotificationItemModel.fromJson(response.response?.data).offset;
        notificationModel?.totalSize =
            NotificationItemModel.fromJson(response.response?.data).totalSize;
      }
    } else {
      ApiChecker.checkApi(response);
    }

    notifyListeners();
  }

  Future<void> seenNotification(int id) async {
    ApiResponse response = await profileRepo!.seenNotification(id);
    if (response.response!.statusCode == 200) {
      getNotificationList(1);
    } else {
      ApiChecker.checkApi(response);
    }

    notifyListeners();
  }
}
