// To parse this JSON data, do
//
//     final placeUpdateOrderBody = placeUpdateOrderBodyFromJson(jsonString);

import 'dart:convert';
import 'package:citgroupvn_efood_table/data/model/response/cart_model.dart';
import 'package:citgroupvn_efood_table/data/model/response/place_order_body.dart';

PlaceUpdateOrderBody placeUpdateOrderBodyFromJson(String str) =>
    PlaceUpdateOrderBody.fromJson(json.decode(str));

String placeUpdateOrderBodyToJson(PlaceUpdateOrderBody data) =>
    json.encode(data.toJson());

class PlaceUpdateOrderBody {
  List<Product>? products;
  String? orderNote;
  int? tableId;
  int? numberOfPeople;
  String? branchTableToken;
  int? orderId;
  String? paymentMethod;
  String? paymentStatus;
  int? orderAmount;

  PlaceUpdateOrderBody({
    this.products,
    this.orderNote,
    this.tableId,
    this.numberOfPeople,
    this.branchTableToken,
    this.orderId,
    this.paymentMethod,
    this.paymentStatus,
    this.orderAmount,
  });

  PlaceUpdateOrderBody copyWith(
      {String? paymentStatus,
      String? paymentMethod,
      String? token,
      double? previousDue}) {
    if (paymentStatus != null) {
      paymentStatus;
    }
    if (paymentMethod != null) {
      paymentMethod;
    }
    if (token != null) {
      token;
    }
    if (previousDue != null) {
      orderAmount! - previousDue;
    }
    return this;
  }

  factory PlaceUpdateOrderBody.fromJson(Map<String, dynamic> json) =>
      PlaceUpdateOrderBody(
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
        orderNote: json["order_note"],
        tableId: json["table_id"],
        numberOfPeople: json["number_of_people"],
        branchTableToken: json["branch_table_token"],
        orderId: json["order_id"],
        paymentMethod: json["payment_method"],
        paymentStatus: json["payment_status"],
        orderAmount: json["order_amount"],
      );

  Map<String, dynamic> toJson() => {
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "order_note": orderNote,
        "table_id": tableId,
        "number_of_people": numberOfPeople,
        "branch_table_token": branchTableToken,
        "order_id": orderId,
        "payment_method": paymentMethod,
        "payment_status": paymentStatus,
        "order_amount": orderAmount,
      };
}

class Product {
  int? productId;
  double? price;
  List<dynamic>? variant;
  List<OrderVariation>? variations;
  int? discountAmount;
  int? quantity;
  int? taxAmount;
  List<int>? addOnIds;
  List<int>? addOnQtys;
  int? priceOrigin;
  String? name;

  Product(
      {this.productId,
      this.price,
      this.variant,
      this.variations,
      this.discountAmount,
      this.quantity,
      this.taxAmount,
      this.addOnIds,
      this.addOnQtys,
      this.priceOrigin = 0,
      this.name = ''});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["product_id"],
        price: json["price"],
        variant: json["variant"],
        variations: json["variations"] == null
            ? []
            : List<OrderVariation>.from(
                json["variations"]!.map((x) => OrderVariation.fromJson(x))),
        discountAmount: json["discount_amount"],
        quantity: json["quantity"],
        taxAmount: json["tax_amount"],
        addOnIds: json["add_on_ids"] == null
            ? []
            : List<int>.from(json["add_on_ids"]!.map((x) => x)),
        addOnQtys: json["add_on_qtys"] == null
            ? []
            : List<int>.from(json["add_on_qtys"]!.map((x) => x)),
      );
  factory Product.fromCartModel(CartModel cart) => Product(
        name: cart.product!.name!,
        price: (cart.price! * cart.quantity!),
        productId: cart.product!.id,
        priceOrigin: cart.product!.price!.round(),
        variant: cart.product!.addOns,
        variations: [],
        discountAmount: cart.discountAmount!.round(),
        quantity: cart.quantity,
        taxAmount: cart.taxAmount!.round(),
        addOnIds: [],
        addOnQtys: [],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "price": price,
        "variant": variant,
        "variations": variations == null
            ? []
            : List<dynamic>.from(variations!.map((x) => x)),
        "discount_amount": discountAmount,
        "quantity": quantity,
        "tax_amount": taxAmount,
        "add_on_ids":
            addOnIds == null ? [] : List<dynamic>.from(addOnIds!.map((x) => x)),
        "add_on_qtys": addOnQtys == null
            ? []
            : List<dynamic>.from(addOnQtys!.map((x) => x)),
      };
}

// To parse this JSON data, do
//
//     final placeUpdateOrderBody = placeUpdateOrderBodyFromJson(jsonString);

// import 'dart:convert';

// PlaceUpdateOrderBody placeUpdateOrderBodyFromJson(String str) =>
//     PlaceUpdateOrderBody.fromJson(json.decode(str));

// String placeUpdateOrderBodyToJson(PlaceUpdateOrderBody data) =>
//     json.encode(data.toJson());

// class PlaceUpdateOrderBody {
//   List<Product>? _products;
//   String? _orderNote;
//   int? _tableId;
//   int? _numberOfPeople;
//   String? _branchTableToken;
//   int? _orderId;
//   double? _orderAmount;
//   String? _paymentMethod;
//   String? _paymentStatus;

//   List<Product>? get products => _products;

//   String? get orderNote => _orderNote;

//   int? get tableId => _tableId;

//   int? get numberOfPeople => _numberOfPeople;

//   String? get branchTableToken => _branchTableToken;

//   int? get orderId => _orderId;

//   double? get orderAmount => _orderAmount;

//   String? get paymentMethod => _paymentMethod;

//   String? get paymentStatus => _paymentStatus;

//   PlaceUpdateOrderBody(
//     this._products,
//     this._orderAmount,
//     this._paymentMethod,
//     this._orderNote,
//     this._tableId,
//     this._numberOfPeople,
//     this._orderId,
//     this._paymentStatus,
//     this._branchTableToken,
//   );

//   PlaceUpdateOrderBody copyWith(
//       {String? paymentStatus,
//       String? paymentMethod,
//       String? token,
//       double? previousDue}) {
//     if (paymentStatus != null) {
//       _paymentStatus = paymentStatus;
//     }
//     if (paymentMethod != null) {
//       _paymentMethod = paymentMethod;
//     }
//     if (token != null) {
//       _branchTableToken = token;
//     }
//     if (previousDue != null) {
//       _orderAmount = _orderAmount! - previousDue;
//     }
//     return this;
//   }

//   PlaceUpdateOrderBody.fromJson(Map<String, dynamic> json) {
//     if (json['products'] != null) {
//       _products = [];
//       json['products'].forEach((v) {
//         _products?.add(Product.fromJson(v));
//       });
//     }
//     _orderNote = json['order_note'];
//     _tableId = json['table_id'];
//     _numberOfPeople = json['number_of_people'];
//     _branchTableToken = json['branch_table_token'];
//     _orderId = json['order_id'];
//     _orderAmount = json['order_amount'];
//     _paymentMethod = json['payment_method'];
//     _paymentStatus = json['payment_status'];
//   }

//   Map<String, dynamic> toJson() => {
//         "products": products == null
//             ? []
//             : List<dynamic>.from(products!.map((x) => x.toJson())),
//         "order_note": orderNote,
//         "table_id": tableId,
//         "number_of_people": numberOfPeople,
//         "branch_table_token": branchTableToken,
//         "order_id": orderId,
//         "payment_method": paymentMethod,
//         "payment_status": paymentStatus,
//         "order_amount": orderAmount,
//       };
// }

// class Product {
//   int? productId;
//   int? price;
//   String? variant;
//   List<dynamic>? variations;
//   int? discountAmount;
//   int? quantity;
//   int? taxAmount;
//   List<dynamic>? addOnIds;
//   List<dynamic>? addOnQtys;

//   Product({
//     this.productId,
//     this.price,
//     this.variant,
//     this.variations,
//     this.discountAmount,
//     this.quantity,
//     this.taxAmount,
//     this.addOnIds,
//     this.addOnQtys,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//         productId: json["product_id"],
//         price: json["price"],
//         variant: json["variant"],
//         variations: json["variations"] == null
//             ? []
//             : List<dynamic>.from(json["variations"]!.map((x) => x)),
//         discountAmount: json["discount_amount"],
//         quantity: json["quantity"],
//         taxAmount: json["tax_amount"],
//         addOnIds: json["add_on_ids"] == null
//             ? []
//             : List<dynamic>.from(json["add_on_ids"]!.map((x) => x)),
//         addOnQtys: json["add_on_qtys"] == null
//             ? []
//             : List<dynamic>.from(json["add_on_qtys"]!.map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "product_id": productId,
//         "price": price,
//         "variant": variant,
//         "variations": variations == null
//             ? []
//             : List<dynamic>.from(variations!.map((x) => x)),
//         "discount_amount": discountAmount,
//         "quantity": quantity,
//         "tax_amount": taxAmount,
//         "add_on_ids":
//             addOnIds == null ? [] : List<dynamic>.from(addOnIds!.map((x) => x)),
//         "add_on_qtys": addOnQtys == null
//             ? []
//             : List<dynamic>.from(addOnQtys!.map((x) => x)),
//       };
// }