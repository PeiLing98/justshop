import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/modals/alert_text_modal.dart';
import 'package:final_year_project/pages/onboarding/sign_up_two.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project/components/input_text_box.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                  child: SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Image.asset(
                    'assets/images/app_logo_large.png',
                    height: 120,
                    width: 120,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Text('Sign Up', style: landingLabelStyle),
                ),
                SizedBox(
                  height: 320,
                  child: SingleChildScrollView(
                    child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(35, 0, 35, 5),
                              child: StringInputTextBox(
                                inputLabelText: 'Username',
                                onChanged: (val) {
                                  setState(() => username = val);
                                },
                                isPassword: false,
                                validator: (val) =>
                                    val!.isEmpty ? 'Enter an username' : null,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(35, 0, 35, 5),
                              child: StringInputTextBox(
                                  inputLabelText: 'Email',
                                  onChanged: (val) {
                                    setState(() => email = val);
                                  },
                                  isPassword: false,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Enter an email';
                                    }

                                    if (!RegExp(emailReg).hasMatch(val)) {
                                      return 'Please enter a valid email';
                                    }
                                    return null;
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(35, 0, 35, 5),
                              child: StringInputTextBox(
                                  inputLabelText: 'Phone Number',
                                  onChanged: (val) {
                                    setState(() => phoneNumber = val);
                                  },
                                  isPassword: false,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Enter a phone number';
                                    }

                                    if (!RegExp(phoneNumberPattern)
                                        .hasMatch(val)) {
                                      return 'Please enter a valid phone number';
                                    }

                                    return null;
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(35, 0, 35, 5),
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
                              padding: const EdgeInsets.fromLTRB(35, 0, 35, 5),
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
                BlackTextButton(
                    buttonText: 'NEXT',
                    onClick: () async {
                      if (formKey.currentState!.validate()) {
                        bool emailInUse = await checkIfEmailInUse(email);
                        if (emailInUse == true) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertTextModal(
                                  alertContent:
                                      'This email has been registered! Please try with other email!',
                                  onClick: () {
                                    Navigator.pop(context);
                                  },
                                );
                              });
                          loading = false;
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpTwo(
                                        username: username,
                                        email: email,
                                        phoneNumber: phoneNumber,
                                        password: password,
                                      )));
                        }
                      }
                    }),
                BlackTextButton(
                    buttonText: 'BACK TO LOGIN PAGE',
                    onClick: () {
                      Navigator.pushNamed(context, '/login');
                    }),
                Text(
                  error,
                  style: errorMessageStyle,
                )
              ]),
            ))),
    );
  }

  Future<bool> checkIfEmailInUse(String email) async {
    try {
      final list =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

      if (list.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error.toString());
      return true;
    }
  }
}
