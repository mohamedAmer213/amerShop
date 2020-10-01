import 'package:flutter/material.dart';
import 'package:amershop/cart_item/base_cart_item.dart';
import 'package:amershop/cart_item/base_cart_item_controller.dart';
 class BaseCart{
List<BaseCartItem> items;

//this is just normal constructor we need to convenient constructor ,too.
BaseCart(this.items);


//the convenient constructor
 BaseCart.fromJson(Map<String,dynamic> jsonObject){
this.items=BaseCartItemController.toBaseCartItems(jsonObject['items']);
 }

}