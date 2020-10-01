import 'package:flutter/material.dart';
class Address{
  String streetName;
  String streetNumber;
  String city;
  String postCode;
  String country;

  Address(this.streetName,
      this.streetNumber,
      this.city,
      this.postCode,
      this.country);

//so this will our convenient constructor ua_amer
Address.fromJson(Map<String,dynamic> jsonObject){
//small hint no super construct here ua_amer...solved

this.streetName=jsonObject['street_name'];
this.streetNumber=jsonObject['street_number'];
this.city=jsonObject['city'];
this.postCode=jsonObject['post_code'];
this.country=jsonObject['country'];


}
}