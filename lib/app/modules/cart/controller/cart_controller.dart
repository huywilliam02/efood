import 'dart:convert';
import 'dart:developer';

import 'package:citgroupvn_efood_table/base/base_controller.dart';
import 'package:citgroupvn_efood_table/data/model/response/cart_model.dart';
import 'package:citgroupvn_efood_table/data/model/response/product_model.dart';
import 'package:citgroupvn_efood_table/data/repository/cart_repo.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CartController extends BaseController implements GetxService {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  List<CartModel> _cartList = [];
  double _amount = 0.0;
  final bool _isCartUpdate = false;
  int? _peopleNumber;
  double _totalAmount = 0.0;

  List<CartModel> get cartList => _cartList;
  double get amount => _amount;
  double get totalAmount => _totalAmount;
  bool get isCartUpdate => _isCartUpdate;
  int? get peopleNumber => _peopleNumber;

  @override
  void onInit() {
    getCartData();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.onInit();
  }

  @override
  void onClose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.onClose();
  }

  set setPeopleNumber(int value) {
    _peopleNumber = value;
  }

  set setTotalAmount(double value) {
    _totalAmount = value;
  }

  void getCartData() {
    _cartList = [];
    _cartList.addAll(cartRepo.getCartList());
    for (var cart in _cartList) {
      _amount = _amount + (cart.discountedPrice! * cart.quantity!);
    }
  }

  int getCartIndex(Product product) {
    for (int index = 0; index < _cartList.length; index++) {
      if (_cartList[index].product?.id == product.id) {
        if (_cartList[index].product?.variations != null &&
            cartList[index].product!.variations!.isNotEmpty &&
            _cartList[index].product!.variations![0].isMultiSelect != null) {
          if (_cartList[index].product!.variations![0].isMultiSelect ==
              product.variations![0].isMultiSelect) {
            return index;
          }
        } else {
          return index;
        }
      }
    }
    return -1;
  }

  int getCartQty(Product product) {
    int count = 0;
    for (int i = 0; i < _cartList.length; i++) {
      if (product.id == _cartList[i].product?.id) {
        count += _cartList[i].quantity!;
      }
    }
    return count;
  }

  void addToCart(CartModel cartModel, int index) {
    log(jsonEncode(cartModel));
    if (index != -1) {
      _cartList.replaceRange(index, index + 1, [cartModel]);
    } else {
      _cartList.add(cartModel);
    }
    cartRepo.addToCartList(_cartList);

    update();
  }

  void removeFromCart(int index) {
    _amount = _amount -
        (_cartList[index].discountedPrice! * _cartList[index].quantity!);
    _cartList.removeAt(index);
    cartRepo.addToCartList(_cartList);
    update();
  }

  void clearCartData() {
    _cartList = [];
    cartRepo.clearCartData();
    update();
  }

  int getCartProductQuantityCount(Product? product) {
    int quantity = 0;
    if (product != null) {
      for (int index = 0; index < _cartList.length; index++) {
        if (_cartList[index].product!.id == product.id) {
          quantity = quantity + (_cartList[index].quantity ?? 0);
        }
      }
    }
    return quantity;
  }
}
