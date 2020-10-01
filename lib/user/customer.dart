import 'dart:io';

import 'package:flutter/material.dart';
import 'package:amershop/order/order_controller.dart';
import 'package:amershop/product/base_product.dart';
import 'package:amershop/product/product_controller.dart';
import 'package:amershop/user/user.dart';
import 'package:amershop/address/address.dart';
import 'package:amershop/order/base_order.dart';
class Customer extends User {
Address shippingAddress;
Address billingAddress;
List<BaseOrder> orders;
List<BaseProduct> watchList;

//this is the original constructor
Customer(
    String id,
    String firstName,
    String lastName,
    String email,
    String gender,
    String phone,
  // from here we will add the new parameters
  Address billingAddress,
  Address shippingAddress,
  List<BaseOrder> orders,
  List<BaseProduct> watchList,
  // the end of new parameters of this constructor
  ) : super(id, firstName, lastName, email, phone,gender){
    this.orders=orders;
    this.watchList=watchList;
    this.shippingAddress=shippingAddress;
    this.billingAddress=billingAddress;
  }

/*
* very import note here this class needs to convenient constructor ...so what is the
* purpose of using convenient constructor here ?
*
* the customer object will come from firebase and this will be at json format
* so we need to make some thing that takes the coming data from json format
* and fill the original customer constructor to store it in the database
* */

//this is our convenient Constructor ua_amer
Customer.fromJson(Map<String,dynamic> jsonObject):super(
  jsonObject['id'],
  jsonObject['firstName'],
  jsonObject['lastName'],
  jsonObject['email'],
  jsonObject['gender'],
  jsonObject['phone']
) // we have to satisfy the super constructor
 {
  this.shippingAddress=Address.fromJson(jsonObject['address']);
  this.billingAddress=Address.fromJson(jsonObject['billing_address']);
 this.watchList=ProductController.toProducts(jsonObject['watch_list']);
 this.orders=OrderController.toOrders(jsonObject['orders']);

 }  // so this is the end of the child constructor..so all is well



}
