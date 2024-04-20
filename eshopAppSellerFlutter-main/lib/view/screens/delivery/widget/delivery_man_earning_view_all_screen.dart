import 'package:flutter/material.dart';
import 'package:citgroupvn_eshop_seller/data/model/response/top_delivery_man.dart';
import 'package:citgroupvn_eshop_seller/localization/language_constrants.dart';
import 'package:citgroupvn_eshop_seller/view/base/custom_app_bar.dart';
import 'package:citgroupvn_eshop_seller/view/screens/delivery/widget/delivery_man_earning_list_view.dart';

class DeliveryManEarningViewAllScreen extends StatefulWidget {
  final DeliveryMan? deliveryMan;
  const DeliveryManEarningViewAllScreen({Key? key, this.deliveryMan})
      : super(key: key);

  @override
  State<DeliveryManEarningViewAllScreen> createState() =>
      _DeliveryManEarningViewAllScreenState();
}

class _DeliveryManEarningViewAllScreenState
    extends State<DeliveryManEarningViewAllScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            title: getTranslated('earning_statement', context),
            isBackButtonExist: true),
        body: SingleChildScrollView(
            controller: _scrollController,
            child: DeliverymanEarningListView(
              deliveryMan: widget.deliveryMan,
              scrollController: _scrollController,
            )));
  }
}
