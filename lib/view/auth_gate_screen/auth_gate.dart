import 'package:budget_tracker/view/login_screen/user_login_screen.dart';
import 'package:budget_tracker/view/widget/bottombar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGateWay extends StatelessWidget {
  const AuthGateWay({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasData || snapshot.data != null) {
            return BottomBarScreen();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.red),
            );
          }

          return const UserLoginScreen();
        });
  }
}
