import 'package:flutter/material.dart';
import 'package:amershop/user/user.dart';
class ShopOwner extends User{     //note that this shopOwner does not have any properties yet
  ShopOwner(
      String id ,
      String firstName,
      String lastName,
      String email,
      String gender,
      String phone,
      ):super(
    id,firstName,lastName,email,gender,phone
  ) ; //hint no body for this constructor because admin just has these properties

}