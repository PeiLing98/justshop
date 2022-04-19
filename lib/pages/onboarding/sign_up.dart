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
  String confirmPassword = '';
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
                  SizedBox(
                    height: 290,
                    child: SingleChildScrollView(
                      child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(35, 0, 35, 5),
                                child: StringInputTextBox(
                                  inputLabelText: 'Username',
                                  onChanged: (val) {
                                    setState(() => username = val);
                                  },
                                  isPassword: false,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(35, 0, 35, 5),
                                child: StringInputTextBox(
                                  inputLabelText: 'Email',
                                  onChanged: (val) {
                                    setState(() => email = val);
                                  },
                                  isPassword: false,
                                  validator: (val) =>
                                      val!.isEmpty ? 'Enter an email' : null,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(35, 0, 35, 5),
                                child: StringInputTextBox(
                                  inputLabelText: 'Phone Number',
                                  onChanged: (val) {
                                    setState(() => phoneNumber = val);
                                  },
                                  isPassword: false,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(35, 0, 35, 5),
                                child: StringInputTextBox(
                                    inputLabelText: 'Password',
                                    onChanged: (val) {
                                      setState(() => password = val);
                                    },
                                    isPassword: true,
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                      if (val.length < 6) {
                                        return 'Your password should be at least 6 characters';
                                      }
                                      return null;
                                    }),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(35, 0, 35, 5),
                                child: StringInputTextBox(
                                    inputLabelText: 'Confirm Password',
                                    onChanged: (val) {
                                      setState(() => confirmPassword = val);
                                    },
                                    isPassword: true,
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return 'Please enter your confirm password';
                                      }
                                      if (val.length < 6) {
                                        return 'Your confirm password should be at least 6 characters';
                                      }
                                      if (val != password) {
                                        return 'Your password does not match';
                                      }
                                      return null;
                                    }),
                              ),
                            ],
                          )),
                    ),
                  ),
                  const SizedBox(height: 10),
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
