import 'package:budget_tracker/helpers/icon.dart';
import 'package:budget_tracker/view/home_screen/widget/transactions_cards.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                logout();
              },
              icon: const Icon(Icons.exit_to_app))
        ],
        elevation: 0,
        backgroundColor: Colors.blue.shade900,
      ),
      body: Column(
        children: [
          //--
          const MainCard(),
          Padding(
            padding:
                const EdgeInsets.only(top: 0, left: 10, bottom: 0, right: 10),
            child: Row(
              children: [
                const Text(
                  "Recent Transactions",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'View All',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 10),
                              color: Colors.grey.withOpacity(0.15),
                              blurRadius: 10.0,
                              spreadRadius: 9.0,
                            )
                          ],
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(7),
                        child: ListTile(
                          leading: SizedBox(
                            height: 100,
                            width: 80,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green.withOpacity(0.2)),
                              child: Center(
                                  child: FaIcon(AppIcons()
                                      .getExpenseCategoryIcons('Grocery'))),
                            ),
                          ),
                          tileColor: Colors.white,
                          title: const Row(
                            children: [
                              Expanded(
                                  child: Text(
                                'Food Expense',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              )),
                              Text(
                                '₹ 8000',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          subtitle: const Padding(
                            padding: EdgeInsets.only(top: 3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('Balance',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16)),
                                    Spacer(),
                                    Text(
                                      '₹ 500',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    '25 oct 4.55 PM',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

class MainCard extends StatelessWidget {
  const MainCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade900,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Balance',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  '₹ 582000',
                  style: TextStyle(
                      fontSize: 44,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(top: 30, bottom: 10, left: 10, right: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: Colors.white,
            ),
            child: const Row(
              children: [
                TransactionsCard(
                  color: Colors.green,
                ),
                SizedBox(
                  width: 10,
                ),
                TransactionsCard(
                  color: Colors.red,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
