import 'package:flutter/material.dart';

class BottomBarController extends ChangeNotifier {
  int currentIndex = 0;
  //bottombar index
  void getIndex(value) {
    currentIndex = value;
    notifyListeners();
  }
}
