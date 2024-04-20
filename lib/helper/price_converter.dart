import 'package:efood_kitchen/controller/splash_controller.dart';
import 'package:efood_kitchen/data/model/response/config_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PriceConverter {
  static String convertPrice(BuildContext context, double price, {double? discount, String? discountType}) {
    if(discount != null && discountType != null){
      if(discountType == 'amount') {
        price = price - discount;
      }else if(discountType == 'percent') {
        price = price - ((discount / 100) * price);
      }
    }
    final ConfigModel configModel =  Get.find<SplashController>().configModel;
    return '${configModel.currencySymbolPosition == 'left' ? configModel.currencySymbol : ''}${configModel.currencySymbol}''${(price).toStringAsFixed(configModel.decimalPointSettings ?? 0
    ).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}${configModel.currencySymbolPosition == 'right' ? configModel.currencySymbol : ''}';
  }

  static double convertWithDiscount(BuildContext context, double price, double discount, String discountType) {
    if(discountType == 'amount') {
      price = price - discount;
    }else if(discountType == 'percent') {
      price = price - ((discount / 100) * price);
    }
    return price;
  }

  static double calculation(double amount, double discount, String type, int quantity) {
    double calculatedAmount = 0;
    if(type == 'amount') {
      calculatedAmount = discount * quantity;
    }else if(type == 'percent') {
      calculatedAmount = (discount / 100) * (amount * quantity);
    }
    return calculatedAmount;
  }

  static String percentageCalculation(BuildContext context, String price, String discount, String discountType) {
    return '$discount${discountType == 'percent' ? '%' : '\$'} OFF';
  }
}