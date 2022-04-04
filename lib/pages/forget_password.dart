import 'package:final_year_project/modals/alert_text_modal.dart';
import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/constant.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project/components/input_text_box.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String newPassword = '';
  final formKey = GlobalKey<FormState>();

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
                StringInputTextBox(
                  inputLabelText: 'New Password',
                  onChanged: (val) {
                    newPassword = val;
                  },
                  isPassword: false,
                ),
                StringInputTextBox(
                  inputLabelText: 'Confirm New Password',
                  onChanged: (val) {
                    newPassword = val;
                  },
                  isPassword: false,
                ),
              ]),
            ),
            const SizedBox(height: 25),
            BlackTextButton(
              buttonText: 'CONFIRM',
              onClick: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertTextModal(
                        alertContent:
                            'You have successfully reset your password !',
                        onClick: () {
                          Navigator.pushNamed(context, '/login');
                        },
                      );
                    });
              },
            ),
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
