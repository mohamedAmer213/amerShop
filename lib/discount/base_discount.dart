import 'package:flutter/material.dart';
abstract class BaseDiscount{
double minQuantity;
double maxQuantity;
DateTime endDate;

//creating normal constructor
BaseDiscount(this.minQuantity, this.maxQuantity,this.endDate);


//here we must create our convenient constructor...
BaseDiscount.fromJson(Map<String,dynamic> jsonObject){
  this.maxQuantity=jsonObject['max_quantity'];
  this.minQuantity=jsonObject['min_quantity'];
  this.endDate=DateTime.parse(jsonObject['end_date']);
  }
}