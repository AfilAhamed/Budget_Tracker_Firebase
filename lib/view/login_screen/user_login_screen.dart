import 'package:budget_tracker/controller/user_login_controller.dart';
import 'package:budget_tracker/view/signup_screen/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class UserLoginScreen extends StatelessWidget {
  const UserLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<UserLoginController>(context);
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login',
                  style: GoogleFonts.aDLaMDisplay(
                      fontSize: 40, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Please sign in to continue',
                  style: GoogleFonts.nunito(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: loginProvider.loginValidateEmail,
                    controller: loginProvider.emailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'E-Mail',
                        labelStyle: const TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black),
                        prefixIcon: const Icon(
                          Iconsax.direct_right,
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    validator: loginProvider.loginValidatePasswords,
                    controller: loginProvider.passwordController,
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Password',
                        labelStyle: const TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black),
                        prefixIcon: const Icon(Iconsax.password_check),
                        suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Iconsax.eye_slash))),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3)),
                              activeColor: Colors.blue.shade700,
                              value: true,
                              onChanged: (value) {}),
                          const Text(
                            'Remember',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Text('Forgot  Passwords?')),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13)),
                              backgroundColor: Colors.blue.shade700),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              loginProvider.login();
                              // loginProvider.emailController.clear();
                              // loginProvider.passwordController.clear();
                              // Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             const HomeScreen()));
                            }
                          },
                          child: Text(
                            'Sign in',
                            style: GoogleFonts.mali(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ))),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13)),
                              side: const BorderSide(color: Colors.grey),
                              backgroundColor: Colors.white),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()));
                          },
                          child: Text(
                            'Create Account',
                            style: GoogleFonts.mali(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ))),
                ],
              ),
            ),
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
          ]),
        ),
      ),
    );
  }
}
