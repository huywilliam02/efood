class ConfigModel {
  String? _restaurantName;
  String? _restaurantLogo;
  String? _restaurantAddress;
  String? _restaurantPhone;
  String? _restaurantEmail;
  RestaurantLocationCoverage? _restaurantLocationCoverage;
  int? _minimumOrderValue;
  BaseUrls? _baseUrls;
  String? _currencySymbol;
  int? _deliveryCharge;
  DeliveryManagement? _deliveryManagement;
  String? _cashOnDelivery;
  String? _digitalPayment;
  List<Branches>? _branches;
  String? _termsAndConditions;
  String? _privacyPolicy;
  String? _aboutUs;
  bool? _emailVerification;
  bool? _phoneVerification;
  String? _currencySymbolPosition;
  bool? _maintenanceMode;
  String? _country;
  bool? _selfPickup;
  bool? _delivery;
  PlayStoreConfig? _playStoreConfig;
  PlayStoreConfig? _appStoreConfig;
  List<SocialMediaLink>? _socialMediaLink;
  String? _softwareVersion;
  String? _footerText;
  int? _decimalPointSettings;
  int? _scheduleOrderSlotDuration;
  String? _timeFormat;
  bool? _isVegNonVegActive;


  ConfigModel(
      {String? restaurantName,
        String? restaurantLogo,
        String? restaurantAddress,
        String? restaurantPhone,
        String? restaurantEmail,
        RestaurantLocationCoverage? restaurantLocationCoverage,
        int? minimumOrderValue,
        BaseUrls? baseUrls,
        String? currencySymbol,
        int? deliveryCharge,
        DeliveryManagement? deliveryManagement,
        String? cashOnDelivery,
        String? digitalPayment,
        List<Branches>? branches,
        String? termsAndConditions,
        String? privacyPolicy,
        String? aboutUs,
        bool? emailVerification,
        bool? phoneVerification,
        String? currencySymbolPosition,
        bool? maintenanceMode,
        String? country,
        bool? selfPickup,
        bool? delivery,
        PlayStoreConfig? playStoreConfig,
        PlayStoreConfig? appStoreConfig,
        List<SocialMediaLink>? socialMediaLink,
        String? softwareVersion,
        String? footerText,
        int? decimalPointSettings,
        int? scheduleOrderSlotDuration,
        String? timeFormat,
        bool? isVegNonVegActive,

      }) {
    if (restaurantName != null) {
      _restaurantName = restaurantName;
    }

    if (restaurantLogo != null) {
      _restaurantLogo = restaurantLogo;
    }
    if (restaurantAddress != null) {
      _restaurantAddress = restaurantAddress;
    }
    if (restaurantPhone != null) {
      _restaurantPhone = restaurantPhone;
    }
    if (restaurantEmail != null) {
      _restaurantEmail = restaurantEmail;
    }
    if (restaurantLocationCoverage != null) {
      _restaurantLocationCoverage = restaurantLocationCoverage;
    }
    if (minimumOrderValue != null) {
      _minimumOrderValue = minimumOrderValue;
    }
    if (baseUrls != null) {
      _baseUrls = baseUrls;
    }
    if (currencySymbol != null) {
      _currencySymbol = currencySymbol;
    }
    if (deliveryCharge != null) {
      _deliveryCharge = deliveryCharge;
    }
    if (deliveryManagement != null) {
      _deliveryManagement = deliveryManagement;
    }
    if (cashOnDelivery != null) {
      _cashOnDelivery = cashOnDelivery;
    }
    if (digitalPayment != null) {
      _digitalPayment = digitalPayment;
    }
    if (branches != null) {
      _branches = branches;
    }
    if (termsAndConditions != null) {
      _termsAndConditions = termsAndConditions;
    }
    if (privacyPolicy != null) {
      _privacyPolicy = privacyPolicy;
    }
    if (aboutUs != null) {
      _aboutUs = aboutUs;
    }
    if (emailVerification != null) {
      _emailVerification = emailVerification;
    }
    if (phoneVerification != null) {
      _phoneVerification = phoneVerification;
    }
    if (currencySymbolPosition != null) {
      _currencySymbolPosition = currencySymbolPosition;
    }
    if (maintenanceMode != null) {
      _maintenanceMode = maintenanceMode;
    }
    if (country != null) {
      _country = country;
    }
    if (selfPickup != null) {
      _selfPickup = selfPickup;
    }
    if (delivery != null) {
      _delivery = delivery;
    }
    if (playStoreConfig != null) {
      _playStoreConfig = playStoreConfig;
    }
    if (appStoreConfig != null) {
      _appStoreConfig = appStoreConfig;
    }
    if (socialMediaLink != null) {
      _socialMediaLink = socialMediaLink;
    }
    if (softwareVersion != null) {
      _softwareVersion = softwareVersion;
    }
    if (footerText != null) {
      _footerText = footerText;
    }
    if (decimalPointSettings != null) {
      _decimalPointSettings = decimalPointSettings;
    }
    if (scheduleOrderSlotDuration != null) {
      _scheduleOrderSlotDuration = scheduleOrderSlotDuration;
    }
    if (timeFormat != null) {
      _timeFormat = timeFormat;
    }
    if (isVegNonVegActive != null) {
      _isVegNonVegActive = isVegNonVegActive;
    }
  }

  String? get restaurantName => _restaurantName;
  String? get restaurantLogo => _restaurantLogo;
  String? get restaurantAddress => _restaurantAddress;
  String? get restaurantPhone => _restaurantPhone;
  String? get restaurantEmail => _restaurantEmail;
  RestaurantLocationCoverage? get restaurantLocationCoverage => _restaurantLocationCoverage;
  int? get minimumOrderValue => _minimumOrderValue;
  BaseUrls? get baseUrls => _baseUrls;
  String? get currencySymbol => _currencySymbol;
  int? get deliveryCharge => _deliveryCharge;
  DeliveryManagement? get deliveryManagement => _deliveryManagement;
  String? get cashOnDelivery => _cashOnDelivery;
  String? get digitalPayment => _digitalPayment;
  List<Branches>? get branches => _branches;
  String? get termsAndConditions => _termsAndConditions;
  String? get privacyPolicy => _privacyPolicy;
  String? get aboutUs => _aboutUs;
  bool? get emailVerification => _emailVerification;
  bool? get phoneVerification => _phoneVerification;
  String? get currencySymbolPosition => _currencySymbolPosition;
  bool? get maintenanceMode => _maintenanceMode;
  String? get country => _country;
  bool? get selfPickup => _selfPickup;
  bool? get delivery => _delivery;
  PlayStoreConfig? get playStoreConfig => _playStoreConfig;
  PlayStoreConfig? get appStoreConfig => _appStoreConfig;
  List<SocialMediaLink>? get socialMediaLink => _socialMediaLink;
  String? get softwareVersion => _softwareVersion;
  String? get footerText => _footerText;
  int? get decimalPointSettings => _decimalPointSettings;
  int? get scheduleOrderSlotDuration => _scheduleOrderSlotDuration;
  String? get timeFormat => _timeFormat;
  bool? get isVegNonVegActive => _isVegNonVegActive;



  ConfigModel.fromJson(Map<String, dynamic> json) {
    _restaurantName = json['restaurant_name'];

    _restaurantLogo = json['restaurant_logo'];
    _restaurantAddress = json['restaurant_address'];
    _restaurantPhone = json['restaurant_phone'];
    _restaurantEmail = json['restaurant_email'];
    _restaurantLocationCoverage = json['restaurant_location_coverage'] != null
        ? RestaurantLocationCoverage.fromJson(
        json['restaurant_location_coverage'])
        : null;
    _minimumOrderValue = json['minimum_order_value'];
    _baseUrls = json['base_urls'] != null
        ? BaseUrls.fromJson(json['base_urls'])
        : null;
    _currencySymbol = json['currency_symbol'];
    _deliveryCharge = json['delivery_charge'];
    _cashOnDelivery = json['cash_on_delivery'];
    _digitalPayment = json['digital_payment'];
    if (json['branches'] != null) {
      _branches = <Branches>[];
      json['branches'].forEach((v) {
        _branches!.add(Branches.fromJson(v));
      });
    }
    _termsAndConditions = json['terms_and_conditions'];
    _privacyPolicy = json['privacy_policy'];
    _aboutUs = json['about_us'];
    _emailVerification = json['email_verification'];
    _phoneVerification = json['phone_verification'];
    _currencySymbolPosition = json['currency_symbol_position'];
    _maintenanceMode = json['maintenance_mode'];
    _country = json['country'];
    _selfPickup = json['self_pickup'];
    _delivery = json['delivery'];
    _playStoreConfig = json['play_store_config'] != null
        ? PlayStoreConfig.fromJson(json['play_store_config'])
        : null;
    _appStoreConfig = json['app_store_config'] != null
        ? PlayStoreConfig.fromJson(json['app_store_config'])
        : null;
    if (json['social_media_link'] != null) {
      _socialMediaLink = <SocialMediaLink>[];
      json['social_media_link'].forEach((v) {
        _socialMediaLink!.add(SocialMediaLink.fromJson(v));
      });
    }
    _softwareVersion = json['software_version'];
    _footerText = json['footer_text'];
    _decimalPointSettings = json['decimal_point_settings'];
    _scheduleOrderSlotDuration = json['schedule_order_slot_duration'];
    _timeFormat = json['time_format'];
    _isVegNonVegActive = '${json['is_veg_non_veg_active']}'.contains('1');

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['restaurant_name'] = _restaurantName;
    data['restaurant_logo'] = _restaurantLogo;
    data['restaurant_address'] = _restaurantAddress;
    data['restaurant_phone'] = _restaurantPhone;
    data['restaurant_email'] = _restaurantEmail;
    if (_restaurantLocationCoverage != null) {
      data['restaurant_location_coverage'] =
          _restaurantLocationCoverage!.toJson();
    }
    data['minimum_order_value'] = _minimumOrderValue;
    if (_baseUrls != null) {
      data['base_urls'] = _baseUrls!.toJson();
    }
    data['currency_symbol'] = _currencySymbol;
    data['delivery_charge'] = _deliveryCharge;
    if (_deliveryManagement != null) {
      data['delivery_management'] = _deliveryManagement!.toJson();
    }
    data['cash_on_delivery'] = _cashOnDelivery;
    data['digital_payment'] = _digitalPayment;
    if (_branches != null) {
      data['branches'] = _branches!.map((v) => v.toJson()).toList();
    }
    data['terms_and_conditions'] = _termsAndConditions;
    data['privacy_policy'] = _privacyPolicy;
    data['about_us'] = _aboutUs;
    data['email_verification'] = _emailVerification;
    data['phone_verification'] = _phoneVerification;
    data['currency_symbol_position'] = _currencySymbolPosition;
    data['maintenance_mode'] = _maintenanceMode;
    data['country'] = _country;
    data['self_pickup'] = _selfPickup;
    data['delivery'] = _delivery;
    if (_playStoreConfig != null) {
      data['play_store_config'] = _playStoreConfig!.toJson();
    }
    if (_appStoreConfig != null) {
      data['app_store_config'] = _appStoreConfig!.toJson();
    }
    if (_socialMediaLink != null) {
      data['social_media_link'] =
          _socialMediaLink!.map((v) => v.toJson()).toList();
    }
    data['software_version'] = _softwareVersion;
    data['footer_text'] = _footerText;
    data['decimal_point_settings'] = _decimalPointSettings;
    data['schedule_order_slot_duration'] = _scheduleOrderSlotDuration;
    data['time_format'] = _timeFormat;
    return data;
  }
}



class RestaurantLocationCoverage {
  String? _longitude;
  String? _latitude;
  int? _coverage;

  RestaurantLocationCoverage(
      {String? longitude, String? latitude, int? coverage}) {
    if (longitude != null) {
      _longitude = longitude;
    }
    if (latitude != null) {
      _latitude = latitude;
    }
    if (coverage != null) {
      _coverage = coverage;
    }
  }

  String? get longitude => _longitude;
  String? get latitude => _latitude;
  int? get coverage => _coverage;


  RestaurantLocationCoverage.fromJson(Map<String, dynamic> json) {
    _longitude = json['longitude'];
    _latitude = json['latitude'];
    _coverage = json['coverage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['longitude'] = _longitude;
    data['latitude'] = _latitude;
    data['coverage'] = _coverage;
    return data;
  }
}

class BaseUrls {
  String? _productImageUrl;
  String? _customerImageUrl;
  String? _bannerImageUrl;
  String? _categoryImageUrl;
  String? _categoryBannerImageUrl;
  String? _reviewImageUrl;
  String? _notificationImageUrl;
  String? _restaurantImageUrl;
  String? _deliveryManImageUrl;
  String? _chatImageUrl;
  String? _kitchenProfileUrl;

  BaseUrls(
      {String? productImageUrl,
        String? customerImageUrl,
        String? bannerImageUrl,
        String? categoryImageUrl,
        String? categoryBannerImageUrl,
        String? reviewImageUrl,
        String? notificationImageUrl,
        String? restaurantImageUrl,
        String? deliveryManImageUrl,
        String? chatImageUrl,
        String? kitchenProfileUrl,
      }) {
    if (productImageUrl != null) {
      _productImageUrl = productImageUrl;
    }
    if (customerImageUrl != null) {
      _customerImageUrl = customerImageUrl;
    }
    if (bannerImageUrl != null) {
      _bannerImageUrl = bannerImageUrl;
    }
    if (categoryImageUrl != null) {
      _categoryImageUrl = categoryImageUrl;
    }
    if (categoryBannerImageUrl != null) {
      _categoryBannerImageUrl = categoryBannerImageUrl;
    }
    if (reviewImageUrl != null) {
      _reviewImageUrl = reviewImageUrl;
    }
    if (notificationImageUrl != null) {
      _notificationImageUrl = notificationImageUrl;
    }
    if (restaurantImageUrl != null) {
      _restaurantImageUrl = restaurantImageUrl;
    }
    if (deliveryManImageUrl != null) {
      _deliveryManImageUrl = deliveryManImageUrl;
    }
    if (chatImageUrl != null) {
      _chatImageUrl = chatImageUrl;
    }
    if (kitchenProfileUrl != null) {
      _kitchenProfileUrl = kitchenProfileUrl;
    }
  }

  String? get productImageUrl => _productImageUrl;
  String? get customerImageUrl => _customerImageUrl;
  String? get bannerImageUrl => _bannerImageUrl;
  String? get categoryImageUrl => _categoryImageUrl;
  String? get categoryBannerImageUrl => _categoryBannerImageUrl;
  String? get reviewImageUrl => _reviewImageUrl;
  String? get notificationImageUrl => _notificationImageUrl;
  String? get restaurantImageUrl => _restaurantImageUrl;
  String? get deliveryManImageUrl => _deliveryManImageUrl;
  String? get chatImageUrl => _chatImageUrl;
  String? get kitchenProfileUrl => _kitchenProfileUrl;

  BaseUrls.fromJson(Map<String, dynamic> json) {
    _productImageUrl = json['product_image_url'];
    _customerImageUrl = json['customer_image_url'];
    _bannerImageUrl = json['banner_image_url'];
    _categoryImageUrl = json['category_image_url'];
    _categoryBannerImageUrl = json['category_banner_image_url'];
    _reviewImageUrl = json['review_image_url'];
    _notificationImageUrl = json['notification_image_url'];
    _restaurantImageUrl = json['restaurant_image_url'];
    _deliveryManImageUrl = json['delivery_man_image_url'];
    _chatImageUrl = json['chat_image_url'];
    _kitchenProfileUrl = json['kitchen_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_image_url'] = _productImageUrl;
    data['customer_image_url'] = _customerImageUrl;
    data['banner_image_url'] = _bannerImageUrl;
    data['category_image_url'] = _categoryImageUrl;
    data['category_banner_image_url'] = _categoryBannerImageUrl;
    data['review_image_url'] = _reviewImageUrl;
    data['notification_image_url'] = _notificationImageUrl;
    data['restaurant_image_url'] = _restaurantImageUrl;
    data['delivery_man_image_url'] = _deliveryManImageUrl;
    data['chat_image_url'] = _chatImageUrl;
    data['kitchen_image_url'] = _kitchenProfileUrl;
    return data;
  }
}

class DeliveryManagement {
  int? _status;
  int? _minShippingCharge;
  int? _shippingPerKm;

  DeliveryManagement(
      {int? status, int? minShippingCharge, int? shippingPerKm}) {
    if (status != null) {
      _status = status;
    }
    if (minShippingCharge != null) {
      _minShippingCharge = minShippingCharge;
    }
    if (shippingPerKm != null) {
      _shippingPerKm = shippingPerKm;
    }
  }

  int? get status => _status;
  int? get minShippingCharge => _minShippingCharge;
  int? get shippingPerKm => _shippingPerKm;


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = _status;
    data['min_shipping_charge'] = _minShippingCharge;
    data['shipping_per_km'] = _shippingPerKm;
    return data;
  }
}

class Branches {
  int? _id;
  String? _name;
  String? _email;
  String? _longitude;
  String? _latitude;
  String? _address;
  int? _coverage;

  Branches(
      {int? id,
        String? name,
        String? email,
        String? longitude,
        String? latitude,
        String? address,
        int? coverage}) {
    if (id != null) {
      _id = id;
    }
    if (name != null) {
      _name = name;
    }
    if (email != null) {
      _email = email;
    }
    if (longitude != null) {
      _longitude = longitude;
    }
    if (latitude != null) {
      _latitude = latitude;
    }
    if (address != null) {
      _address = address;
    }
    if (coverage != null) {
      _coverage = coverage;
    }
  }

  int? get id => _id;
  String? get name => _name;
  String? get email => _email;
  String? get longitude => _longitude;
  String? get latitude => _latitude;
  String? get address => _address;
  int? get coverage => _coverage;


  Branches.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _longitude = json['longitude'];
    _latitude = json['latitude'];
    _address = json['address'];
    _coverage = json['coverage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['email'] = _email;
    data['longitude'] = _longitude;
    data['latitude'] = _latitude;
    data['address'] = _address;
    data['coverage'] = _coverage;
    return data;
  }
}

class PlayStoreConfig {
  bool? _status;
  String? _link;
  String? _minVersion;

  PlayStoreConfig({bool? status, String? link, String? minVersion}) {
    if (status != null) {
      _status = status;
    }
    if (link != null) {
      _link = link;
    }
    if (minVersion != null) {
      _minVersion = minVersion;
    }
  }

  bool? get status => _status;
  String? get link => _link;
  String? get minVersion => _minVersion;


  PlayStoreConfig.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _link = json['link'];
    _minVersion = json['min_version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = _status;
    data['link'] = _link;
    data['min_version'] = _minVersion;
    return data;
  }
}

class SocialMediaLink {
  int? _id;
  String? _name;
  String? _link;
  int? _status;


  SocialMediaLink(
      {int? id,
        String? name,
        String? link,
        int? status,
      }) {
    if (id != null) {
      _id = id;
    }
    if (name != null) {
      _name = name;
    }
    if (link != null) {
      _link = link;
    }
    if (status != null) {
      _status = status;
    }

  }

  int? get id => _id;
  String? get name => _name;
  String? get link => _link;
  int? get status => _status;


  SocialMediaLink.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _link = json['link'];
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['link'] = _link;
    data['status'] = _status;
    return data;
  }
}
