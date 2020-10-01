import 'package:flutter/material.dart';
abstract class BaseTag{
String id;
String title;


//this is our normal constructor ua_amer
  BaseTag(this.id, this.title);



//this is our convenient constructor ua_amer
BaseTag.fromJson(Map<String,dynamic>jsonObject){
  this.title=jsonObject['title'];
  this.id=jsonObject['id'];
}


}