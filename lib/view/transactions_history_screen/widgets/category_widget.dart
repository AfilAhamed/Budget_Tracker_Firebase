import 'package:budget_tracker/controller/transactions_history_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key, required this.onChanged});
  final ValueChanged<String?> onChanged;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionHistoryController>(context);
    return Container(
      height: 50,
      child: ListView.builder(
          // controller: provider.scrollController,
          itemCount: provider.categoryList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final data = provider.categoryList[index];
            return GestureDetector(
              onTap: () {
                provider.getCurrentCategory(data['name']);
                // currentCategory = data['name'];
                onChanged(data['name']);
              },
              child: Container(
                margin: EdgeInsets.all(8),
                width: 100,
                decoration: BoxDecoration(
                    color: provider.currentCategory == data['name']
                        ? Colors.blue.shade900
                        : Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      data['icon'],
                      color: provider.currentCategory == data['name']
                          ? Colors.white
                          : Colors.black,
                      size: 18,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      data['name'],
                      style: TextStyle(
                          color: provider.currentCategory == data['name']
                              ? Colors.white
                              : Colors.blue.shade900),
                    ),
                  ],
                )),
              ),
            );
          }),
    );
  }
}
