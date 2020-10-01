import 'package:flutter/material.dart';
import 'package:amershop/order/base_order.dart';
class OrderController{
  BaseOrder baseOrder;
  //create normal Constructor
OrderController(this.baseOrder);




//we can also create convenient Constructor here..


//----------------------Methods------------
  //we need to create method to return List to fill ordersList in the
  // customer class
  static List<BaseOrder>toOrders(List<Map<String ,dynamic>> jsonObjects){

  }

}