import 'package:flutter/material.dart';

abstract class BaseImage {
  String id;
  String altText;
  String url;

//normal constructor
  BaseImage(this.id, this.altText, this.url);

//convenient constructor ua_amer
  BaseImage.fromJson(Map<String, dynamic> jsonObject) {
    this.id = jsonObject['id'];
    this.altText = jsonObject['alt_text'];
    this.url = jsonObject['url'];
  }
}
