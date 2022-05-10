import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/modals/alert_text_modal.dart';
import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project/components/input_text_box.dart';

class SignUpTwo extends StatefulWidget {
  final String username;
  final String email;
  final String phoneNumber;
  final String password;
  const SignUpTwo(
      {Key? key,
      required this.username,
      required this.email,
      required this.phoneNumber,
      required this.password})
      : super(key: key);

  @override
  _SignUpTwoState createState() => _SignUpTwoState();
}

class _SignUpTwoState extends State<SignUpTwo> {
  final AuthService _auth = AuthService();
  final formKey = GlobalKey<FormState>();
  bool loading = false;

  String chosenState = 'Perak';
  List<String> state = [
    'Johor',
    'Kedah',
    'Kelantan',
    'Melaka',
    'Negeri Sembilan',
    'Pahang',
    'Penang',
    'Perak',
    'Perlis',
    'Sabah',
    'Sarawak',
    'Selangor',
    'Terengganu',
    'Wilayah Persekutuan Kuala Lumpur',
    'Labuan',
    'Putrajaya'
  ];
  String address = '';
  String postcode = '';
  String city = '';

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
                  height: 280,
                  child: SingleChildScrollView(
                    child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(35, 0, 35, 5),
                              child: StringInputTextBox(
                                inputLabelText: 'Address',
                                onChanged: (val) {
                                  setState(() {
                                    address = val;
                                  });
                                },
                                isPassword: false,
                                validator: (val) =>
                                    val!.isEmpty ? 'Enter your address' : null,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(35, 0, 35, 5),
                              child: StringInputTextBox(
                                  inputLabelText: 'Postcode',
                                  onChanged: (val) {
                                    setState(() => postcode = val);
                                  },
                                  isPassword: false,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Enter your address postcode';
                                    }

                                    if (val.length > 5) {
                                      return 'Please enter a valid postcode';
                                    }
                                    return null;
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(35, 0, 35, 5),
                              child: StringInputTextBox(
                                inputLabelText: 'City',
                                onChanged: (val) {
                                  setState(() => city = val);
                                },
                                isPassword: false,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(35, 0, 35, 5),
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
                                        contentPadding:
                                            EdgeInsets.fromLTRB(20, 0, 20, 0),
                                        labelStyle: primaryFontStyle),
                                    value: chosenState,
                                    onChanged: (item) =>
                                        setState(() => chosenState = item!),
                                    items: state
                                        .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: primaryFontStyle,
                                            )))
                                        .toList()),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
                BlackTextButton(
                  buttonText: 'SIGN UP',
                  onClick: () async {
                    if (formKey.currentState!.validate()) {
                      dynamic result = await _auth.registerWithEmailAndPassword(
                          widget.email,
                          widget.password,
                          widget.username,
                          widget.phoneNumber,
                          address,
                          postcode,
                          city,
                          chosenState);

                      setState(() => loading = true);
                      if (result == null) {
                        setState(() {
                          loading = false;
                        });
                      } else {
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
                        loading = false;
                      }
                    }
                  },
                ),
                BlackTextButton(
                  buttonText: 'BACK',
                  onClick: () {
                    Navigator.pop(context);
                  },
                ),
              ]),
            ))),
    );
  }
}
