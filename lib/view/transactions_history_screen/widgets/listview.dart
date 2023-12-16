import 'package:budget_tracker/helpers/icon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class TransactionListView extends StatelessWidget {
  const TransactionListView(
      {super.key,
      // required this.category,
      // required this.monthYear,
      required this.drodownValue});
  // final String category;
  // final String monthYear;
  final String drodownValue;
  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    Query query = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('Transactions')
        .where('dropDownValue', isEqualTo: drodownValue);

    return FutureBuilder<QuerySnapshot>(
      future: query.limit(150).get(),
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
              // DateTime date =
              //     DateTime.fromMillisecondsSinceEpoch(indexData['timestamp']);
              String formatedDate =
                  DateFormat('d MMM hh:mma').format(DateTime.now());
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
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
                    child: ListTile(
                      leading: SizedBox(
                        height: 100,
                        width: 80,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: indexData['dropDownValue'] == 'credit'
                                  ? Colors.green.withOpacity(0.2)
                                  : Colors.red.withOpacity(0.2)),
                          child: Center(
                              child: FaIcon(
                                  color: indexData['dropDownValue'] == 'credit'
                                      ? Colors.green
                                      : Colors.red,
                                  AppIcons().getExpenseCategoryIcons(
                                      indexData['category']))),
                        ),
                      ),
                      tileColor: Colors.white,
                      title: Row(
                        children: [
                          Expanded(
                              child: Text(
                            indexData['title'],
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          )),
                          Text(
                            "${indexData['dropDownValue'] == 'credit' ? '+' : '-'} ₹${indexData['amount']}",
                            style: TextStyle(
                                color: indexData['dropDownValue'] == 'credit'
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
                                      color: Colors.grey, fontSize: 16)),
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
                            formatedDate,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}
