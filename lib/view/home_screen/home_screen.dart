import 'package:budget_tracker/controller/crud_transaction_controller.dart';
import 'package:budget_tracker/controller/user_login_controller.dart';
import 'package:budget_tracker/helpers/icon.dart';
import 'package:budget_tracker/view/home_screen/widget/add_transaction.dart';
import 'package:budget_tracker/view/home_screen/widget/overview_card.dart';
import 'package:budget_tracker/view/home_screen/widget/update_transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  addDailogBuilder(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            backgroundColor: Colors.white,
            content: AddTransactions(),
          );
        });
  }

  updateDailogBuilder(context, id, title, amount, category, dropdown) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: UpdateTransactions(
              id: id,
              initialTitle: title,
              initialAmount: amount,
              initialCategory: category,
              dropdownValue: dropdown,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CrudTransactionController>(context);
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final sigoutProvider = Provider.of<UserLoginController>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                sigoutProvider.logout();
              },
              icon: const Icon(Icons.exit_to_app))
        ],
        elevation: 0,
        backgroundColor: Colors.blue.shade900,
      ),
      body: Column(
        children: [
          BudgetOverviewCard(userId: userId),
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
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
          Expanded(
              child: FutureBuilder<QuerySnapshot>(
            future: provider.getTransactions(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshoot) {
              if (snapshoot.hasError) {
                return const Text('error occured');
              } else if (snapshoot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!snapshoot.hasData || snapshoot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('No Transactions found '),
                );
              }
              final data = snapshoot.data!.docs;

              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final indexData = data[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 10),
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
                          padding: const EdgeInsets.all(4.8),
                          child: Slidable(
                            endActionPane: ActionPane(
                                motion: const DrawerMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (value) {
                                      updateDailogBuilder(
                                          context,
                                          indexData['id'],
                                          indexData['title'],
                                          indexData['amount'],
                                          indexData['category'],
                                          indexData['dropDownValue']);
                                    },
                                    backgroundColor: Colors.blue,
                                    icon: Icons.edit,
                                  ),
                                  SlidableAction(
                                    onPressed: (value) {
                                      provider.deleteTransactions(
                                          indexData['id'],
                                          indexData['amount'],
                                          indexData['dropDownValue']);
                                    },
                                    backgroundColor: Colors.red,
                                    icon: Icons.delete,
                                  )
                                ]),
                            child: ListTile(
                              leading: SizedBox(
                                height: 100,
                                width: 80,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color:
                                          indexData['dropDownValue'] == 'credit'
                                              ? Colors.green.withOpacity(0.2)
                                              : Colors.red.withOpacity(0.2)),
                                  child: Center(
                                      child: FaIcon(
                                          color: indexData['dropDownValue'] ==
                                                  'credit'
                                              ? Colors.green
                                              : Colors.red,
                                          AppIcons().getExpenseCategoryIcons(
                                              indexData['category']
                                                  .toString()))),
                                ),
                              ),
                              tileColor: Colors.white,
                              title: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    indexData['title'].toString(),
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  )),
                                  Text(
                                    "${indexData['dropDownValue'] == 'credit' ? '+' : '-'} ₹${indexData['amount']}",
                                    style: TextStyle(
                                        color: indexData['dropDownValue'] ==
                                                'credit'
                                            ? Colors.green
                                            : Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text('Balance',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16)),
                                      const Spacer(),
                                      Text(
                                        '₹ ${indexData['totalBalance']}',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    indexData['Date'].toString(),
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            },
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addDailogBuilder(context);
        },
        backgroundColor: Colors.blue.shade900,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
