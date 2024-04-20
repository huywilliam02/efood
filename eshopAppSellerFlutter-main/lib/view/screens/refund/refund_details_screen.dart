import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:citgroupvn_eshop_seller/helper/date_converter.dart';
import 'package:citgroupvn_eshop_seller/localization/language_constrants.dart';
import 'package:citgroupvn_eshop_seller/provider/refund_provider.dart';
import 'package:citgroupvn_eshop_seller/utill/dimensions.dart';
import 'package:citgroupvn_eshop_seller/utill/styles.dart';
import 'package:citgroupvn_eshop_seller/view/screens/refund/widget/change_log_widget.dart';
import 'package:citgroupvn_eshop_seller/view/screens/refund/widget/refund_details.dart';
import 'package:citgroupvn_eshop_seller/data/model/response/refund_model.dart';

class RefundDetailsScreen extends StatefulWidget {
  final RefundModel? refundModel;
  final int? orderDetailsId;
  final String? variation;
  const RefundDetailsScreen(
      {Key? key, this.refundModel, this.orderDetailsId, this.variation})
      : super(key: key);

  @override
  State<RefundDetailsScreen> createState() => _RefundDetailsScreenState();
}

class _RefundDetailsScreenState extends State<RefundDetailsScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);

    _tabController?.addListener(() {
      if (kDebugMode) {
        print('my index is${_tabController!.index}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).cardColor,
          centerTitle: true,
          elevation: 1,
          leading: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(
                CupertinoIcons.back,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              )),
          title: Column(
            children: [
              Text(
                '${getTranslated('order', context)}# ${widget.refundModel?.orderId}',
                style: robotoBold.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge?.color),
              ),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall),
              Text(
                  DateConverter.localDateToIsoStringAMPM(
                      DateTime.parse(widget.refundModel!.createdAt!)),
                  style: robotoRegular.copyWith(
                      color: Theme.of(context).hintColor,
                      fontSize: Dimensions.fontSizeSmall)),
            ],
          ),
          actions: [
            InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => ChangeLogWidget(
                      paidBy: widget.refundModel!.order!.paymentMethod ?? ''))),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault,
                    vertical: Dimensions.paddingSizeSmall),
                child: Row(
                  children: [
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(50)),
                      child: const Center(
                          child: Icon(
                        Icons.history,
                        color: Colors.white,
                        size: 20,
                      )),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        body: Consumer<RefundProvider>(builder: (context, refundReq, _) {
          return RefundDetailScreen(
              refundModel: widget.refundModel,
              orderDetailsId: widget.orderDetailsId,
              variation: widget.variation);
        }));
  }
}
