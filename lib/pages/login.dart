import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/constant.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project/components/input_text_box.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                height: 200,
                width: 200,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Column(
                children: const [
                  Text('Welcome To', style: landingLabelStyle),
                  SizedBox(
                    height: 10,
                  ),
                  Text('JustShop', style: landingLabelStyle),
                ],
              ),
            ),
            const StringInputTextBox(inputLabelText: 'Username'),
            const StringInputTextBox(inputLabelText: 'Password'),
            Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  LinkButton(
                    buttonText: 'Forgot your password?',
                    onClick: () {
                      Navigator.pushNamed(context, '/forgetpassword');
                    },
                  ),
                ])),
            const SizedBox(height: 20),
            BlackTextButton(
              buttonText: 'LOG IN',
              onClick: () {
                Navigator.pushNamed(context, '/pagescontroller');
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Need a JustShop Account?'),
                  LinkButton(
                    buttonText: 'Sign up here',
                    onClick: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                  )
                ],
              ),
            )
          ]),
        ),
      ))),
    );
  }
}
