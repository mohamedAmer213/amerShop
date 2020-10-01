import 'package:flutter/material.dart';
abstract class BaseCategory{
  String id;
  String title;

  //this is the normal constructor for this class so we have to create our ...convenient constructor
  BaseCategory(this.id, this.title);


  // the convenient constructor
BaseCategory.fromJson(Map<String,dynamic>jsonObject){
this.title=jsonObject['title'];
this.id=jsonObject['id'];
}

}