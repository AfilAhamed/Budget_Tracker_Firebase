import 'package:budget_tracker/controller/signup_controller.dart';
import 'package:budget_tracker/firebase_options.dart';
import 'package:budget_tracker/view/login_screen/user_login_screen.dart';
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
        ChangeNotifierProvider(create: (context) => SignUpController())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Budget Tracker',
        theme: ThemeData(
          useMaterial3: false,
        ),
        home: UserLoginScreen(),
      ),
    );
  }
}
