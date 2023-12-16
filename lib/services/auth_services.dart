import 'dart:developer';
import 'package:budget_tracker/model/total_amount_model.dart';
import 'package:budget_tracker/services/total_amount_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final firebaseAuth = FirebaseAuth.instance;

  //function for sign up  with email and password
  Future<void> createUsers(userData, TotalAmountModel amount) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: userData['email'],
        password: userData['password'],
      );

      await TotalAmountServices().setAmount(amount.toJson());
    } catch (e) {
      log(e.toString());
    }
  }

  //function for login with email and password
  Future<void> loginUser(data) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
    } catch (e) {
      log(e.toString());
    }
  }

  //google sign in
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
