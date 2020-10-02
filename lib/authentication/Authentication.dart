import 'package:flutter/material.dart';
import 'package:amershop/authentication/authenticatable.dart';
import 'package:amershop/user/user.dart';
class Authentication implements Authenticatable{
  @override
  Future<User> register(String email, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<bool> signIn(String email, String password)  {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }


  
}