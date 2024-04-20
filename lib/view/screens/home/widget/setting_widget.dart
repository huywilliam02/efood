import 'dart:async';

import 'package:efood_kitchen/controller/auth_controller.dart';
import 'package:efood_kitchen/controller/theme_controller.dart';
import 'package:efood_kitchen/util/dimensions.dart';
import 'package:efood_kitchen/view/base/animated_dialog.dart';
import 'package:efood_kitchen/view/base/custom_rounded_button.dart';
import 'package:efood_kitchen/view/base/fab_circular_menu.dart';
import 'package:efood_kitchen/view/base/logout_dialog.dart';
import 'package:efood_kitchen/view/screens/auth/login_screen.dart';
import 'package:efood_kitchen/view/screens/home/widget/profile_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingWidget extends StatefulWidget {
  const SettingWidget({Key? key}) : super(key: key);

  @override
  State<SettingWidget> createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  final GlobalKey<FabCircularMenuState> _fabKey = GlobalKey();
  Timer? _timer;


  void changeButtonState() {
    if (_fabKey.currentState != null && _fabKey.currentState!.isOpen) {
      _fabKey.currentState?.close();
      _timer?.cancel();
      _timer = null;
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      changeButtonState();
      timer.cancel();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom : Dimensions.paddingSizeDefault),
      child: FabCircularMenu(
        key: _fabKey,

        onDisplayChange: (isOpen) {
          if(isOpen){
            _startTimer();
          }
        },
        ringColor: Theme.of(context).cardColor.withOpacity(0.2),
        fabSize: 50,
        ringWidth: 90,
        fabOpenIcon: Icon(Icons.settings, color: Theme.of(context).cardColor),
        ringDiameter: 300,
        children: <Widget>[
          CustomRoundedButton(image: '', onTap: () {
            showAnimatedDialog(context: context,
                barrierDismissible: true,
                animationType: DialogTransitionType.slideFromBottomFade,
                builder: (BuildContext context){
                  return CustomLogOutDialog(
                    icon: Icons.exit_to_app_rounded, title: 'logout'.tr,
                    description: 'do_you_want_to_logout_from_this_account'.tr, onTapFalse:() => Navigator.of(context).pop(false),
                    onTapTrue:() {
                      Get.find<AuthController>().clearSharedData().then((condition) {
                        Navigator.pop(context);
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
                      });
                    },
                    onTapTrueText: 'yes'.tr, onTapFalseText: 'no'.tr,
                  );
                });
          },
            widget: Icon(Icons.exit_to_app, color: Theme.of(context).primaryColor),
          ),

          CustomRoundedButton(image: '',
            onTap: () =>  Get.find<ThemeController>().toggleTheme(),
            widget: Icon(Icons.light_mode_outlined, color: Theme.of(context).primaryColor),
          ),

          CustomRoundedButton(image: '', onTap: () {showAnimatedDialog(context: context,
              barrierDismissible: true,
              animationType: DialogTransitionType.slideFromBottomFade,
              builder: (BuildContext context){
                return Dialog(
                    insetAnimationDuration: const Duration(milliseconds: 400),
                    insetAnimationCurve: Curves.easeIn,
                    elevation: 10,
                    backgroundColor: Theme.of(context).cardColor,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(Dimensions.paddingSizeDefault))),
                    child: const SizedBox(width: 300,
                        child: ProfileDialog()));
              });
          },
            widget: Icon(Icons.person, color: Theme.of(context).primaryColor),
          ),

        ],
      ),
    );
  }
}
