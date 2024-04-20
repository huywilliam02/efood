import 'package:efood_kitchen/controller/order_controller.dart';
import 'package:efood_kitchen/data/model/response/order_model.dart';
import 'package:efood_kitchen/helper/responsive_helper.dart';
import 'package:efood_kitchen/util/dimensions.dart';
import 'package:efood_kitchen/view/base/no_data_screen.dart';
import 'package:efood_kitchen/view/base/order_shimmer.dart';
import 'package:efood_kitchen/view/screens/home/widget/order_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class TabHomeView extends StatefulWidget {
  const TabHomeView({Key? key}) : super(key: key);

  @override
  State<TabHomeView> createState() => _TabHomeViewState();
}

class _TabHomeViewState extends State<TabHomeView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (orderController) {
        List<Orders>? orderList = orderController.orderList;

        return Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Stack(
            children: [
              Column(children: [

                orderList != null ? orderList.isNotEmpty ?
                GridView.builder(
                  controller: orderController.scrollController,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: ResponsiveHelper.isSmallTab() ? 2 : 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio:  MediaQuery.of(context).size.width>1200? 1/.77 : 1/1.1,
                  ),
                  padding: const EdgeInsets.all(0),
                  itemCount: orderList.length,
                  itemBuilder: (context, index) {
                    return OrderCardWidget(order: orderList[index]);
                  },
                )
                  : const NoDataScreen() : const OrderShimmer(),
                orderController.isLoading && orderList != null ? Center(child: Padding(
                  padding: const EdgeInsets.all(Dimensions.iconSize),
                  child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
                )) : const SizedBox.shrink(),

              ]),

            ],
          ),
        );
      },
    );
  }
}
//order: orderList[index]