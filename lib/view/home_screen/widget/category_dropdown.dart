import 'package:budget_tracker/helpers/icon.dart';
import 'package:flutter/material.dart';

class CategoryDropDown extends StatelessWidget {
  const CategoryDropDown(
      {super.key, required this.categoryType, required this.onChanged});

  final String? categoryType;
  final ValueChanged<String?> onChanged;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        isExpanded: true,
        hint: const Text('Select Category'),
        value: categoryType,
        items: AppIcons()
            .homeExpenesesCategories
            .map((e) => DropdownMenuItem<String>(
                value: e['name'],
                child: Row(
                  children: [
                    Icon(
                      e['icon'],
                      color: Colors.black54,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      e['name'],
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                )))
            .toList(),
        onChanged: onChanged);
  }
}
