import 'dart:developer';
import 'package:budget_tracker/model/total_amount_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TotalAmountServices {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  final userCollection = FirebaseFirestore.instance.collection('users');

  // to set amount
  Future<void> setAmount(data) async {
    await userCollection
        .doc(userId)
        .set(data)
        .then((value) => log('Amount Seted'));
  }

// update amount based on adding transactions
  Future<void> updateAmount(TotalAmountModel data) async {
    await userCollection.doc(userId).update(data.toJson());
  }
}
