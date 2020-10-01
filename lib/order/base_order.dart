import 'package:flutter/material.dart';
import 'package:amershop/cart/base_cart.dart';
import 'package:amershop/payment/base_payment.dart';
import 'package:amershop/user/customer.dart';
abstract class BaseOrder{
  BaseCart cart;
  Customer customer;
  BasePayment basePayment;

  BaseOrder(this.cart, this.customer, this.basePayment);

  BaseOrder.fromJson(Map<String,dynamic>jsonObject){
    this.cart=jsonObject['cart'];
    this.customer=Customer.fromJson(jsonObject['customer']);
  }
}