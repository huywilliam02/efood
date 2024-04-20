import 'package:efood_kitchen/controller/auth_controller.dart';
import 'package:efood_kitchen/controller/splash_controller.dart';
import 'package:efood_kitchen/util/dimensions.dart';
import 'package:efood_kitchen/util/images.dart';
import 'package:efood_kitchen/util/styles.dart';
import 'package:efood_kitchen/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileDialog extends StatelessWidget {
  const ProfileDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
      ),
      child: GetBuilder<AuthController>(builder: (authController) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
              child: Container(
                transform: Matrix4.translationValues(0, -50, 0),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                        width: 2, color: Theme.of(context).primaryColor)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CustomImage(
                      placeholder: Images.placeholder,
                      image:
                          '${Get.find<SplashController>().baseUrls.kitchenProfileUrl}'
                          '/${authController.profileModel.profile!.image}'),
                ),
              ),
            ),
            Container(
              transform: Matrix4.translationValues(0, -40, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                          '${authController.profileModel.profile!.fName!} ${authController.profileModel.profile!.lName!}',
                          style: robotoBold.copyWith(
                              fontSize: Dimensions.fontSizeOverLarge)),
                    ],
                  ),
                  Text(
                      ' ${'branch'.tr} : ${authController.profileModel.branch!.name!} ',
                      style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          color: Theme.of(context).primaryColor)),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeExtraSmall),
                    child: Text(authController.profileModel.profile!.email!,
                        style: robotoMedium.copyWith()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: Dimensions.paddingSizeDefault),
                    child: Text(authController.profileModel.profile!.phone!,
                        style: robotoMedium.copyWith()),
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
