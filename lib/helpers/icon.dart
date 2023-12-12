import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppIcons {
  final List<Map<String, dynamic>> homeExpenesesCategories = [
    {
      "name": "Gas filling",
      "icon": FontAwesomeIcons.gasPump,
    },
    {
      "name": "Grocery",
      "icon": FontAwesomeIcons.cartShopping,
    },
    {"name": "milk", "icon": FontAwesomeIcons.mugHot},
    {"name": "home", "icon": FontAwesomeIcons.productHunt},
    {"name": "Others", "icon": FontAwesomeIcons.gasPump}
    // ,{
    //   "name":"Gas filling"
    //   "icon": FontAwesomeIcons.gasPump
    // },
    // {
    //   "name":"Gas filling"
    //   "icon": FontAwesomeIcons.gasPump
    // }
  ];

  IconData getExpenseCategoryIcons(String catagoryName) {
    final category = homeExpenesesCategories.firstWhere(
        (category) => category['name'] == catagoryName,
        orElse: () => {"icon": FontAwesomeIcons.cartShopping});
    return category['icon'];
  }
}
