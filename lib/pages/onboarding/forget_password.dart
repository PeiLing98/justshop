import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project/components/input_text_box.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String email = '';
  TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

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
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Image.asset(
                'assets/images/app_logo_large.png',
                height: 200,
                width: 200,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Column(
                children: const [
                  Text('Reset', style: landingLabelStyle),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Password', style: landingLabelStyle),
                ],
              ),
            ),
            Form(
              key: formKey,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                  child: StringInputTextBox(
                      inputLabelText: 'Enter your email',
                      onChanged: (val) {
                        email = val;
                      },
                      isPassword: false,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(emailReg).hasMatch(val)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      }),
                ),
              ]),
            ),
            const SizedBox(height: 25),
            BlackTextButton(
                buttonText: 'SEND REQUEST',
                onClick: () async {
                  if (formKey.currentState!.validate()) {
                    await _auth.resetPasswordWithEmail(email).then((value) {
                      Navigator.pushNamed(context, '/login');
                    });
                  }
                }),
            BlackTextButton(
              buttonText: 'BACK TO LOGIN PAGE',
              onClick: () {
                Navigator.pop(context);
              },
            ),
          ]),
        ),
      ))),
    );
  }
}
