import 'package:flutter/material.dart';
import 'package:amershop/category/base_category.dart';
import 'package:amershop/category/category_controller.dart';
import 'package:amershop/discount/base_discount.dart';
import 'package:amershop/discount/discount_controller.dart';
import 'package:amershop/image/base_image.dart';
import 'package:amershop/image/image_controller.dart';
import 'package:amershop/product_option/product_options.dart';
import 'package:amershop/quantity/base_quantity.dart';
import 'package:amershop/quantity/quantity_controller.dart';
import 'package:amershop/tag/base_tag.dart';
import 'package:amershop/tag/tag_controller.dart';
 class BaseProduct{
  String id;
  String title;
  String description;
  double quantity;  //because we don't know the kind of the product
  List<BaseImage> images;
  List<BaseProductOption> option;
  List<BaseCategory> categories;
  List<BaseTag> tags;
  List<BaseDiscount> discounts;

  BaseProduct(
      this.id,
      this.title,
      this.description,
      this.quantity,
      this.images,
      this.option,
      this.categories,
      this.tags,
      this.discounts); //we can but the normal constructor here like this... it is easy task



//why not we create convenient constructor here ua_amer
BaseProduct.fromJson(Map<String,dynamic> jsonObject){
  //ToDo the child constructor uaAmer
this.id=jsonObject['id'];
this.title=jsonObject['title'];
this.description=jsonObject['description'];
this.images=jsonObject['images'];
this.option=jsonObject['option'];
this.discounts=DiscountController.toDiscounts(jsonObject['discounts']);
this.images=ImageController.toImages(jsonObject['images']);
this.categories=CategoryController.toCategories(jsonObject['categories']);
this.tags=TagController.toTags(jsonObject['tags']);

}



}
