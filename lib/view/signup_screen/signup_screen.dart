import 'package:budget_tracker/controller/signup_controller.dart';
import 'package:budget_tracker/helpers/decoration.dart';
import 'package:budget_tracker/view/login_screen/user_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final signupProvider = Provider.of<SignUpController>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lets Create Your Account',
                    style: GoogleFonts.aDLaMDisplay(
                        fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                      controller: signupProvider.userNameController,
                      validator: signupProvider.validateUserName,
                      decoration:
                          inputDecration('Username', Icons.person_pin_rounded)),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                      controller: signupProvider.emailController,
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: signupProvider.validateEmail,
                      decoration: inputDecration('E-Mail', Icons.email)),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: signupProvider.passwordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: signupProvider.validatePasswords,
                    decoration:
                        inputDecration('Password', Iconsax.password_check),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13)),
                              backgroundColor: Colors.blue.shade600),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              signupProvider.signUp();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const UserLoginScreen()));
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //     const SnackBar(
                              //         content:
                              //             Text('Form submitted successfully')));
                            }
                          },
                          child: Text(
                            'Sign Up',
                            style: GoogleFonts.mali(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ))),
                  const SizedBox(
                    height: 30,
                  ),
                  const Row(
                    children: [
                      Flexible(
                          child: Divider(
                        color: Colors.grey,
                        thickness: 0.4,
                        endIndent: 5,
                        indent: 20,
                      )),
                      Text(
                        'Or Sign in with',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Flexible(
                          child: Divider(
                        color: Colors.grey,
                        thickness: 0.4,
                        indent: 5,
                        endIndent: 20,
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1.5, color: Colors.grey),
                            borderRadius: BorderRadius.circular(100)),
                        child: IconButton(
                            onPressed: () {},
                            icon: const Image(
                                height: 30,
                                image: AssetImage('assets/google-logo.png'))),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1.5, color: Colors.grey),
                            borderRadius: BorderRadius.circular(100)),
                        child: IconButton(
                            onPressed: () {},
                            icon: const Image(
                                image: AssetImage('assets/facebook-logo.png'))),
                      )
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
