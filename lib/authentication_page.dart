import 'package:final_year_project/pages/onboarding/login.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  // void toggleView(){
  //   setState(() => showSignIn = !showSignIn);
  // }

  @override
  Widget build(BuildContext context) {
    // if (showSignIn) {
    //   return const Login(toggleView: toggleView);
    // } else {
    //   return const SignUpTwo(toggleView: toggleView);
    // }
    return const Login();
  }
}
