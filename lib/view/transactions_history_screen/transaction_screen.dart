import 'package:budget_tracker/view/transactions_history_screen/widgets/listview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transaction History',
          style: GoogleFonts.aDLaMDisplay(
              fontWeight: FontWeight.w700, fontSize: 23),
        ),
      ),
      body: const Column(
        children: [
          // TimeLineWidget(
          //   onChanged: (String? value) {
          //     if (value != null) {
          //       // provider.currentMonth = value;
          //       provider.changevaluesHistoryMonth(value);
          //     }
          //   },
          // ),
          // CategoryWidget(
          //   onChanged: (String? value) {
          //     if (value != null) {
          //       // provider.currentCategory = value;
          //       provider.changevaluesHistoryCategory(value);
          //     }
          //   },
          // ),
          Expanded(
              child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      TabBar(labelColor: Colors.black, tabs: [
                        Tab(
                          text: 'Credit',
                        ),
                        Tab(
                          text: 'Debit',
                        )
                      ]),
                      Expanded(
                          child: TabBarView(children: [
                        TransactionListView(
                            // category: provider.currentCategory,
                            // monthYear: provider.currentMonth,
                            drodownValue: 'credit'),
                        TransactionListView(
                            // category: provider.currentCategory,
                            // monthYear: provider.currentMonth,
                            drodownValue: 'debit'),
                      ]))
                    ],
                  )))
        ],
      ),
    );
  }
}
