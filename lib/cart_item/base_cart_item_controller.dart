import 'package:flutter/material.dart';
import 'package:amershop/cart_item/base_cart_item.dart';

class BaseCartItemController {
  BaseCartItem baseCartItem;

  BaseCartItemController(this.baseCartItem);

  static List<BaseCartItem> toBaseCartItems(Map<String, dynamic> jsonObjects) {}
}
