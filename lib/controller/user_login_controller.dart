import 'package:budget_tracker/services/auth_services.dart';
import 'package:flutter/material.dart';

class UserLoginController extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() async {
    final data = {
      'email': emailController.text,
      'password': passwordController.text,
    };
    await AuthServices().loginUser(data);

    notifyListeners();
  }

  //validation for email
  String? loginValidateEmail(value) {
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

  //validation for passwords
  String? loginValidatePasswords(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a passwords';
    } else {
      return null;
    }
  }
}
