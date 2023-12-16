import 'package:budget_tracker/controller/crud_transaction_controller.dart';
import 'package:budget_tracker/view/home_screen/widget/category_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTransactions extends StatelessWidget {
  const AddTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    final addProvider = Provider.of<CrudTransactionController>(context);
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              validator: addProvider.validateUserDailog,
              controller: addProvider.titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextFormField(
              validator: addProvider.validateUserDailog,
              controller: addProvider.amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CategoryDropDown(
                categoryType: addProvider.category,
                onChanged: (value) {
                  addProvider.categoryType(value);
                }),
            DropdownButtonFormField(
                value: addProvider.dropdownValue,
                items: const [
                  DropdownMenuItem(
                    value: 'credit',
                    child: Text('Credit'),
                  ),
                  DropdownMenuItem(
                    value: 'debit',
                    child: Text('Debit'),
                  ),
                ],
                onChanged: (value) {
                  addProvider.changeValues(value);
                }),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    addProvider.addTransactions();
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'Add Transaction',
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
