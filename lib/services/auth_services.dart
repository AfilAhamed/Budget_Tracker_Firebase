import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final firebaseAuth = FirebaseAuth.instance;

  //function for register user sign up  with email and password
  Future<void> createUsers(Map data) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
    } catch (e) {
      log(e.toString());
    }
  }

  //function for login with email and password
  Future<void> loginUser(data) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
    } catch (e) {
      log(e.toString());
    }
  }
}
