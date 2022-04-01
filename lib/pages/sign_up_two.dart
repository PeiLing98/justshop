import 'package:final_year_project/modals/alert_text_modal.dart';
import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/constant.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project/components/input_text_box.dart';

class SignUpTwo extends StatefulWidget {
  const SignUpTwo({Key? key}) : super(key: key);

  @override
  _SignUpTwoState createState() => _SignUpTwoState();
}

class _SignUpTwoState extends State<SignUpTwo> {
  String? chosenState = 'Perak';
  List<String> state = ['Perak', 'Selangor', 'Sarawak'];
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
            const StringInputTextBox(
              inputLabelText: 'Address 1',
            ),
            const StringInputTextBox(
              inputLabelText: 'Address 2',
            ),
            const StringInputTextBox(inputLabelText: 'Postcode'),
            const StringInputTextBox(inputLabelText: 'City'),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: SizedBox(
                width: 342,
                child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                            borderRadius: BorderRadius.zero),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                            borderRadius: BorderRadius.zero),
                        contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        labelStyle: primaryFontStyle),
                    value: chosenState,
                    onChanged: (item) => setState(() => chosenState = item),
                    items: state
                        .map((item) => DropdownMenuItem<String>(
                            value: item, child: Text(item)))
                        .toList()),
              ),
            ),
            const SizedBox(height: 20),
            BlackTextButton(
              buttonText: 'SIGN UP',
              onClick: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertTextModal(
                        alertContent:
                            'You have successfully signed up a JustShop account !',
                        onClick: () {
                          Navigator.pushNamed(context, '/login');
                        },
                      );
                    });
              },
            ),
            BlackTextButton(
              buttonText: 'BACK',
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
