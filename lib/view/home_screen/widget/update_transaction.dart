import 'package:budget_tracker/controller/crud_transaction_controller.dart';
import 'package:budget_tracker/view/home_screen/widget/category_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateTransactions extends StatelessWidget {
  const UpdateTransactions(
      {super.key,
      required this.id,
      required this.initialTitle,
      required this.initialAmount,
      required this.initialCategory,
      required this.dropdownValue});

  final String id;
  final String initialTitle;
  final String initialAmount;
  final String initialCategory;
  final String dropdownValue;

  @override
  Widget build(BuildContext context) {
    final addProvider = Provider.of<CrudTransactionController>(context);

    addProvider.updateTitleController.text = initialTitle;
    addProvider.updateAmountController.text = initialAmount;
    addProvider.updateCategory = initialCategory;

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              validator: addProvider.validateUserDailog,
              controller: addProvider.updateTitleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextFormField(
              validator: addProvider.validateUserDailog,
              controller: addProvider.updateAmountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CategoryDropDown(
                categoryType: addProvider.updateCategory,
                onChanged: (value) {
                  addProvider.updateCategoryType(value);
                }),
            // DropdownButtonFormField(
            //     value: addProvider.dropdownValue,
            //     items: const [
            //       DropdownMenuItem(
            //         value: 'credit',
            //         child: Text('Credit'),
            //       ),
            //       DropdownMenuItem(
            //         value: 'debit',
            //         child: Text('Debit'),
            //       ),
            //     ],
            //     onChanged: (value) {
            //       addProvider.changeValues(value);
            //     }),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    addProvider.updateTransactions(
                        id, initialAmount, dropdownValue);
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'Update Transaction',
                  style: TextStyle(
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ))
          ],
        ),
      ),
    );
  }
}
