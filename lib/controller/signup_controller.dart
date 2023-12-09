import 'package:flutter/material.dart';

class SignUpController extends ChangeNotifier {
  //validation for username
  String? validateUserName(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username';
    } else {
      return null;
    }
  }

  //validation for email
  String? validateEmail(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a email';
    }
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email';
    } else {
      return null;
    }
  }

  //validation for phone number
  String? validatePhoneNumber(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }

    if (value.length != 10) {
      return 'Please enter a 10-digit phone number';
    } else {
      return null;
    }
  }

  //validation for passwords
  String? validatePasswords(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a passwords';
    } else {
      return null;
    }
  }

  //refactor widget for inputdecrotion
  InputDecoration inputDecration(text, IconData prefixIcon) {
    return InputDecoration(
        labelText: text,
        labelStyle:
            const TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
        prefixIcon: Icon(prefixIcon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)));
  }
}
