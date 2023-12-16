import 'package:budget_tracker/view/home_screen/widget/transactions_cards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BudgetOverviewCard extends StatelessWidget {
  const BudgetOverviewCard({
    super.key,
    required this.userId,
  });
  final String userId;

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> userStream =
        FirebaseFirestore.instance.collection('users').doc(userId).snapshots();
    return StreamBuilder<DocumentSnapshot>(
        stream: userStream,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshoot) {
          if (snapshoot.hasError) {
            return Text('something went wrong');
          }

          if (snapshoot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          var data = snapshoot.data!.data() as Map<String, dynamic>;

          return Container(
            color: Colors.blue.shade900,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total Balance',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '₹${data['totalBalance'].toString()} ',
                        style: const TextStyle(
                            fontSize: 44,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 30, bottom: 10, left: 10, right: 10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      TransactionsCard(
                        amount: data['totalCredit'].toString(),
                        title: 'Credit',
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      TransactionsCard(
                        title: 'Debit',
                        amount: data['totalDebit'].toString(),
                        color: Colors.red,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
