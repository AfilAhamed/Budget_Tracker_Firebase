import 'package:budget_tracker/model/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TransactionServices {
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final userId = FirebaseAuth.instance.currentUser!.uid;

  // add Transactions Details to Db
  Future<void> addTransactionToDb(data, id) async {
    await userCollection
        .doc(userId)
        .collection('Transactions')
        .doc(id)
        .set(data.toJson());
  }

  // fetch Transaction Datas from Db
  getTransactionsFromDb() {
    return userCollection.doc(userId).collection('Transactions').get();
  }

  //delete transaction details form Db
  Future<void> deleteTransactionFromDb(String id) async {
    await userCollection
        .doc(userId)
        .collection('Transactions')
        .doc(id)
        .delete();
  }

  //update transaction details from Db
  Future<void> updateTransactionFromDb(String id, TransactionModel data) async {
    await userCollection
        .doc(userId)
        .collection('Transactions')
        .doc(id)
        .update(data.toJson());
  }
}
