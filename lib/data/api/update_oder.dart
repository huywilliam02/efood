import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:citgroupvn_efood_table/data/model/response/place_update_order_model.dart';

class UpdateOder {
  static Future<bool> updataOder(PlaceUpdateOrderBody model,
    ) async {
    var dioRequest = dio.Dio();
    dioRequest.options.headers = {'Content-Type': 'application/json'};

    var formData = dio.FormData.fromMap({
      // "order_id": idIngredients,
      // "products": listPath,

      "products": [
        {
          "product_id": 52,
          "price": 162000,
          "variant": "",
          "variations": [],
          "discount_amount": 18000,
          "quantity": 1,
          "tax_amount": 18000,
          "add_on_ids": [],
          "add_on_qtys": []
        },
        {
          "product_id": 51,
          "price": 162000,
          "variant": "",
          "variations": [],
          "discount_amount": 18000,
          "quantity": 1,
          "tax_amount": 18000,
          "add_on_ids": [],
          "add_on_qtys": []
        }
      ],
      "order_note": "",
      "table_id": 5,
      "number_of_people": 2,
      "branch_table_token":
          "XS27hptXLfGle2zHegcELsZjYCFS6aM3Zwohe9PXdrq3u5zmPh",
      "order_id": 100001,
      "payment_method": "cash",
      "payment_status": "paid",
      "order_amount": 500000
    });
    var response = await dioRequest.patch(
      'https://dev-quanlynhahang.citgroup.vn/api/v1/table/order/update',
      data: formData,
    );
    log('updata - status code : ${response.statusCode}');
    log('updata  - body code : ');
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
