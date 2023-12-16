import 'package:budget_tracker/model/total_amount_model.dart';
import 'package:budget_tracker/services/auth_services.dart';
import 'package:flutter/material.dart';

class SignUpController extends ChangeNotifier {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // sign up to the app
  void signUp() async {
    final userDatas = {
      'userName': userNameController.text,
      'email': emailController.text,
      'password': passwordController.text,
    };
    final transactionData =
        TotalAmountModel(totalBalance: 0, totalCredit: 0, totalDebit: 0);
    await AuthServices().createUsers(userDatas, transactionData);
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

  //validation for passwords
  String? validatePasswords(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a passwords';
    } else {
      return null;
    }
  }
}
