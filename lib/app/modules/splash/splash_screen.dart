import 'dart:convert';
import 'dart:developer';

import 'package:citgroupvn_efood_table/app/modules/cart/cart.dart';
import 'package:citgroupvn_efood_table/app/modules/login/controllers/login_controller.dart';
import 'package:citgroupvn_efood_table/app/modules/login/views/login_view.dart';
import 'package:citgroupvn_efood_table/app/modules/main_tabview/main_tabview.dart';
import 'package:citgroupvn_efood_table/app/modules/splash/check_info.dart';
import 'package:citgroupvn_efood_table/base/base_common.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'splash.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  late StreamSubscription<ConnectivityResult> _onConnectivityChanged;

  @override
  void initState() {
    super.initState();
    _checkCodeEntered();
    WidgetsBinding.instance.addObserver(this);
    _onConnectivityChanged = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // Handle connectivity change
    });
    Get.find<SplashController>().initSharedData();
    Get.find<CartController>().getCartData();
    final loginController = Get.find<LoginController>();
    _route();
  }

  void _route() {
    Future.delayed(Duration(seconds: 2), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? endpointApiUrl = prefs.getString('endpoint_api_url');

      String? accessToken = prefs.getString('token');
      // ConfigModel configModel = await BaseCommon.instance.getConfigData();

      if (endpointApiUrl == null || endpointApiUrl.isEmpty) {
        // Endpoint không tồn tại, chuyển hướng đến màn hình kiểm tra thông tin
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CheckInfoScreen(),
          ),
        );
      } else if (accessToken != null && accessToken.isNotEmpty) {
        // Endpoint tồn tại và token đã được lưu, chuyển hướng đến trang chính
        ConfigModel configModel = await BaseCommon.instance.getConfigData();
        log("hihi" + jsonEncode(configModel));
        Get.find<SplashController>().setConfigModel(configModel);
      } else {
        // Endpoint tồn tại nhưng không có token, chuyển hướng đến màn hình đăng nhập
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginView(),
          ),
        );
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (AppLifecycleState.resumed == state) {
      // Handle app lifecycle change
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    _onConnectivityChanged.cancel();
  }

  Future<void> _checkCodeEntered() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    ConfigModel configModel = await BaseCommon.instance.getConfigData();

    Get.find<SplashController>().setConfigModel(configModel);

    String? baseUrl = await BaseCommon.instance.getEndpointApiUrl();
    if (baseUrl == null || baseUrl.isEmpty) {
      Get.offAll(() => CheckInfoScreen());
    } else {
      _navigateToNextScreen();
    }
  }

  void _navigateToNextScreen() {
    if (ResponsiveHelper.isTab(context) &&
        (Get.find<PromotionalController>()
            .getPromotion('', all: true)
            .isNotEmpty)) {
      Get.offAll(() => const PromotionalPageScreen());
    } else {
      Get.offNamed(Routes.maintabview);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          Navigator.pushReplacementNamed(context, '/login');
        },
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(Images.splashImage, width: Get.height * 0.1),
                  Image.asset(Images.logo, width: Get.height * 0.2),
                ],
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: Get.width,
                  child: Lottie.asset(
                    fit: BoxFit.fitWidth,
                    Images.waveLoading,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
