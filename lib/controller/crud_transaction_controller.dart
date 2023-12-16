import 'package:budget_tracker/model/total_amount_model.dart';
import 'package:budget_tracker/model/transaction_model.dart';
import 'package:budget_tracker/services/transaction_services.dart';
import 'package:budget_tracker/services/total_amount_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class CrudTransactionController extends ChangeNotifier {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  String dropdownValue = 'credit';
  var category = 'Others';
  final user = FirebaseAuth.instance.currentUser;
  String dates = DateFormat('d MMM hh:mma').format(DateTime.now());

  // Add Transactions
  Future<void> addTransactions() async {
    var amount = int.parse(amountController.text);
    var uid = const Uuid();
    var id = uid.v4();

    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    int totalBalance = userDoc['totalBalance'];
    int totalCredit = userDoc['totalCredit'];
    int totalDebit = userDoc['totalDebit'];

    if (dropdownValue == 'credit') {
      totalBalance += amount;
      totalCredit += amount;
    } else {
      totalBalance -= amount;
      totalDebit += amount;
    }

    final data = TotalAmountModel(
        totalBalance: totalBalance,
        totalCredit: totalCredit,
        totalDebit: totalDebit);

    await TotalAmountServices().updateAmount(data);

    final transactionDataModel = TransactionModel(
      id: id,
      title: titleController.text,
      amount: amountController.text,
      category: category,
      dropdownValue: dropdownValue,
      dates: dates,
      totalBalance: totalBalance,
    );

    await TransactionServices().addTransactionToDb(transactionDataModel, id);
    // Clear controllers
    titleController.clear();
    amountController.clear();

    // Optionally, reset dropdown and category values
    dropdownValue = 'credit';
    category = 'Others';
    notifyListeners();
  }

  //get Transations details
  getTransactions() {
    return TransactionServices().getTransactionsFromDb();
  }

  //delete transactions
  Future<void> deleteTransactions(String id, amount, dropdownvalue) async {
    await TransactionServices().deleteTransactionFromDb(id);

    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    int totalBalance = userDoc['totalBalance'];
    int totalCredit = userDoc['totalCredit'];
    int totalDebit = userDoc['totalDebit'];

    // Adjust the totals based on the deleted transaction
    if (dropdownvalue == 'credit') {
      totalBalance -= int.parse(amount.toString());
      totalCredit -= int.parse(amount.toString());
    } else {
      totalBalance += int.parse(amount.toString());
      totalDebit -= int.parse(amount.toString());
    }

    final data = TotalAmountModel(
        totalBalance: totalBalance,
        totalCredit: totalCredit,
        totalDebit: totalDebit);

    await TotalAmountServices().updateAmount(data);
    notifyListeners();
  }

  final updateTitleController = TextEditingController();
  final updateAmountController = TextEditingController();
  var updateCategory = 'Others';

  //update Transactions
  Future<void> updateTransactions(id, amount, dropdownData) async {
    // Calculate the amount change
    int oldAmount = int.parse(amount.toString());
    int newAmount = int.parse(updateAmountController.text);
    int amountChange = newAmount - oldAmount;

    dropdownValue = dropdownData;

    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    int totalBalance = userDoc['totalBalance'];
    int totalCredit = userDoc['totalCredit'];
    int totalDebit = userDoc['totalDebit'];

    if (dropdownValue == 'credit') {
      totalBalance += amountChange;
      totalCredit += amountChange;
    } else {
      totalBalance -= amountChange;
      totalDebit += amountChange;
    }

    final data = TotalAmountModel(
        totalBalance: totalBalance,
        totalCredit: totalCredit,
        totalDebit: totalDebit);
    await TotalAmountServices().updateAmount(data);
    final transactionDataModel = TransactionModel(
      id: id,
      title: updateTitleController.text,
      amount: updateAmountController.text,
      dates: dates,
      category: updateCategory,
      dropdownValue: dropdownValue,
      totalBalance: totalBalance,
    );

    await TransactionServices()
        .updateTransactionFromDb(id, transactionDataModel);
    notifyListeners();
  }

  //change dropdown value from update
  void updateCategoryType(value) {
    updateCategory = value;
    notifyListeners();
  }

  // dropdown for selecting credit or debit
  void changeValues(value) {
    if (value != null) {
      dropdownValue = value;
      notifyListeners();
    }
  }

  // dropdown for selecting categorys
  void categoryType(value) {
    if (value != null) {
      category = value;
      notifyListeners();
    }
  }

  //validation for addTransaction fields
  String? validateUserDailog(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter full Details';
    } else {
      return null;
    }
  }
}
