import 'package:budget_tracker/controller/transactions_history_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimeLineWidget extends StatelessWidget {
  const TimeLineWidget({super.key, required this.onChanged});
  final ValueChanged<String?> onChanged;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionHistoryController>(context);

    return Container(
      height: 45,
      child: ListView.builder(
          // controller: provider.scrollController,
          itemCount: provider.months.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                provider.getCurrentMonth(provider.months[index]);
                onChanged(provider.months[index]);
              },
              child: Container(
                margin: EdgeInsets.all(8),
                width: 80,
                decoration: BoxDecoration(
                    color: provider.currentMonth == provider.months[index]
                        ? Colors.blue.shade900
                        : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Text(
                  provider.months[index],
                  style: TextStyle(
                      color: provider.currentMonth == provider.months[index]
                          ? Colors.white
                          : Colors.black),
                )),
              ),
            );
          }),
    );
  }
}
