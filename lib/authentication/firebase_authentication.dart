import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:amershop/authentication/authenticatable.dart';
import 'package:amershop/user/user.dart';

class ShopFirebaseAuthentication implements Authenticatable {
  FirebaseAuth firbaseAuth = FirebaseAuth.instance;

  @override
  register(String email, String password) async {
    var user = await firbaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return user;
  }

  @override
  signIn(String email, String password) async {
    var user = await firbaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }

  @override
  signOut() async {
    var user = await firbaseAuth.signOut();
    return user;
  }
}
