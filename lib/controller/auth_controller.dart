import 'dart:async';
import 'package:efood_kitchen/data/api/api_checker.dart';
import 'package:efood_kitchen/data/model/response/error_response.dart';
import 'package:efood_kitchen/data/model/response/profile_model.dart';
import 'package:efood_kitchen/data/repository/auth_repo.dart';
import 'package:efood_kitchen/view/base/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  late XFile _pickedFile;
  XFile get pickedFile => _pickedFile;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isActiveRememberMe = false;
  bool get isActiveRememberMe => _isActiveRememberMe;
  User _profileModel = User();
  User get profileModel => _profileModel;

 Future<Response> login(String email, String password) async {
  _isLoading = true;
  update();
  
  Response response = await authRepo.login(email, password);
  
  if (response.statusCode == 200) {
    // Check if response.body is not null and is a Map<String, dynamic>
    if (response.body != null && response.body is Map<String, dynamic>) {
      Map<String, dynamic> responseBody = response.body as Map<String, dynamic>;
      
      // Process the response body
      if (responseBody.containsKey('token')) {
        authRepo.saveUserToken(responseBody['token']);
        await getProfile(); // Wait for profile information retrieval to complete before continuing
      }
    }
    _isLoading = false;
  } else {
    // Handle error response
    ErrorResponse errorResponse = ErrorResponse.fromJson(response.body);
    showCustomSnackBar(errorResponse.errors![0].message!);
    ApiChecker.checkApi(response);
    _isLoading = false;
  }
  
  update();
  return response;
}


  Future<Response> getProfile() async {
    _isLoading = true;
    update();
    Response response = await authRepo.profile();
    if (response.statusCode == 200) {
      _profileModel = User.fromJson(response.body);
      await authRepo.updateToken(_profileModel.branch!.id.toString());
      saveBranchId(_profileModel.profile!.branchId.toString());
    }
    _isLoading = false;
    update();
    return response;
  }

  Future<void> updateToken(String branchId) async {
    await authRepo.updateToken(branchId);
  }

  void saveBranchId(String branchId) {
    authRepo.saveBranchId(branchId);
  }

  String getBranchId() {
    return authRepo.getBranchId();
  }

  void toggleRememberMe(bool? value) {
    _isActiveRememberMe = !_isActiveRememberMe;
    update();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  Future<bool> clearSharedData() async {
    return await authRepo.clearSharedData();
  }

  void saveUserNumberAndPassword(String number, String password) {
    authRepo.saveUserNumberAndPassword(number, password);
  }

  Future<bool> clearUserNumberAndPassword() async {
    return authRepo.clearUserNumberAndPassword();
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }

  String getUserNumber() {
    return authRepo.getUserNumber();
  }

  String getUserPassword() {
    return authRepo.getUserPassword();
  }
}
