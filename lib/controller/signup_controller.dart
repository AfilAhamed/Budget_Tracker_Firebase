import 'package:budget_tracker/services/auth_services.dart';
import 'package:flutter/material.dart';

class SignUpController extends ChangeNotifier {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void sumbitData() async {
    final data = {
      'username': userNameController.text,
      'email': emailController.text,
      'phone number': phoneNumberController.text,
      'password': passwordController.text,
    };
    await AuthServices().createUsers(data);
    notifyListeners();
  }

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
}
