import 'package:efood_kitchen/controller/order_controller.dart';
import 'package:efood_kitchen/helper/responsive_helper.dart';
import 'package:efood_kitchen/util/dimensions.dart';
import 'package:efood_kitchen/view/screens/home/widget/order_status_tabs_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderStatusTabBar extends StatelessWidget {
  final TextEditingController searchTextController;
  const OrderStatusTabBar({Key? key, required this.searchTextController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: ResponsiveHelper.isSmallTab() ? 40 : 50,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor, width: 1),
        borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)

      ),
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeTabs),
      child: ListView.builder(
          itemCount: OrderStatusTabs.values.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
            return GetBuilder<OrderController>(builder: (controller){
              return InkWell(
                child: BookingStatusTabItem(
                  title: OrderStatusTabs.values.elementAt(index).name,
                ),
                onTap: (){
                  if(searchTextController.text.trim().isNotEmpty) {
                    searchTextController.clear();
                  }
                  Get.find<OrderController>().updateOrderStatusTabs(OrderStatusTabs.values.elementAt(index));
                  if(OrderStatusTabs.values.elementAt(index).name == 'all'){
                    Get.find<OrderController>().getOrderList(1);
                  }else{
                    Get.find<OrderController>().filterOrder(OrderStatusTabs.values.elementAt(index).name, 1);
                  }


                },
              );
            });
          }),
    );
  }
}
