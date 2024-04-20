import 'dart:convert';
import 'dart:developer';

import 'package:citgroupvn_efood_table/app/components/button/custom_button.dart';
import 'package:citgroupvn_efood_table/app/core/constants/color_constants.dart';
import 'package:citgroupvn_efood_table/app/modules/login/views/login_view.dart';
import 'package:citgroupvn_efood_table/app/modules/splash/splash.dart';
import 'package:citgroupvn_efood_table/app/modules/splash/splash_up_branch.dart';
import 'package:citgroupvn_efood_table/app/resources/dimens/dimensions.dart';
import 'package:citgroupvn_efood_table/base/base_common.dart';
import 'package:citgroupvn_efood_table/base/base_controller.dart';
import 'package:citgroupvn_efood_table/data/database/database_local.dart';
import 'package:citgroupvn_efood_table/data/model/response/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginController extends BaseController {
  Rx<bool> isLoading = false.obs;
  Rx<String> username = "".obs;
  Rx<String> password = "".obs;
  Rx<bool> checkpassword = true.obs;
  Rx<String> validateErrusername = "".obs;
  Rx<String> validateErrPassword = "".obs;
  Rx<bool> hasInternet = false.obs;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Rx<LoginModel?> loginModel = Rx<LoginModel?>(null);
  late StreamSubscription streamConnect;
  String? _endpointApiUrl;

  @override
  void onInit() async {
    // await getConnection();
    streamConnect = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        hasInternet(true);
      } else if (result == ConnectivityResult.none) {
        hasInternet(false);
      }
    });

    usernameController = TextEditingController();
    passwordController = TextEditingController();
    _loadEndpointApiUrl();
    super.onInit();
  }

  @override
  void onClose() {
    streamConnect.cancel();
    super.onClose();
  }

  // Future<bool> getConnection() async {
  //   bool isConnection = await InternetConnectionChecker().hasConnection;
  //   hasInternet(isConnection);
  //   return isConnection;
  // }

  Future<void> _loadEndpointApiUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _endpointApiUrl = prefs.getString('endpoint_api_url');
    log(_endpointApiUrl.toString());
  }

  void onBackLoginPage() {
    username("");
    password("");
    validateErrusername("");
    validateErrPassword("");
    usernameController.text = "";
    passwordController.text = "";
  }

  void validateUserName(String value) {
    validateErrusername(value.isEmpty ? "Vui lòng nhập tài khoản" : "");
  }

  void validatePassword(String value) {
    validateErrPassword(value.isEmpty ? "Mật khẩu phải có 8 ký tự" : "");
  }

  void setUserNameInput(String? value) {
    if (value != null) {
      validateUserName(value);
      username(value);
    }
  }

  void setValuePassword(String? value) {
    if (value != null) {
      validatePassword(value);
      password(value);
    }
  }

  Future<void> login() async {
    // Kiểm tra kết nối mạng
    if (!await isConnected()) {
      Get.snackbar(
        "Lỗi",
        "Không có kết nối mạng",
        backgroundColor: Colors.red,
      );
      return;
    }

    if (username.value.isEmpty || password.value.isEmpty) {
      Get.snackbar(
        "Lỗi",
        "Vui lòng nhập tên đăng nhập và mật khẩu",
        backgroundColor: Colors.red,
      );
      return;
    }

    isLoading(true); // Hiển thị loading indicator

    try {
      // Dữ liệu cần gửi
      var data = {
        'email_or_phone': username.value,
        'password': password.value,
      };

      // Thực hiện yêu cầu POST đến API
      var response = await http.post(
        Uri.parse('$_endpointApiUrl/api/v1/auth/staff/login'),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      // Xử lý phản hồi từ API
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        var token = responseData['token'];
        log(token.toString());
        if (token != null) {
          // Lưu token vào trong SharedPreferences hoặc một nơi lưu trữ khác
          // Đảm bảo rằng bạn lưu và xác thực token một cách đúng cách

          // SharedPreferences prefs = await SharedPreferences.getInstance();
          BaseCommon.instance.setToken(token);

          // Chuyển hướng tới màn hình khác sau khi đăng nhập thành công
          Get.off(() => const SplashUpBranchView());

          // Hiển thị thông báo đăng nhập thành công nếu cần thiết
          Get.snackbar(
            "Thông báo",
            responseData['message'] ?? "Đăng nhập thành công",
            backgroundColor: Colors.green,
          );
        } else {
          throw Exception("Không nhận được token từ phản hồi API");
        }
      } else if (response.statusCode == 401) {
        // Đăng nhập không thành công do sai username hoặc password
        Get.snackbar(
          "Lỗi",
          "Tên đăng nhập hoặc mật khẩu không đúng",
          backgroundColor: Colors.red,
        );
      } else {
        // Xử lý lỗi phản hồi khác
        throw Exception("Lỗi không xác định từ máy chủ");
      }
    } catch (e) {
      // Xử lý các ngoại lệ
      print('Đã xảy ra lỗi: $e');
      Get.snackbar(
        "Lỗi",
        e.toString(),
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading(false); // Ẩn loading indicator sau khi hoàn thành
    }
  }

  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  TextEditingController _codeController = TextEditingController();
  Future<void> showPopup() async {
    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Lấy thông tin chuỗi'),
          content: TextFormField(
            controller: _codeController,
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(hintText: 'Nhập mã code'),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                    bgColor: Colors.white,
                    transparent: false,
                    width: 100,
                    // height: 50,
                    buttonText: "Trở lại",
                    fontSize: Dimensions.fontSizeDefault,
                    onPressed: () async {
                      Get.back();
                    }),
                CustomButton(
                    width: 100,
                    // height: 50,
                    buttonText: "Gửi mã",
                    fontSize: Dimensions.fontSizeDefault,
                    onPressed: () async {
                      fetchBranchName();
                    }),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> fetchBranchName() async {
    String code = _codeController.text;
    if (code.isEmpty) {
      _showErrorDialog('Vui lòng nhập mã code.');
      return;
    }

    final response = await http.get(
      Uri.parse(
          'https://res-admin.citgroup.vn/api/v1/check-info-by-branch?code=$code'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      bool success = data['success'];
      if (success) {
        Map<String, dynamic> branchData = data['data'];
        String branchName = branchData['branch_name'];
        String endpointApiUrl = branchData['endpoint_api_url'];
        BaseCommon.instance.saveEndpointApiUrl(endpointApiUrl);
        _showConfirmation(branchName);
      } else {
        String errorMessage = data['message'];
        _showErrorDialog(errorMessage);
      }
    } else {
      _showErrorDialog('Đã xảy ra lỗi khi lấy thông tin chuỗi.');
    }
  }

  Future<void> _showConfirmation(String branchName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('codeEntered', true);

    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thông báo', style: TextStyle(color: Colors.red)),
          content: Text('Bạn đang sử dụng: $branchName'),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                    width: 100,
                    transparent: true,
                    bgColor: Colors.white,
                    buttonText: "Trở lại",
                    fontSize: Dimensions.fontSizeDefault,
                    onPressed: () {
                      Get.back();
                    }),
                CustomButton(
                    width: 100,
                    buttonText: "Xác nhận",
                    fontSize: Dimensions.fontSizeDefault,
                    onPressed: () {
                      Navigator.of(context).pop();
                      Get.off(() => LoginView());
                    }),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _showErrorDialog(String message) async {
    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Lỗi'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('Xác nhận'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
