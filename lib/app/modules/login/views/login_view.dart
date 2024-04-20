import 'package:citgroupvn_efood_table/app/core/common/input/common_form_field_widget.dart';
import 'package:citgroupvn_efood_table/app/core/common/menu/common_app_bar.dart';
import 'package:citgroupvn_efood_table/app/core/common/menu/common_scaffold.dart';
import 'package:citgroupvn_efood_table/app/core/common/page_view/loading_view/common_loading_page_progress_indicator.dart';
import 'package:citgroupvn_efood_table/app/modules/cart/cart.dart';
import 'package:citgroupvn_efood_table/app/modules/main_tabview/controller/main_tabview_controller.dart';
import 'package:citgroupvn_efood_table/app/modules/splash/check_info.dart';
import 'package:citgroupvn_efood_table/app/resources/theme/app_text_style.dart';
import 'package:citgroupvn_efood_table/app/util/reponsive_utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends BaseView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget buildView(BuildContext context) {
    LoginController controller = Get.put(LoginController());
    MainTabviewController mainTabviewController =
        Get.put(MainTabviewController());
    return WillPopScope(
      onWillPop: () async {
        controller.onBackLoginPage();
        return true;
      },
      child: controller.isLoading.isTrue
          ? const CommonLoadingPageProgressIndicator()
          : CommonScaffold(
              appBar: _buildAppBar(),
              body: SafeArea(
                child: Container(
                  margin: const EdgeInsets.only(top: 60, left: 16, right: 16),
                  width: context.width,
                  height: context.height,
                  child: SingleChildScrollView(
                    child: Form(
                      child: Column(
                        children: [
                          _buildLogo(),
                          const Text(
                            "Đăng nhập",
                            style:
                                TextStyle(fontSize: 20, color: Colors.black87),
                          ),
                          SizedBox(
                            height: UtilsReponsive.height(context, 20),
                          ),
                          _buildUsernameFormField(),
                          SizedBox(
                            height: UtilsReponsive.height(context, 20),
                          ),
                          _buildPasswordFormField(),
                          TextButton(
                            onPressed: () async {
                              // Get.toNamed(Routes.FORGET_PASSWORD);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text("Lấy lại mật khẩu"),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: UtilsReponsive.height(context, 10),
                          ),
                          _buildLoginButton(context),
                          SizedBox(
                            height: UtilsReponsive.height(context, 20),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text("Chỉnh sửa thông tin chuỗi:"),
                              TextButton(
                                  onPressed: () {
                                    controller.showPopup();
                                  },
                                  child: const Text("Đổi"))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return CommonAppBar(
      backgroundColor: Colors.red,
      title: "Đăng nhập",
      titleTextStyle: AppTextStyle.textTitleAppBar,
      centerTitle: true,
      titleType: AppBarTitle.text,
      leadingIcon: const Icon(
        Icons.arrow_back_ios_new,
        color: Colors.white,
      ),
      onLeadingPressed: () {
        Get.to(() => CheckInfoScreen());
      },
    );
  }

  Widget _buildLogo() {
    return const Center(
      child: Image(
        image: AssetImage("assets/images/logo.png"),
        height: 200,
        width: 200,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildUsernameFormField() {
    return Obx(
      () => CommonFormFieldWidget(
        controllerEditting: controller.usernameController,
        textInputType: TextInputType.text,
        icon: const Icon(Icons.person),
        labelText: 'Tên đăng nhập',
        errorText: controller.validateErrusername.value,
        setValueFunc: controller.setUserNameInput,
      ),
    );
  }

  Widget _buildPasswordFormField() {
    return Obx(
      () => CommonFormFieldWidget(
        isObscureText: controller.checkpassword.value,
        suffixIcon: IconButton(
          icon: Icon(
            controller.checkpassword.value
                ? Icons.visibility_off
                : Icons.visibility,
          ),
          onPressed: () {
            controller.checkpassword.value = !controller.checkpassword.value;
          },
        ),
        icon: const Icon(Icons.lock),
        textInputType: TextInputType.text,
        controllerEditting: controller.passwordController,
        errorText: controller.validateErrPassword.value,
        labelText: "Mật khẩu",
        setValueFunc: controller.setValuePassword,
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Obx(
      () => ConstrainedBox(
        constraints: BoxConstraints.tightFor(width: context.width),
        child: ElevatedButton(
          style: ButtonStyle(
            minimumSize: const MaterialStatePropertyAll(Size(20, 60)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(
              controller.username.value != "" &&
                      controller.password.value != "" &&
                      controller.validateErrusername.isEmpty &&
                      controller.validateErrPassword.isEmpty
                  ? Colors.green
                  : Theme.of(context).primaryColor,
            ),
            padding: MaterialStateProperty.all(const EdgeInsets.all(14)),
          ),
          child: Text(
            "Đăng Nhập",
            style: AppTextStyle.textButton,
          ),
          onPressed: () async {
            await controller.login();
          },
        ),
      ),
    );
  }
}
