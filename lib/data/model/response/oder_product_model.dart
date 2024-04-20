// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'dart:convert';

ProductsModel productsModelFromJson(String str) =>
    ProductsModel.fromJson(json.decode(str));

String productsModelToJson(ProductsModel data) => json.encode(data.toJson());

class ProductsModel {
  List<Product>? products;
  String? orderNote;
  int? tableId;
  int? numberOfPeople;
  String? branchTableToken;

  ProductsModel({
    this.products,
    this.orderNote,
    this.tableId,
    this.numberOfPeople,
    this.branchTableToken,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
        orderNote: json["order_note"],
        tableId: json["table_id"],
        numberOfPeople: json["number_of_people"],
        branchTableToken: json["branch_table_token"],
      );

  Map<String, dynamic> toJson() => {
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "order_note": orderNote,
        "table_id": tableId,
        "number_of_people": numberOfPeople,
        "branch_table_token": branchTableToken,
      };
}

class Product {
  int? productId;
  int? price;
  String? variant;
  List<dynamic>? variations;
  int? discountAmount;
  int? quantity;
  int? taxAmount;
  List<dynamic>? addOnIds;
  List<dynamic>? addOnQtys;

  Product({
    this.productId,
    this.price,
    this.variant,
    this.variations,
    this.discountAmount,
    this.quantity,
    this.taxAmount,
    this.addOnIds,
    this.addOnQtys,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["product_id"],
        price: json["price"],
        variant: json["variant"],
        variations: json["variations"] == null
            ? []
            : List<dynamic>.from(json["variations"]!.map((x) => x)),
        discountAmount: json["discount_amount"],
        quantity: json["quantity"],
        taxAmount: json["tax_amount"],
        addOnIds: json["add_on_ids"] == null
            ? []
            : List<dynamic>.from(json["add_on_ids"]!.map((x) => x)),
        addOnQtys: json["add_on_qtys"] == null
            ? []
            : List<dynamic>.from(json["add_on_qtys"]!.map((x) => x)),
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
