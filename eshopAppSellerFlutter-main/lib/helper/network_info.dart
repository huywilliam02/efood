import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:citgroupvn_eshop_seller/localization/language_constrants.dart';
import 'package:citgroupvn_eshop_seller/provider/splash_provider.dart';

class NetworkInfo {
  final Connectivity connectivity;
  NetworkInfo(this.connectivity);

  Future<bool> get isConnected async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  static void checkConnectivity(BuildContext context) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (Provider.of<SplashProvider>(context, listen: false)
          .firstTimeConnectionCheck) {
        Provider.of<SplashProvider>(context, listen: false)
            .setFirstTimeConnectionCheck(false);
      } else {
        bool isNotConnected = result == ConnectivityResult.none;
        isNotConnected
            ? const SizedBox()
            : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected
                ? getTranslated('no_connection', context)!
                : getTranslated('connected', context)!,
            textAlign: TextAlign.center,
          ),
        ));
      }
    });
  }
}
