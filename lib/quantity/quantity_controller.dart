import 'package:flutter/material.dart';
import 'package:amershop/quantity/base_quantity.dart';

class QuantityController {
  BaseQuantity baseQuantity;

  QuantityController(this.baseQuantity);

  static List<BaseQuantity> toQuantities(
      List<Map<String, dynamic>> jsonObjects) {}
}
