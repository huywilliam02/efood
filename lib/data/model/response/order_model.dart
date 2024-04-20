class OrderModel {
  List<Orders>? _data;
  int? _lastPage;
  int? _total;

  OrderModel(
      {
        List<Orders>? data,
        int? from,
        int? total}) {

    if (data != null) {
      _data = data;
    }

    if (lastPage != null) {
      _lastPage = lastPage;
    }

    if (total != null) {
      _total = total;
    }
  }


  List<Orders>? get data => _data;
  int? get lastPage => _lastPage;
  int? get total => _total;


  OrderModel.fromJson(Map<String, dynamic> json) {

    if (json['data'] != null) {
      _data = <Orders>[];
      json['data'].forEach((v) {
        _data!.add(Orders.fromJson(v));
      });
    }
    _lastPage = int.tryParse('${json['last_page']}');
    _total = int.tryParse('${json['total']}');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_data != null) {
      data['data'] = _data!.map((v) => v.toJson()).toList();
    }
    data['last_page'] = _lastPage;
    data['total'] = _total;
    return data;
  }
}

class Orders {
  int? _id;
  int? _userId;
  double? _orderAmount;
  num? _couponDiscountAmount;
  String? _paymentStatus;
  String? _orderStatus;
  double? _totalTaxAmount;
  String? _paymentMethod;
  int? _deliveryAddressId;
  String? _createdAt;
  String? _updatedAt;
  int? _checked;
  int? _deliveryManId;
  double? _deliveryCharge;
  String _orderNote = '';
  String? _couponCode;
  String? _orderType;
  int? _branchId;
  String? _deliveryDate;
  String? _deliveryTime;
  String? _extraDiscount;
  DeliveryAddress? _deliveryAddress;
  int? _preparationTime;
  int? _tableNumber;
  int? _numberOfPeople;
  Table? _table;

  Orders(
      {int? id,
        int? userId,
        double? orderAmount,
        int? couponDiscountAmount,
        String? paymentStatus,
        String? orderStatus,
        double? totalTaxAmount,
        String? paymentMethod,
        int? deliveryAddressId,
        String? createdAt,
        String? updatedAt,
        int? checked,
        int? deliveryManId,
        double? deliveryCharge,
        String orderNote ='',
        String? couponCode,
        String? orderType,
        int? branchId,
        String? deliveryDate,
        String? deliveryTime,
        String? extraDiscount,
        DeliveryAddress? deliveryAddress,
        int? preparationTime,
        int? tableNumber,
        int? numberOfPeople,
        Table? table
      }) {
    if (id != null) {
      _id = id;
    }
    if (userId != null) {
      _userId = userId;
    }
    if (orderAmount != null) {
      _orderAmount = orderAmount;
    }
    if (couponDiscountAmount != null) {
      _couponDiscountAmount = couponDiscountAmount;
    }
    if (paymentStatus != null) {
      _paymentStatus = paymentStatus;
    }
    if (orderStatus != null) {
      _orderStatus = orderStatus;
    }
    if (totalTaxAmount != null) {
      _totalTaxAmount = totalTaxAmount;
    }
    if (paymentMethod != null) {
      _paymentMethod = paymentMethod;
    }

    if (deliveryAddressId != null) {
      _deliveryAddressId = deliveryAddressId;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
    if (checked != null) {
      _checked = checked;
    }
    if (deliveryManId != null) {
      _deliveryManId = deliveryManId;
    }
    if (deliveryCharge != null) {
      _deliveryCharge = deliveryCharge;
    }
    _orderNote = orderNote;
    if (couponCode != null) {
      _couponCode = couponCode;
    }
    if (orderType != null) {
      _orderType = orderType;
    }
    if (branchId != null) {
      _branchId = branchId;
    }

    if (deliveryDate != null) {
      _deliveryDate = deliveryDate;
    }
    if (deliveryTime != null) {
      _deliveryTime = deliveryTime;
    }
    if (extraDiscount != null) {
      _extraDiscount = extraDiscount;
    }
    if (deliveryAddress != null) {
      _deliveryAddress = deliveryAddress;
    }
    if (preparationTime != null) {
      _preparationTime = preparationTime;
    }
    if (tableNumber != null) {
      _tableNumber = tableNumber;
    }
    if (numberOfPeople != null) {
      _numberOfPeople = numberOfPeople;
    }
    if (table != null) {
      _table = table;
    }
  }

  int? get id => _id;
  int? get userId => _userId;
  double? get orderAmount => _orderAmount;

  String? get paymentStatus => _paymentStatus;
  String? get orderStatus => _orderStatus;
  double? get totalTaxAmount => _totalTaxAmount;
  String? get paymentMethod => _paymentMethod;
  int? get deliveryAddressId => _deliveryAddressId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get checked => _checked;
  int? get deliveryManId => _deliveryManId;
  double? get deliveryCharge => _deliveryCharge;
  String get orderNote => _orderNote;
  String? get couponCode => _couponCode;
  String? get orderType => _orderType;
  int? get branchId => _branchId;
  String? get deliveryDate => _deliveryDate;
  String? get deliveryTime => _deliveryTime;
  String? get extraDiscount => _extraDiscount;
  DeliveryAddress? get deliveryAddress => _deliveryAddress;
  int? get preparationTime => _preparationTime;
  int? get tableNumber => _tableNumber;
  int? get numberOfPeople => _numberOfPeople;
  Table? get table => _table;

  Orders.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    _orderAmount = json['order_amount'].toDouble();
    _couponDiscountAmount = json['coupon_discount_amount'];
    _paymentStatus = json['payment_status'];
    _orderStatus = json['order_status'];
    _totalTaxAmount = json['total_tax_amount'].toDouble();
    _paymentMethod = json['payment_method'];
    _deliveryAddressId = json['delivery_address_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _checked = int.tryParse('${json['checked']}');
    _deliveryManId = json['delivery_man_id'];
    _deliveryCharge = json['delivery_charge'].toDouble();
    if(json['order_note'] != null){
      _orderNote = json['order_note'];
    }else{
      _orderNote = '';
    }

    _couponCode = json['coupon_code'];
    _orderType = json['order_type'];
    _branchId = int.tryParse('${json['branch_id']}');
    _deliveryDate = json['delivery_date'];
    _deliveryTime = json['delivery_time'];
    _extraDiscount = json['extra_discount'];
    _deliveryAddress = json['delivery_address'] != null
        ? DeliveryAddress.fromJson(json['delivery_address'])
        : null;
    _preparationTime = int.tryParse('${json['preparation_time']}');
    _tableNumber = int.tryParse('${json['table_id']}');
    _numberOfPeople = int.tryParse('${json['number_of_people']}');
    _table = json['table'] != null ? Table.fromJson(json['table']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['user_id'] = _userId;
    data['order_amount'] = _orderAmount;
    data['coupon_discount_amount'] = _couponDiscountAmount;
    data['payment_status'] = _paymentStatus;
    data['order_status'] = _orderStatus;
    data['total_tax_amount'] = _totalTaxAmount;
    data['payment_method'] = _paymentMethod;
    data['delivery_address_id'] = _deliveryAddressId;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    data['checked'] = _checked;
    data['delivery_man_id'] = _deliveryManId;
    data['delivery_charge'] = _deliveryCharge;
    data['order_note'] = _orderNote;
    data['coupon_code'] = _couponCode;
    data['order_type'] = _orderType;
    data['branch_id'] = _branchId;
    data['delivery_date'] = _deliveryDate;
    data['delivery_time'] = _deliveryTime;
    data['extra_discount'] = _extraDiscount;
    if (_deliveryAddress != null) {
      data['delivery_address'] = _deliveryAddress!.toJson();
    }
    data['preparation_time'] = _preparationTime;
    data['table_id'] = _tableNumber;
    data['number_of_people'] = _numberOfPeople;
    if (_table != null) {
      data['table'] = _table!.toJson();
    }
    return data;
  }
}

class DeliveryAddress {
  int? _id;
  String? _addressType;
  String? _contactPersonNumber;
  String? _address;
  String? _latitude;
  String? _longitude;
  String? _createdAt;
  String? _updatedAt;
  int? _userId;
  String? _contactPersonName;

  DeliveryAddress(
      {int? id,
        String? addressType,
        String? contactPersonNumber,
        String? address,
        String? latitude,
        String? longitude,
        String? createdAt,
        String? updatedAt,
        int? userId,
        String? contactPersonName}) {
    if (id != null) {
      _id = id;
    }
    if (addressType != null) {
      _addressType = addressType;
    }
    if (contactPersonNumber != null) {
      _contactPersonNumber = contactPersonNumber;
    }
    if (address != null) {
      _address = address;
    }
    if (latitude != null) {
      _latitude = latitude;
    }
    if (longitude != null) {
      _longitude = longitude;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
    if (userId != null) {
      _userId = userId;
    }
    if (contactPersonName != null) {
      _contactPersonName = contactPersonName;
    }
  }

  int? get id => _id;
  String? get addressType => _addressType;
  String? get contactPersonNumber => _contactPersonNumber;
  String? get address => _address;
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get userId => _userId;
  String? get contactPersonName => _contactPersonName;


  DeliveryAddress.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _addressType = json['address_type'];
    _contactPersonNumber = json['contact_person_number'];
    _address = json['address'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _userId = json['user_id'];
    _contactPersonName = json['contact_person_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['address_type'] = _addressType;
    data['contact_person_number'] = _contactPersonNumber;
    data['address'] = _address;
    data['latitude'] = _latitude;
    data['longitude'] = _longitude;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    data['user_id'] = _userId;
    data['contact_person_name'] = _contactPersonName;
    return data;
  }
}


class Table {
  int? _number;
  Table(
      {int? number}) {

    if (number != null) {
      _number = number;
    }

  }

  int? get number => _number;
  Table.fromJson(Map<String, dynamic> json) {
    _number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = _number;
    return data;
  }
}