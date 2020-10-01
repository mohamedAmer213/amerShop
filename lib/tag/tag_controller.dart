import 'package:flutter/material.dart';
import 'package:amershop/tag/base_tag.dart';

class TagController {
  BaseTag baseTag;

  TagController(this.baseTag);

  static List<BaseTag> toTags(List<Map<String, dynamic>> jsonObjects) {}
}
