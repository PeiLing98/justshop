import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/components/input_text_box.dart';
import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: StreamBuilder<UserData>(
        stream: DatabaseService(uid: user?.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;

            return Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 40, child: TopAppBar()),
                    const Expanded(
                      flex: 1,
                      child: TitleAppBar(
                        title: "User Profile",
                        iconFlex: 3,
                        titleFlex: 5,
                        hasArrow: true,
                      ),
                    ),
                    Expanded(
                      flex: 12,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: const Icon(
                                          Icons.person_rounded,
                                          size: 30,
                                        )),
                                  ),
                                ]),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ProfileTextField(
                                    textFieldLabel: 'Username',
                                    textFieldValue: userData!.username,
                                    textFieldLine: 1,
                                    textFieldHeight: 30,
                                    isReadOnly: true,
                                    isBold: true,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ProfileTextField(
                                    textFieldLabel: 'Email',
                                    textFieldValue: userData.email,
                                    textFieldLine: 1,
                                    textFieldHeight: 30,
                                    isReadOnly: true,
                                    isBold: true,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ProfileTextField(
                                    textFieldLabel: 'Phone Number',
                                    textFieldValue: userData.phoneNumber,
                                    textFieldLine: 1,
                                    textFieldHeight: 30,
                                    isReadOnly: true,
                                    isBold: true,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ProfileTextField(
                                    textFieldLabel: 'Address',
                                    textFieldValue: userData.address,
                                    textFieldLine: 2,
                                    textFieldHeight: 50,
                                    isReadOnly: true,
                                    isBold: true,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ProfileTextField(
                                    textFieldLabel: 'Postcode',
                                    textFieldValue: userData.postcode,
                                    textFieldLine: 1,
                                    textFieldHeight: 30,
                                    isReadOnly: true,
                                    isBold: true,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: ProfileTextField(
                                    textFieldLabel: 'City',
                                    textFieldValue: userData.city,
                                    textFieldLine: 1,
                                    textFieldHeight: 30,
                                    isReadOnly: true,
                                    isBold: true,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ProfileTextField(
                                    textFieldLabel: 'State',
                                    textFieldValue: userData.state,
                                    textFieldLine: 1,
                                    textFieldHeight: 30,
                                    isReadOnly: true,
                                    isBold: true,
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 10),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: PurpleTextButton(
                                        onClick: () {
                                          Navigator.pushNamed(
                                              context, '/updateuserprofile');
                                        },
                                        buttonText: 'Update User Profile',
                                      ),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return const Loading();
          }
        },
      ),
    );
  }
}
