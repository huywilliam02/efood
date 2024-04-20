import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:citgroupvn_efood_table/app/helper/responsive_helper.dart';
import 'package:citgroupvn_efood_table/app/components/dialog/animated_dialog.dart';

class DialogHelper {
  static void openDialog(BuildContext context, Widget child,
      {bool isDismissible = true}) {
    !ResponsiveHelper.isTab(context)
        ? Get.bottomSheet(
            isDismissible: isDismissible,
            child,
            backgroundColor: Colors.transparent,
            enterBottomSheetDuration: const Duration(milliseconds: 100),
            isScrollControlled: true,
          )
        :
        // Get.dialog(
        //   useSafeArea: true,
        //
        //   transitionDuration: Duration(milliseconds: 300),
        //   Dialog(backgroundColor: Colors.transparent, child:  child,),
        // );
        showAnimatedDialog(
            context: context,
            duration: const Duration(milliseconds: 200),
            barrierDismissible: isDismissible,
            builder: (BuildContext context) {
              return Dialog(
                backgroundColor: Colors.transparent,
                child: child,
              );
            },
            animationType: DialogTransitionType.slideFromBottomFade,
          );
  }
}
