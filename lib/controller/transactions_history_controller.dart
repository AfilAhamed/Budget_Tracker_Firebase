import 'package:budget_tracker/helpers/icon.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class TransactionHistoryController extends ChangeNotifier {
  TransactionHistoryController() {
    getMonth();
    iconList();
  }
  String currentMonth = '';
  List<String> months = [];
  // final scrollController = ScrollController();

  void getMonth() {
    DateTime now = DateTime.now();
    for (var i = -23; i <= 0; i++) {
      months.add(
          DateFormat('MMM y').format(DateTime(now.year, now.month + i, 1)));
    }
    currentMonth = DateFormat('MMM y').format(now);
    // Future.delayed(const Duration(seconds: 1), () {
    //   scrollAnimationEffect();
    // });
    notifyListeners();
  }

  getCurrentMonth(month) {
    currentMonth = month;
    notifyListeners();
  }

  // scrollAnimationEffect() {
  //   final selectedMonthIndex = months.indexOf(currentMonth);
  //   if (selectedMonthIndex != -1) {
  //     final scrollOffset = (selectedMonthIndex * 100.0) - 170;
  //     scrollController.animateTo(50,
  //         duration: const Duration(milliseconds: 500), curve: Curves.ease);
  //     notifyListeners();
  //   }
  //   notifyListeners();
  // }
  String currentCategory = "All";

  getCurrentCategory(category) {
    currentCategory = category;
    notifyListeners();
  }

  //--all
  List<Map<String, dynamic>> categoryList = [];
  var add = {
    'name': 'All',
    'icon': FontAwesomeIcons.cartPlus,
  };

  void iconList() {
    categoryList = AppIcons().homeExpenesesCategories;
    categoryList.insert(0, add);
    notifyListeners();
  }

  ///history page value
  changevaluesHistoryCategory(category) {
    currentCategory = category;
    notifyListeners();
  }

  changevaluesHistoryMonth(month) {
    currentMonth = month;
    notifyListeners();
  }
}
