import 'dart:convert';

OderListDetails oderListDetailsFromJson(String str) =>
    OderListDetails.fromJson(json.decode(str));

String oderListDetailsToJson(OderListDetails data) =>
    json.encode(data.toJson());

class OderListDetails {
  Order? order;
  List<Detail>? details;

  OderListDetails({
    this.order,
    this.details,
  });

  factory OderListDetails.fromJson(Map<String, dynamic> json) =>
      OderListDetails(
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
        details: json["details"] == null
            ? []
            : List<Detail>.from(
                json["details"]!.map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order": order?.toJson(),
        "details": details == null
            ? []
            : List<dynamic>.from(details!.map((x) => x.toJson())),
      };
}

class Detail {
  int? id;
  int? productId;
  int? orderId;
  int? price;
  ProductDetails? productDetails;
  List<dynamic>? variation;
  int? discountOnProduct;
  String? discountType;
  int? quantity;
  int? taxAmount;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<dynamic>? addOnIds;
  List<dynamic>? variant;
  List<dynamic>? addOnQtys;
  List<dynamic>? addOnTaxes;
  List<dynamic>? addOnPrices;
  int? addOnTaxAmount;
  int? reviewCount;
  int? isProductAvailable;

  Detail({
    this.id,
    this.productId,
    this.orderId,
    this.price,
    this.productDetails,
    this.variation,
    this.discountOnProduct,
    this.discountType,
    this.quantity,
    this.taxAmount,
    this.createdAt,
    this.updatedAt,
    this.addOnIds,
    this.variant,
    this.addOnQtys,
    this.addOnTaxes,
    this.addOnPrices,
    this.addOnTaxAmount,
    this.reviewCount,
    this.isProductAvailable,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        productId: json["product_id"],
        orderId: json["order_id"],
        price: json["price"],
        productDetails: json["product_details"] == null
            ? null
            : ProductDetails.fromJson(json["product_details"]),
        variation: json["variation"] == null
            ? []
            : List<dynamic>.from(json["variation"]!.map((x) => x)),
        discountOnProduct: json["discount_on_product"],
        discountType: json["discount_type"],
        quantity: json["quantity"],
        taxAmount: json["tax_amount"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        addOnIds: json["add_on_ids"] == null
            ? []
            : List<dynamic>.from(json["add_on_ids"]!.map((x) => x)),
        variant: json["variant"] == null
            ? []
            : List<dynamic>.from(json["variant"]!.map((x) => x)),
        addOnQtys: json["add_on_qtys"] == null
            ? []
            : List<dynamic>.from(json["add_on_qtys"]!.map((x) => x)),
        addOnTaxes: json["add_on_taxes"] == null
            ? []
            : List<dynamic>.from(json["add_on_taxes"]!.map((x) => x)),
        addOnPrices: json["add_on_prices"] == null
            ? []
            : List<dynamic>.from(json["add_on_prices"]!.map((x) => x)),
        addOnTaxAmount: json["add_on_tax_amount"],
        reviewCount: json["review_count"],
        isProductAvailable: json["is_product_available"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "order_id": orderId,
        "price": price,
        "product_details": productDetails?.toJson(),
        "variation": variation == null
            ? []
            : List<dynamic>.from(variation!.map((x) => x)),
        "discount_on_product": discountOnProduct,
        "discount_type": discountType,
        "quantity": quantity,
        "tax_amount": taxAmount,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "add_on_ids":
            addOnIds == null ? [] : List<dynamic>.from(addOnIds!.map((x) => x)),
        "variant":
            variant == null ? [] : List<dynamic>.from(variant!.map((x) => x)),
        "add_on_qtys": addOnQtys == null
            ? []
            : List<dynamic>.from(addOnQtys!.map((x) => x)),
        "add_on_taxes": addOnTaxes == null
            ? []
            : List<dynamic>.from(addOnTaxes!.map((x) => x)),
        "add_on_prices": addOnPrices == null
            ? []
            : List<dynamic>.from(addOnPrices!.map((x) => x)),
        "add_on_tax_amount": addOnTaxAmount,
        "review_count": reviewCount,
        "is_product_available": isProductAvailable,
      };
}

class ProductDetails {
  int? id;
  String? name;
  String? description;
  String? image;
  int? price;
  List<dynamic>? variations;
  List<AddOn>? addOns;
  int? tax;
  String? availableTimeStarts;
  String? availableTimeEnds;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<dynamic>? attributes;
  List<CategoryId>? categoryIds;
  List<dynamic>? choiceOptions;
  int? discount;
  String? discountType;
  String? taxType;
  int? setMenu;
  int? branchId;
  dynamic colors;
  int? popularityCount;
  String? productType;
  List<dynamic>? translations;

  ProductDetails({
    this.id,
    this.name,
    this.description,
    this.image,
    this.price,
    this.variations,
    this.addOns,
    this.tax,
    this.availableTimeStarts,
    this.availableTimeEnds,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.attributes,
    this.categoryIds,
    this.choiceOptions,
    this.discount,
    this.discountType,
    this.taxType,
    this.setMenu,
    this.branchId,
    this.colors,
    this.popularityCount,
    this.productType,
    this.translations,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        price: json["price"],
        variations: json["variations"] == null
            ? []
            : List<dynamic>.from(json["variations"]!.map((x) => x)),
        addOns: json["add_ons"] == null
            ? []
            : List<AddOn>.from(json["add_ons"]!.map((x) => AddOn.fromJson(x))),
        tax: json["tax"],
        availableTimeStarts: json["available_time_starts"],
        availableTimeEnds: json["available_time_ends"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        attributes: json["attributes"] == null
            ? []
            : List<dynamic>.from(json["attributes"]!.map((x) => x)),
        categoryIds: json["category_ids"] == null
            ? []
            : List<CategoryId>.from(
                json["category_ids"]!.map((x) => CategoryId.fromJson(x))),
        choiceOptions: json["choice_options"] == null
            ? []
            : List<dynamic>.from(json["choice_options"]!.map((x) => x)),
        discount: json["discount"],
        discountType: json["discount_type"],
        taxType: json["tax_type"],
        setMenu: json["set_menu"],
        branchId: json["branch_id"],
        colors: json["colors"],
        popularityCount: json["popularity_count"],
        productType: json["product_type"],
        translations: json["translations"] == null
            ? []
            : List<dynamic>.from(json["translations"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "price": price,
        "variations": variations == null
            ? []
            : List<dynamic>.from(variations!.map((x) => x)),
        "add_ons": addOns == null
            ? []
            : List<dynamic>.from(addOns!.map((x) => x.toJson())),
        "tax": tax,
        "available_time_starts": availableTimeStarts,
        "available_time_ends": availableTimeEnds,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "attributes": attributes == null
            ? []
            : List<dynamic>.from(attributes!.map((x) => x)),
        "category_ids": categoryIds == null
            ? []
            : List<dynamic>.from(categoryIds!.map((x) => x.toJson())),
        "choice_options": choiceOptions == null
            ? []
            : List<dynamic>.from(choiceOptions!.map((x) => x)),
        "discount": discount,
        "discount_type": discountType,
        "tax_type": taxType,
        "set_menu": setMenu,
        "branch_id": branchId,
        "colors": colors,
        "popularity_count": popularityCount,
        "product_type": productType,
        "translations": translations == null
            ? []
            : List<dynamic>.from(translations!.map((x) => x)),
      };
}

class AddOn {
  int? id;
  String? name;
  int? price;
  int? tax;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<dynamic>? translations;

  AddOn({
    this.id,
    this.name,
    this.price,
    this.tax,
    this.createdAt,
    this.updatedAt,
    this.translations,
  });

  factory AddOn.fromJson(Map<String, dynamic> json) => AddOn(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        tax: json["tax"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        translations: json["translations"] == null
            ? []
            : List<dynamic>.from(json["translations"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "tax": tax,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "translations": translations == null
            ? []
            : List<dynamic>.from(translations!.map((x) => x)),
      };
}

class CategoryId {
  String? id;
  int? position;

  CategoryId({
    this.id,
    this.position,
  });

  factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
        id: json["id"],
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "position": position,
      };
}

class Order {
  int? id;
  dynamic userId;
  int? orderAmount;
  int? couponDiscountAmount;
  dynamic couponDiscountTitle;
  String? paymentStatus;
  String? orderStatus;
  int? totalTaxAmount;
  String? paymentMethod;
  dynamic transactionReference;
  dynamic deliveryAddressId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? checked;
  dynamic deliveryManId;
  int? deliveryCharge;
  dynamic orderNote;
  dynamic couponCode;
  String? orderType;
  int? branchId;
  dynamic callback;
  DateTime? deliveryDate;
  String? deliveryTime;
  String? extraDiscount;
  dynamic deliveryAddress;
  int? preparationTime;
  int? tableId;
  int? numberOfPeople;
  int? tableOrderId;

  Order({
    this.id,
    this.userId,
    this.orderAmount,
    this.couponDiscountAmount,
    this.couponDiscountTitle,
    this.paymentStatus,
    this.orderStatus,
    this.totalTaxAmount,
    this.paymentMethod,
    this.transactionReference,
    this.deliveryAddressId,
    this.createdAt,
    this.updatedAt,
    this.checked,
    this.deliveryManId,
    this.deliveryCharge,
    this.orderNote,
    this.couponCode,
    this.orderType,
    this.branchId,
    this.callback,
    this.deliveryDate,
    this.deliveryTime,
    this.extraDiscount,
    this.deliveryAddress,
    this.preparationTime,
    this.tableId,
    this.numberOfPeople,
    this.tableOrderId,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        userId: json["user_id"],
        orderAmount: json["order_amount"],
        couponDiscountAmount: json["coupon_discount_amount"],
        couponDiscountTitle: json["coupon_discount_title"],
        paymentStatus: json["payment_status"],
        orderStatus: json["order_status"],
        totalTaxAmount: json["total_tax_amount"],
        paymentMethod: json["payment_method"],
        transactionReference: json["transaction_reference"],
        deliveryAddressId: json["delivery_address_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        checked: json["checked"],
        deliveryManId: json["delivery_man_id"],
        deliveryCharge: json["delivery_charge"],
        orderNote: json["order_note"],
        couponCode: json["coupon_code"],
        orderType: json["order_type"],
        branchId: json["branch_id"],
        callback: json["callback"],
        deliveryDate: json["delivery_date"] == null
            ? null
            : DateTime.parse(json["delivery_date"]),
        deliveryTime: json["delivery_time"],
        extraDiscount: json["extra_discount"],
        deliveryAddress: json["delivery_address"],
        preparationTime: json["preparation_time"],
        tableId: json["table_id"],
        numberOfPeople: json["number_of_people"],
        tableOrderId: json["table_order_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "order_amount": orderAmount,
        "coupon_discount_amount": couponDiscountAmount,
        "coupon_discount_title": couponDiscountTitle,
        "payment_status": paymentStatus,
        "order_status": orderStatus,
        "total_tax_amount": totalTaxAmount,
        "payment_method": paymentMethod,
        "transaction_reference": transactionReference,
        "delivery_address_id": deliveryAddressId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "checked": checked,
        "delivery_man_id": deliveryManId,
        "delivery_charge": deliveryCharge,
        "order_note": orderNote,
        "coupon_code": couponCode,
        "order_type": orderType,
        "branch_id": branchId,
        "callback": callback,
        "delivery_date": deliveryDate?.toIso8601String(),
        "delivery_time": deliveryTime,
        "extra_discount": extraDiscount,
        "delivery_address": deliveryAddress,
        "preparation_time": preparationTime,
        "table_id": tableId,
        "number_of_people": numberOfPeople,
        "table_order_id": tableOrderId,
      };
}
