import 'package:flutter/material.dart';

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

InputDecoration inputDecration(text, IconData suffixIcon) {
  return InputDecoration(
      labelText: text,
      suffixIcon: Icon(suffixIcon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)));
}
