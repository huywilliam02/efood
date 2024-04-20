class OrderDetailsModel {
  Order order = Order(id: 0, tableId: 0, numberOfPeople: 0, tableOrderId: 0, orderNote: '', orderStatus: '');
  List<Details> details = [];

  OrderDetailsModel({required this.order, required this.details});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    order = (json['order'] != null ? Order.fromJson(json['order']) : null)!;
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details.add(Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order'] = order.toJson();
    data['details'] = details.map((v) => v.toJson()).toList();

    return data;
  }
}

class Order {
  int id = 0;
  int tableId = 0;
  int numberOfPeople = 0;
  int tableOrderId = 0;
  String orderNote = '';
  String orderStatus = '';
  Table? table;
  num? couponDiscountAmount;
  num? tax;
  num? deliveryCharge;
  num? extraDiscount;

  Order(
      {required this.id,
        required this.tableId,
        required this.numberOfPeople,
        required this.tableOrderId,
        required this.orderNote,
        required this.orderStatus,
        this.couponDiscountAmount,
        this.tax,
        this.extraDiscount,
        this.deliveryCharge,
      });

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if(json['table_id'] != null){
      tableId = json['table_id'];
    }
    if(json['number_of_people'] != null){
      numberOfPeople = json['number_of_people'];
    }
    if(json['table_order_id'] != null){
      tableOrderId = json['table_order_id'];
    }

    if(json['order_note'] != null){
      orderNote = json['order_note'];
    }

    orderStatus = json['order_status'];
    table = json['table'] != null ? Table.fromJson(json['table']) : null;
    tax = json['total_tax_amount'];
    couponDiscountAmount = json['coupon_discount_amount'];
    extraDiscount = double.tryParse(json['extra_discount']);
    deliveryCharge = json['delivery_charge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['table_id'] = tableId;
    data['number_of_people'] = numberOfPeople;
    data['table_order_id'] = tableOrderId;
    data['order_note'] = orderNote;
    data['order_status'] = orderStatus;
    if (table != null) {
      data['table'] = table!.toJson();
    }
    return data;
  }
}

class Details {
  int? id;
  int? productId;
  int? orderId;
  double? price;
  ProductDetails? productDetails;
  List<Variation>? variations;
  List<OldVariation>? oldVariations;
  double? discountOnProduct;
  String? discountType;
  int? quantity;
  double? taxAmount;
  String? createdAt;
  String? updatedAt;
  List<int>? addOnIds;
  List<int>? addOnQtys;
  List<double>? addOnPrices;
  double? addonTaxAmount;

  Details(
      {this.id,
        this.productId,
        this.orderId,
        this.price,
        this.productDetails,
        this.variations,
        this.oldVariations,
        this.discountOnProduct,
        this.discountType,
        this.quantity,
        this.taxAmount,
        this.createdAt,
        this.updatedAt,
        this.addOnIds,
        this.addOnQtys,
        this.addOnPrices,
        this.addonTaxAmount,
      });

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    orderId = json['order_id'];
    price = json['price'].toDouble();
    productDetails = json['product_details'] != null
        ? ProductDetails.fromJson(json['product_details'])
        : null;
    if(json['variation'] != null && json['variation'].isNotEmpty) {
      if(json['variation'][0]['values'] != null) {
        variations = [];
        json['variation'].forEach((v) {
          variations?.add(Variation.fromJson(v));
        });
      }else{
        oldVariations = [];
        json['variation'].forEach((v) {
          oldVariations?.add(OldVariation.fromJson(v));
        });
      }
    }

    discountOnProduct = json['discount_on_product'].toDouble();
    discountType = json['discount_type'];
    quantity = json['quantity'];
    taxAmount = json['tax_amount'].toDouble();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if(json['add_on_ids'] != null) {
      addOnIds = [];
      json['add_on_ids'].forEach((id) {
        try {
          addOnIds!.add( int.parse(id));
        }catch(e) {
          addOnIds!.add(id);
        }

      });
    }    if(json['add_on_qtys'] != null) {
      addOnQtys = [];
      json['add_on_qtys'].forEach((qun) {
        try {
          addOnQtys!.add( int.parse(qun));
        }catch(e) {
          addOnQtys!.add(qun);
        }

      });
    }
    if(json['add_on_prices'] != null) {
      addOnPrices = [];
      json['add_on_prices'].forEach((qun) {
        try {
          addOnPrices?.add( double.parse('$qun'));
        }catch(e) {
          addOnPrices?.add(qun);
        }

      });
    }
    addonTaxAmount = double.tryParse('${json['add_on_tax_amount']}');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['order_id'] = orderId;
    data['price'] = price;
    if (productDetails != null) {
      data['product_details'] = productDetails!.toJson();
    }
    if (variations != null) {
      data['variation'] = variations;
    }
    data['discount_on_product'] = discountOnProduct;
    data['discount_type'] = discountType;
    data['quantity'] = quantity;
    data['tax_amount'] = taxAmount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['add_on_ids'] = addOnIds;
    data['add_on_qtys'] = addOnQtys;
    data['add_on_qtys'] = addOnQtys;
    data['add_on_tax_amount'] = addonTaxAmount;
    return data;
  }
}

class ProductDetails {
  int? id;
  String? name;
  String? description;
  String? image;
  double? price;
  List<Variations>? variations;
  List<AddOns>? addOns;
  double? tax;
  String? availableTimeStarts;
  String? availableTimeEnds;
  int? status;
  String? createdAt;
  String? updatedAt;
  List<String>? attributes;
  List<CategoryIds>? categoryIds;
  List<ChoiceOptions>? choiceOptions;
  double? discount;
  String? discountType;
  String? taxType;
  int? setMenu;
  int? branchId;
  int? popularityCount;
  String? productType;


  ProductDetails(
      {this.id,
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
        this.popularityCount,
        this.productType,
       });

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    price = json['price'].toDouble();
    if (json['variations'] != null) {
      variations = <Variations>[];
      json['variations'].forEach((v) {
        variations!.add(Variations.fromJson(v));
      });
    }
    if (json['add_ons'] != null) {
      addOns = <AddOns>[];
      try{
        json['add_ons'].forEach((v) {
          addOns!.add(AddOns.fromJson(v));
        });
      }catch(e){
        addOns = <AddOns>[];
      }
    }
    tax = json['tax'].toDouble();
    availableTimeStarts = json['available_time_starts'];
    availableTimeEnds = json['available_time_ends'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    attributes = json['attributes'].cast<String>();
    if (json['category_ids'] != null) {
      categoryIds = <CategoryIds>[];
      json['category_ids'].forEach((v) {
        categoryIds!.add(CategoryIds.fromJson(v));
      });
    }
    if (json['choice_options'] != null) {
      choiceOptions = <ChoiceOptions>[];
      json['choice_options'].forEach((v) {
        choiceOptions!.add(ChoiceOptions.fromJson(v));
      });
    }
    discount = json['discount'].toDouble();
    discountType = json['discount_type'];
    taxType = json['tax_type'];
    setMenu = json['set_menu'];
    branchId = int.tryParse('${json['branch_id']}');
    popularityCount = int.tryParse('${json['popularity_count']}');
    productType = json['product_type'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    data['price'] = price;
    if (variations != null) {
      data['variations'] = variations!.map((v) => v.toJson()).toList();
    }
    if (addOns != null) {
      data['add_ons'] = addOns!.map((v) => v.toJson()).toList();
    }
    data['tax'] = tax;
    data['available_time_starts'] = availableTimeStarts;
    data['available_time_ends'] = availableTimeEnds;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['attributes'] = attributes;
    if (categoryIds != null) {
      data['category_ids'] = categoryIds!.map((v) => v.toJson()).toList();
    }
    if (choiceOptions != null) {
      data['choice_options'] =
          choiceOptions!.map((v) => v.toJson()).toList();
    }
    data['discount'] = discount;
    data['discount_type'] = discountType;
    data['tax_type'] = taxType;
    data['set_menu'] = setMenu;
    data['branch_id'] = branchId;
    data['popularity_count'] = popularityCount;
    data['product_type'] = productType;

    return data;
  }
}

class Variations {
  String? type;
  double? price;

  Variations({this.type, this.price});

  Variations.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if(json['price'] != null && json['price'] != 'null') {
      price = double.parse('${json['price']}');
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['price'] = price;
    return data;
  }
}

class AddOns {
  int? id;
  String? name;
  double? price;
  String? createdAt;
  String? updatedAt;
  List<void>? translations;

  AddOns(
      {this.id,
        this.name,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.translations});

  AddOns.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if(json['price'] != null && json['price'] != 'null') {
      price = double.parse('${json['price']}');
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;

    return data;
  }
}

class CategoryIds {
  String? id;
  int? position;

  CategoryIds({this.id, this.position});

  CategoryIds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['position'] = position;
    return data;
  }
}

class ChoiceOptions {
  String? name;
  String? title;
  List<String>? options;

  ChoiceOptions({this.name, this.title, this.options});

  ChoiceOptions.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    title = json['title'];
    options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['title'] = title;
    data['options'] = options;
    return data;
  }
}
class Table {
  int? id;
  int? number;

  Table(
      {this.id,
        this.number,
       });

  Table.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['number'] = number;
    return data;
  }
}

class Variation {
  String? name;
  int? min;
  int? max;
  bool? isRequired;
  bool? isMultiSelect;
  List<VariationValue>? variationValues;


  Variation({
    this.name, this.min, this.max,
    this.isRequired, this.variationValues,
    this.isMultiSelect,
  });

  Variation.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isMultiSelect = '${json['type']}' == 'multi';
    min =  isMultiSelect! ? int.parse(json['min'].toString()) : 0;
    max = isMultiSelect! ? int.parse(json['max'].toString()) : 0;
    isRequired = '${json['required']}' == 'on';
    if (json['values'] != null) {
      variationValues = [];
      json['values'].forEach((v) {
        variationValues?.add(VariationValue.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['type'] = isMultiSelect;
    data['min'] = min;
    data['max'] = max;
    data['required'] = isRequired;
    if (variationValues != null) {
      data['values'] = variationValues?.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class VariationValue {
  String? level;
  double? optionPrice;

  VariationValue({this.level, this.optionPrice});

  VariationValue.fromJson(Map<String, dynamic> json) {
    level = json['label'];
    optionPrice = double.parse(json['optionPrice'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = level;
    data['optionPrice'] = optionPrice;
    return data;
  }
}


class OldVariation {
  String? type;
  double? price;

  OldVariation({this.type, this.price});

  OldVariation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    price = json['price'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['price'] = price;
    return data;
  }
}
