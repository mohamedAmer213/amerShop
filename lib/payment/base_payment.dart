import 'package:flutter/material.dart';
class BasePayment{
  double amount;
  String paymentId;
  DateTime paymentTime;
String paymentMethod;

//this is the normal constructor ua_amer
BasePayment(
      this.amount,
    this.paymentId,
    this.paymentTime,
    this.paymentMethod);

  //this is the convenient constructor ua_Amer solved
BasePayment.fromJson(Map<String,dynamic> jsonObject){
  this.amount=double.parse(jsonObject['amount']);
  this.paymentId=jsonObject['payment_id'];
  this.paymentTime=jsonObject['payment_time'];
  this.paymentMethod=jsonObject['payment_method'];
}




}