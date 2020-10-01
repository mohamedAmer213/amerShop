import 'package:flutter/material.dart';
import 'package:amershop/order/base_order.dart';
import 'package:amershop/product/base_product.dart';
import 'package:amershop/user/user.dart';

import 'customer.dart';
class CustomerController{

  Customer customer;
CustomerController(this.customer);
  //our methods for this class ua_amer
  void addToOrders(BaseOrder order){
    customer.orders.add(order);
  }

  void addToWatchList(BaseProduct product){
    customer.watchList.add(product);
  }

// to check if the order is in the list of orders or not
  bool orderInOrders(BaseOrder order){
    return customer.orders.contains(order);    // this will return true or false
  }

  bool productInWatchList(BaseProduct product){
    return customer.watchList.contains(product);    // this will return true or false
  }

  bool removeProductInWatchList(BaseProduct product){
    return customer.watchList.remove(product);
  }

}