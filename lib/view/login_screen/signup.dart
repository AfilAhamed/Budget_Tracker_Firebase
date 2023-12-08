import 'package:budget_tracker/controller/login_controller.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      } else {
                        return null;
                      }
                    },
                    decoration: inputDecration('Username', Icons.person)),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: validateEmail,
                    decoration: inputDecration('Email', Icons.email)),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: validatePhoneNumber,
                  decoration: inputDecration('Phone Number', Icons.phone),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Form submitted successfully')));
                          }
                        },
                        child: const Text('Sumbit')))
              ],
            )),
      ),
    );
  }
}
