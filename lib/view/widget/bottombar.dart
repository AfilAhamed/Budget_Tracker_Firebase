import 'package:budget_tracker/controller/bottombar_controller.dart';
import 'package:budget_tracker/view/demo/demo.dart';
import 'package:budget_tracker/view/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBarScreen extends StatelessWidget {
  BottomBarScreen({super.key});

  final pages = [HomeScreen(), const Demo()];

  @override
  Widget build(BuildContext context) {
    final bottomProvider = Provider.of<BottomBarController>(context);

    return Scaffold(
      body: pages.elementAt(bottomProvider.currentIndex),
      bottomNavigationBar: NavigationBar(
        height: 60,
        indicatorColor: Colors.blue.shade800,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        onDestinationSelected: bottomProvider.getIndex,
        selectedIndex: bottomProvider.currentIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            icon: Icon(
              Icons.explore,
              color: Colors.black,
            ),
            label: 'Transactions',
          ),
        ],
      ),
    );
  }
}
