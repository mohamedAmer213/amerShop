import 'package:flutter/material.dart';
import 'package:amershop/product/base_product.dart';
abstract class BaseCartItem{
  BaseProduct product;
 double quantity;

 //this is the normal constructor ua_Amer
  BaseCartItem(this.product, this.quantity);

//we can create convenient constructor that takes the data from
// json object and fill our normal constructor .... so the convenient constructor is
  BaseCartItem.fromJson(Map<String,dynamic> jsonObject){
    this.product=BaseProduct.fromJson(jsonObject['product']);
  this.quantity=jsonObject['quantity'];
}



  double discount(){

  }
}