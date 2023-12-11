import 'package:budget_tracker/controller/signup_controller.dart';
import 'package:budget_tracker/controller/user_login_controller.dart';
import 'package:budget_tracker/firebase_options.dart';
import 'package:budget_tracker/view/auth_gate_screen/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignUpController()),
        ChangeNotifierProvider(create: (context) => UserLoginController())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Budget Tracker',
        theme: ThemeData(
          useMaterial3: false,
        ),
        home: const AuthGateWay(),
      ),
    );
  }
}
