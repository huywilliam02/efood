import 'package:efood_kitchen/controller/auth_controller.dart';
import 'package:efood_kitchen/controller/order_controller.dart';
import 'package:efood_kitchen/controller/theme_controller.dart';
import 'package:efood_kitchen/helper/responsive_helper.dart';
import 'package:efood_kitchen/util/dimensions.dart';
import 'package:efood_kitchen/util/images.dart';
import 'package:efood_kitchen/view/base/animated_dialog.dart';
import 'package:efood_kitchen/view/base/custom_app_bar.dart';
import 'package:efood_kitchen/view/base/custom_loader.dart';
import 'package:efood_kitchen/view/base/custom_rounded_button.dart';
import 'package:efood_kitchen/view/base/logout_dialog.dart';
import 'package:efood_kitchen/view/base/movie_ticket_cliper_path.dart';
import 'package:efood_kitchen/view/base/search_view.dart';
import 'package:efood_kitchen/view/screens/auth/login_screen.dart';
import 'package:efood_kitchen/view/screens/home/widget/order_status_tabs.dart';
import 'package:efood_kitchen/view/screens/home/widget/profile_dialog.dart';
import 'package:efood_kitchen/view/screens/home/widget/tab_order_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widget/order_list_view.dart';

class TabHomeScreen extends StatefulWidget {
  final TextEditingController searchEditController;
  final TabController? tabController;

  const TabHomeScreen({super.key, required this.searchEditController, this.tabController});
  @override
  State<TabHomeScreen> createState() => _TabHomeScreenState();
}

class _TabHomeScreenState extends State<TabHomeScreen> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
        builder: (orderController) {
          return Stack(
            children: [
              const CustomAppBar(
                showCart: true, isBackButtonExist: true, onBackPressed: null, icon: '',
              ),

              Column(
                children: [

                  Flexible(
                    child: Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 4,
                            child: Column(
                              children: [
                                SizedBox(height: MediaQuery.of(context).viewPadding.top + (ResponsiveHelper.isSmallTab() ? 50 : 90),),

                                Row(
                                  children: [
                                    Expanded(child: SearchView(
                                      searchEditController: widget.searchEditController,
                                      tabController: widget.tabController,
                                    )),

                                    Expanded(child: OrderStatusTabBar(searchTextController: widget.searchEditController)),
                                  ],
                                ),

                                Flexible(child: OrderListView(tabController: widget.tabController!)),




                              ],
                            )),

                        GetBuilder<OrderController>(
                            builder: (orderController) {
                              return Expanded(flex: 2,
                                  child: SafeArea(
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                        bottom: Dimensions.paddingSizeDefault,
                                        right: Dimensions.paddingSizeDefault,
                                        left: Dimensions.paddingSizeSmall,
                                      ),
                                      decoration: BoxDecoration(
                                        color:  Theme.of(context).cardColor, borderRadius: BorderRadius.circular(5),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Get.isDarkMode ?  Theme.of(context).cardColor.withOpacity(0.1) : Colors.black.withOpacity(0.1),
                                            offset: const Offset(0, 3.75), blurRadius: 9.29,
                                          )
                                        ],
                                      ),

                                      child: Column(children: [
                                        ClipPath(
                                          clipper: MovieTicketClipperPath(),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).primaryColor,
                                            ),
                                            height: 13,
                                          ),
                                        ),

                                        Expanded(
                                          child: orderController.isLoading ? const CustomLoader() : TabOrderDetailsWidget(
                                            orderId: orderController.orderId,
                                            orderStatus: orderController.orderStatus,
                                            orderNote: orderController.orderNote,
                                          ),
                                        ),


                                      ],),
                                    ),
                                  ));
                            }
                        ),
                      ],
                    ),
                  )




                ],
              ),

              Positioned.fill(child: Align(alignment: Alignment.bottomCenter, child: Padding(
                padding: EdgeInsets.all(
                  ResponsiveHelper.isSmallTab() ?
                  Dimensions.paddingSizeSmall : Dimensions.paddingSizeDefault,
                ),
                child: Row(children: [
                  CustomRoundedButton(image: Images.logOut, onTap: () {
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
                  ),
                  const SizedBox(width: Dimensions.paddingSizeDefault,),

                  CustomRoundedButton(image: Images.themeIcon,
                    onTap: () =>  Get.find<ThemeController>().toggleTheme(),
                  ),
                  const SizedBox(width: Dimensions.paddingSizeDefault,),


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





                ],),
              ))),


            ],
          );
        }
    );
  }
}