import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/constant.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project/components/input_text_box.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          body: SafeArea(
              child: Center(
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Image.asset(
                'assets/images/app_logo_large.png',
                height: 140,
                width: 140,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text('Sign Up', style: landingLabelStyle),
            ),
            const StringInputTextBox(inputLabelText: 'Username'),
            const StringInputTextBox(inputLabelText: 'Email'),
            const StringInputTextBox(inputLabelText: 'Phone Number'),
            const StringInputTextBox(inputLabelText: 'Password'),
            const StringInputTextBox(inputLabelText: 'Confirm Password'),
            const SizedBox(height: 20),
            BlackTextButton(
              buttonText: 'NEXT',
              onClick: () {
                Navigator.pushNamed(context, '/signuptwo');
              },
            ),
            BlackTextButton(
                buttonText: 'BACK TO LOGIN PAGE',
                onClick: () {
                  Navigator.pushNamed(context, '/login');
                }),
          ]),
        ),
      ))),
    );
  }
}
