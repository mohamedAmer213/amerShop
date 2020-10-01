import 'package:flutter/material.dart';
abstract class BaseProductOption{
String name;
String value;
double price;
String meta;

//this is the normal constructor
BaseProductOption(this.name, this.value, this.price, this.meta);


//this is the convenient constructor for this ua_Amer solved
BaseProductOption.fromJson(Map<String,dynamic> jsonObject){
  this.name=jsonObject['name'];
  this.value=jsonObject['value'];
  this.meta=jsonObject['meta'];
this.price=double.parse(jsonObject['price']);
}
}