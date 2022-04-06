import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project/components/input_text_box.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();
  final formKey = GlobalKey<FormState>();
  bool loading = false;

  String username = '';
  String email = '';
  String phoneNumber = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: loading
          ? const Loading()
          : Scaffold(
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
                  Form(
                      key: formKey,
                      child: Column(
                        children: [
                          StringInputTextBox(
                            inputLabelText: 'Username',
                            onChanged: (val) {
                              setState(() => username = val);
                            },
                            isPassword: false,
                          ),
                          StringInputTextBox(
                            inputLabelText: 'Email',
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                            isPassword: false,
                            validator: (val) =>
                                val!.isEmpty ? 'Enter an email' : null,
                          ),
                          StringInputTextBox(
                            inputLabelText: 'Phone Number',
                            onChanged: (val) {
                              setState(() => phoneNumber = val);
                            },
                            isPassword: false,
                          ),
                          StringInputTextBox(
                            inputLabelText: 'Password',
                            onChanged: (val) {
                              setState(() => password = val);
                            },
                            isPassword: false,
                            validator: (val) => val!.length < 6
                                ? 'Your password should be more than 6 characters'
                                : null,
                          ),
                          StringInputTextBox(
                            inputLabelText: 'Confirm Password',
                            onChanged: (val) {
                              setState(() => password = val);
                            },
                            isPassword: false,
                          ),
                        ],
                      )),
                  const SizedBox(height: 20),
                  BlackTextButton(
                    buttonText: 'NEXT',
                    onClick: () async {
                      // print(username);
                      // print(email);
                      // print(phoneNumber);
                      // print(password);
                      if (formKey.currentState!.validate()) {
                        dynamic result = await _auth
                            .registerWithEmailAndPassword(email, password);
                        setState(() => loading = true);
                        if (result == null) {
                          setState(() {
                            error = "Please provide valid email and password";
                            loading = false;
                          });
                        } else {
                          Navigator.pushNamed(context, '/signuptwo');
                        }
                      }
                    },
                  ),
                  BlackTextButton(
                      buttonText: 'BACK TO LOGIN PAGE',
                      onClick: () {
                        Navigator.pushNamed(context, '/login');
                      }),
                  Text(error)
                ]),
              ),
            ))),
    );
  }
}
