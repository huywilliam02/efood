// import 'package:citgroupvn_efood_table/app/core/constants/color_constants.dart';
// import 'package:citgroupvn_efood_table/base/base_common.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:get/get.dart';
// import 'package:citgroupvn_efood_table/app/modules/cart/cart.dart';
// import 'package:citgroupvn_efood_table/app/modules/login/views/login_view.dart';

// class CheckInfoScreen extends StatefulWidget {
//   const CheckInfoScreen({Key? key}) : super(key: key);

//   @override
//   _CheckInfoScreenState createState() => _CheckInfoScreenState();
// }

// class _CheckInfoScreenState extends State<CheckInfoScreen> {
//   final TextEditingController _codeController = TextEditingController();
//   String? _endpointApiUrl;

//   @override
//   void initState() {
//     super.initState();
//     _checkLocalStorage();
//   }

//   Future<void> _checkLocalStorage() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     _endpointApiUrl = prefs.getString('endpoint_api_url') ?? '';
//     if (_endpointApiUrl!.isEmpty) {
//       Get.to(() => CheckInfoScreen());
//       // _showPopup();
//     }
//   }

//   // Future<void> _showPopup() async {
//   //   return showDialog<void>(
//   //     context: context,
//   //     barrierDismissible: false,
//   //     builder: (BuildContext context) {
//   //       return AlertDialog(
//   //         title: Text('Nhập mã code chuỗi'),
//   //         content: TextFormField(
//   //           controller: _codeController,
//   //           decoration: InputDecoration(hintText: 'Nhập mã code'),
//   //         ),
//   //         actions: <Widget>[
//   //           CustomButton(
//   //               width: 300,
//   //               // height: 50,
//   //               buttonText: "Gửi mã",
//   //               fontSize: Dimensions.fontSizeDefault,
//   //               onPressed: () async {
//   //                 _fetchBranchName();
//   //               }),
//   //           // ElevatedButton(
//   //           //   child: Text('Submit'),
//   //           //   onPressed: () {
//   //           //     _fetchBranchName();
//   //           //   },
//   //           // ),
//   //         ],
//   //       );
//   //     },
//   //   );
//   // }

//   Future<void> _fetchBranchName() async {
//     String code = _codeController.text;
//     final response = await http.get(
//       Uri.parse(
//           'https://res-admin.citgroup.vn/api/v1/check-info-by-branch?code=$code'),
//     );

//     if (response.statusCode == 200) {
//       Map<String, dynamic> data = json.decode(response.body);
//       bool success = data['success'];
//       if (success) {
//         Map<String, dynamic> branchData = data['data'];
//         String branchName = branchData['branch_name'];
//         String endpointApiUrl = branchData['endpoint_api_url'];
//         BaseCommon.instance.saveEndpointApiUrl(endpointApiUrl);
//         _showConfirmation(branchName);
//       } else {
//         String errorMessage = data['message'];
//         // Handle error
//       }
//     } else {
//       // Handle error
//     }
//   }

//   Future<void> _showConfirmation(String branchName) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(
//         'codeEntered', true); // Lưu trạng thái đã nhập code thành công

//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog.adaptive(
//           title: Text('Thông báo', style: TextStyle(color: Colors.red)),
//           content: Text('Bạn đang sử dụng: $branchName'),
//           backgroundColor: Color.fromARGB(255, 255, 255, 255),
//           actions: <Widget>[
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 CustomButton(
//                     width: 100,
//                     transparent: true,
//                     bgColor: Colors.white,
//                     buttonText: "Trở lại",
//                     fontSize: Dimensions.fontSizeDefault,
//                     onPressed: () {
//                       Get.back();
//                     }),
//                 CustomButton(
//                     width: 100,
//                     // height: 50,
//                     buttonText: "Xác nhận",
//                     fontSize: Dimensions.fontSizeDefault,
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                       Get.off(() => LoginView());
//                     }),
//               ],
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Lấy thông tin chuỗi',
//                 style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 20.0),
//               TextField(
//                 controller: _codeController,
//                 decoration: InputDecoration(
//                   hintText: 'Nhập mã code',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide(
//                       color: ColorConstant.greyE6E8EC,
//                     ),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide(color: Colors.blue),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     // Màu của viền khi không focus
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide(
//                       color: ColorConstant.greyE6E8EC,
//                     ),
//                   ),
//                   contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
//                 ),
//               ),
//               SizedBox(height: 20.0),
//               CustomButton(
//                   width: 400,
//                   // height: 50,
//                   buttonText: "Thực hiện",
//                   fontSize: Dimensions.fontSizeDefault,
//                   onPressed: () async {
//                     _fetchBranchName();
//                   }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:citgroupvn_efood_table/app/core/constants/color_constants.dart';
import 'package:citgroupvn_efood_table/base/base_common.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:citgroupvn_efood_table/app/modules/cart/cart.dart';
import 'package:citgroupvn_efood_table/app/modules/login/views/login_view.dart';

class CheckInfoScreen extends StatefulWidget {
  const CheckInfoScreen({Key? key}) : super(key: key);

  @override
  _CheckInfoScreenState createState() => _CheckInfoScreenState();
}

class _CheckInfoScreenState extends State<CheckInfoScreen> {
  final TextEditingController _codeController = TextEditingController();
  String? _endpointApiUrl;

  @override
  void initState() {
    super.initState();
    _checkLocalStorage();
  }

  Future<void> _checkLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _endpointApiUrl = prefs.getString('endpoint_api_url') ?? '';
    if (_endpointApiUrl!.isEmpty) {
      Get.to(() => CheckInfoScreen());
    }
  }

  Future<void> _fetchBranchName() async {
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
      context: context,
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
      context: context,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Lấy thông tin chuỗi',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _codeController,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  hintText: 'Nhập mã code',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: ColorConstant.greyE6E8EC,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: ColorConstant.greyE6E8EC,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
              ),
              SizedBox(height: 20.0),
              CustomButton(
                  width: 400,
                  buttonText: "Thực hiện",
                  fontSize: Dimensions.fontSizeDefault,
                  onPressed: () async {
                    _fetchBranchName();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
