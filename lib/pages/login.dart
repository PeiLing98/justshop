import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project/components/input_text_box.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  final formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
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
                        Text('Welcome To', style: landingLabelStyle),
                        SizedBox(
                          height: 10,
                        ),
                        Text('JustShop', style: landingLabelStyle),
                      ],
                    ),
                  ),
                  Form(
                      key: formKey,
                      child: Column(
                        children: [
                          StringInputTextBox(
                              inputLabelText: 'Email',
                              onChanged: (val) {
                                setState(() => email = val);
                              },
                              isPassword: false,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Please enter your registered email';
                                }
                                if (!RegExp(emailReg).hasMatch(val)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              }),
                          StringInputTextBox(
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
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            LinkButton(
                              buttonText: 'Forgot your password?',
                              onClick: () {
                                Navigator.pushNamed(context, '/forgetpassword');
                              },
                            ),
                          ])),
                  const SizedBox(height: 10),
                  BlackTextButton(
                    buttonText: 'LOG IN',
                    onClick: () async {
                      // dynamic result = await _auth.signInAnon();
                      // if (result == null) {
                      //   print('error signing in');
                      // } else {
                      //   print('signed in');
                      //   print(result.uid);
                      // }
                      // print(email);
                      // print(password);
                      if (formKey.currentState!.validate()) {
                        dynamic result = await _auth.loginWithEmailAndPassword(
                            email, password);
                        setState(() => loading = true);
                        if (result == null) {
                          setState(() {
                            error =
                                'Invalid credentials. Please sign up a JustShop account.';
                            loading = false;
                          });
                        } else {
                          Navigator.pushNamed(context, '/pagescontroller');
                        }
                      }
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
                  ),
                  Text(
                    error,
                    style: errorMessageStyle,
                  )
                ]),
              ),
            ))),
    );
  }
}
