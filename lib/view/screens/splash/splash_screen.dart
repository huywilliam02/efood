import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:efood_kitchen/controller/auth_controller.dart';
import 'package:efood_kitchen/controller/splash_controller.dart';
import 'package:efood_kitchen/helper/route_helper.dart';
import 'package:efood_kitchen/util/app_constants.dart';
import 'package:efood_kitchen/util/images.dart';
import 'package:efood_kitchen/util/styles.dart';
import 'package:efood_kitchen/view/base/custom_shape.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  late StreamSubscription<ConnectivityResult> _onConnectivityChanged;

  @override
  void initState() {
    super.initState();

    bool firstTime = true;
    _onConnectivityChanged = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(!firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;
        isNotConnected ? const SizedBox() : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        isNotConnected?
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected ? 'no_connection'.tr : 'connected'.tr,
            textAlign: TextAlign.center,
          ),
        )):const SizedBox();
        if(!isNotConnected) {
          _route();
        }
      }
      firstTime = false;
    });

    Get.find<SplashController>().initSharedData();
    _route();

  }

  @override
  void dispose() {
    super.dispose();

    _onConnectivityChanged.cancel();
  }

  void _route() {
    Get.find<SplashController>().getConfigData().then((value) {
      Timer(const Duration(seconds: 1), () async {
        if(Get.find<AuthController>().isLoggedIn()){
          Get.find<AuthController>().getProfile();
          Get.offNamed(RouteHelper.home);

        }else{
          Get.offNamed(RouteHelper.login);
        }

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _globalKey,
      body: Stack(
        children: [
          Positioned(

            child: Align(
              alignment: Alignment.bottomCenter,
              child: CustomPaint(
                size: Size(MediaQuery.of(context).size.width, 300),
                painter: CurvedPainter(),
              ),
            ),
          ),
          Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Image.asset(Images.logo, height: 175),
                Image.asset(Images.logoName, height: 50),
                Text(AppConstants.appName, style: robotoBlack.copyWith(color: Theme.of(context).primaryColor)),

                const Spacer(),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
