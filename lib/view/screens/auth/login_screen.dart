import 'package:country_code_picker/country_code_picker.dart';
import 'package:efood_kitchen/controller/auth_controller.dart';
import 'package:efood_kitchen/controller/splash_controller.dart';
import 'package:efood_kitchen/helper/responsive_helper.dart';
import 'package:efood_kitchen/helper/route_helper.dart';
import 'package:efood_kitchen/util/dimensions.dart';
import 'package:efood_kitchen/util/images.dart';
import 'package:efood_kitchen/util/styles.dart';
import 'package:efood_kitchen/view/base/custom_button.dart';
import 'package:efood_kitchen/view/base/custom_shape.dart';
import 'package:efood_kitchen/view/base/custom_snackbar.dart';
import 'package:efood_kitchen/view/base/custom_text_field.dart';
import 'package:efood_kitchen/view/screens/auth/widget/country_code_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _countryDialCode;
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode phoneNumberFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    phoneNumberController.text = (Get.find<AuthController>().getUserNumber());
    passwordController.text = (Get.find<AuthController>().getUserPassword());
    var countryDialCode = Get.find<SplashController>().configModel.country;
    var code = countryDialCode != null
        ? CountryCode.fromCountryCode(countryDialCode)!.code
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomPaint(
                size: Size(MediaQuery.of(context).size.width, Get.height * 0.5),
                painter: CurvedPainter(),
              ),
            ),
            GetBuilder<AuthController>(builder: (authController) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                    SizedBox(
                        width: 100,
                        height: Get.height < 700 ? 100 : 150,
                        child: Image.asset(Images.loginLogo)),
                    Text('login'.tr,
                        style: robotoMedium.copyWith(
                            fontSize: Dimensions.fontSizeExtraLarge)),
                    Get.height > 700
                        ? SizedBox(height: Dimensions.fontSizeExtraLarge)
                        : const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeDefault),
                      child: SizedBox(
                        width: ResponsiveHelper.isMobile(context)
                            ? Get.width
                            : Get.width / 2.5,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).highlightColor),
                              padding: const EdgeInsets.only(
                                  left: Dimensions.paddingSizeDefault),
                              margin: const EdgeInsets.only(
                                  top: Dimensions.paddingSizeDefault),
                              child: Row(children: [
                                CodePickerWidget(
                                  onChanged: (CountryCode countryCode) {
                                    _countryDialCode = countryCode.code!;
                                  },
                                  initialSelection: _countryDialCode,
                                  favorite: _countryDialCode != null
                                      ? [_countryDialCode!]
                                      : [],
                                  showDropDownButton: true,
                                  padding: EdgeInsets.zero,
                                  showFlagMain: true,
                                  textStyle: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .color!),
                                ),
                                Container(
                                    height: 40,
                                    width: 1,
                                    color: Theme.of(context).hintColor),
                                Expanded(
                                    child: CustomTextField(
                                  hintText: 'enter_your_phone_number'.tr,
                                  controller: phoneNumberController,
                                  focusNode: phoneNumberFocusNode,
                                  nextFocus: passwordFocusNode,
                                  inputAction: TextInputAction.next,
                                  inputType: TextInputType.phone,
                                )),
                              ]),
                            ),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            CustomTextField(
                              hintText: '5+_character'.tr,
                              controller: passwordController,
                              focusNode: passwordFocusNode,
                              inputAction: TextInputAction.done,
                              inputType: TextInputType.phone,
                              isPassword: true,
                              prefixIcon: Images.lock,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 20.0,
                                  child: Checkbox(
                                    side: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 1),
                                    activeColor: Theme.of(context).primaryColor,
                                    value: authController.isActiveRememberMe,
                                    onChanged: authController.toggleRememberMe,
                                  ),
                                ),
                                const SizedBox(
                                    width: Dimensions.paddingSizeExtraSmall),
                                Text('remember_me'.tr,
                                    style: robotoRegular.copyWith(
                                      fontSize: Dimensions.fontSizeSmall,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveHelper.isTab(context)
                              ? MediaQuery.of(context).size.width / 3.3
                              : Dimensions.paddingSizeDefault),
                      child: Container(
                        child: authController.isLoading
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: const Center(
                                    child: SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: CircularProgressIndicator())))
                            : CustomButton(
                                buttonText: 'login'.tr,
                                onPressed: () {
                                  String phoneNumber =
                                      phoneNumberController.text.trim();
                                  String phoneNumberWithCountryCode =
                                      '${CountryCode.fromCountryCode(_countryDialCode!).dialCode}${phoneNumberController.text.trim()}';
                                  String password =
                                      passwordController.text.trim();
                                  if (phoneNumber.isEmpty) {
                                    showCustomSnackBar(
                                        'phone_number_is_required'.tr);
                                  } else if (password.isEmpty) {
                                    showCustomSnackBar(
                                        'password_is_required'.tr);
                                  } else if (password.length < 6) {
                                    showCustomSnackBar(
                                        'minimum_password_length_is_8'.tr);
                                  } else {
                                    if (Get.find<AuthController>()
                                        .isActiveRememberMe) {
                                      Get.find<AuthController>()
                                          .saveUserNumberAndPassword(
                                              phoneNumber, password);
                                    } else {
                                      Get.find<AuthController>()
                                          .clearUserNumberAndPassword();
                                    }
                                    Get.find<AuthController>()
                                        .login(phoneNumberWithCountryCode,
                                            password)
                                        .then((value) {
                                      if (value.statusCode == 200) {
                                        Get.toNamed(RouteHelper.home);
                                      }
                                    });
                                  }
                                }),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).viewInsets.bottom,
                    )
                  ],
                ),
              );
            }),
          ],
        ));
  }
}
