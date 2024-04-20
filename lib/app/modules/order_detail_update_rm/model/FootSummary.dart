import 'package:citgroupvn_efood_table/app/util/number_format_utils.dart';
import 'package:citgroupvn_efood_table/data/model/response/oder_product_model.dart';
import 'package:citgroupvn_efood_table/data/model/response/order_details_model.dart';
import 'package:citgroupvn_efood_table/data/model/response/place_update_order_model.dart'
    as rm;
class FootSummary {
  String originTotal;
  String discount;
  String vat;
  String extra;
  String finalTotal;
  String payed;
  String change;
   int originTotalValue;
  int discountValue;
  int vatValue;
  int extraValue;
  int finalTotalValue;
  int payedValue;
  int changeValue;
  FootSummary(
      {this.originTotal = '',
      this.discount = '',
      this.vat = '',
      this.extra = '',
      this.finalTotal = '',
      this.change = '',
      this.payed = '',
      this.originTotalValue =0,
      this.discountValue =0 ,
      this.vatValue =0,
      this.extraValue =0,
      this.finalTotalValue =0,
      this.payedValue = 0,
      this.changeValue =0
      });
  factory FootSummary.fromOderDetail({required List<rm.Product> listProduct,required OrderDetails orderDetail}) {
    int originTotal = 0;
    int discount = 0;
    int vat = 0;
    int extra = 0;
    
    listProduct.forEach((element) {
      originTotal+= element.priceOrigin! * element.quantity!;
      vat+=element.taxAmount??0;
      discount+=element.discountAmount ?? 0.toInt();
     });
    int payed = 0;
    int change = 0;

    int finalTotal = (originTotal + vat - discount).round();
    return FootSummary(originTotal:  NumberFormatUtils.formatDong(
      originTotal.toString()),
    discount:'-${ NumberFormatUtils.formatDong(
      discount.toString())}',
    vat: NumberFormatUtils.formatDong(
      vat.toString()),
    extra: NumberFormatUtils.formatDong(
      extra.toString()),
    finalTotal:  NumberFormatUtils.formatDong(
      finalTotal.toString()),
    payed: NumberFormatUtils.formatDong(
      payed.toString()),
    change: NumberFormatUtils.formatDong(
      change.toString()),
      originTotalValue: originTotal,
      discountValue: discount,
      vatValue: vat,
      extraValue: extra,
      payedValue: payed,
      changeValue: change
    );

   
  }
  String calculateFinalSummary(){
      return "120000.0";
    }
}
