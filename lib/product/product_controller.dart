import 'package:flutter/material.dart';
import 'package:amershop/product/base_product.dart';
class ProductController {
List<BaseProduct> products;

//this is normal constructor ua_amer ...but the question is can we create
  // the convenient constructor in this case or not
ProductController(this.products);



//hint this method will be used to return List of BaseProducts..to Fill the WatchList in the Customer file or class
  // and this method should be here because this is the controller of product
  static List<BaseProduct> toProducts(List<Map<String,dynamic>> jsonObjects){

  }
}