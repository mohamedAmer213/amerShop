import 'package:flutter/material.dart';
import 'package:amershop/category/base_category.dart';

class CategoryController {
  BaseCategory baseCategory;

  CategoryController(this.baseCategory);

  static List<BaseCategory> toCategories(
      List<Map<String, dynamic>> jsonObjects) {}
}
