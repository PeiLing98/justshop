import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/modals/alert_text_modal.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/pages/sign_up_store/register_business.dart';
import 'package:final_year_project/services/auth.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user?.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;

            return Container(
              margin: const EdgeInsets.all(5),
              child: Column(
                children: [
                  const TopAppBar(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.person_rounded,
                                  size: 50,
                                ),
                                Text(
                                  'Hi, ${userData!.username} !',
                                  // '123',
                                  style: secondaryFontStyle,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
                    child: SizedBox(
                      height: 390,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'PERSONAL',
                            style: buttonLabelStyle,
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 0.5,
                          ),
                          ProfileButton(
                              buttonText: 'User Profile',
                              onClick: () {
                                Navigator.pushNamed(context, '/userprofile');
                              }),
                          ProfileButton(
                              buttonText: 'Order',
                              onClick: () {
                                Navigator.pushNamed(context, '/userorder');
                              }),
                          const SizedBox(
                            height: 30,
                          ),
                          StreamBuilder<UserStoreData>(
                            stream:
                                DatabaseService(uid: user?.uid).userStoreData,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'BUSINESS ( FOR SELLER ONLY )',
                                      style: buttonLabelStyle,
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                      thickness: 0.5,
                                    ),
                                    ProfileButton(
                                        buttonText: 'Manage Business Profile',
                                        onClick: () {
                                          Navigator.pushNamed(
                                              context, '/sellerprofile');
                                        }),
                                    ProfileButton(
                                        buttonText: 'View Store',
                                        onClick: () {
                                          Navigator.pushNamed(
                                              context, '/viewstore');
                                        }),
                                    ProfileButton(
                                        buttonText: 'Manage Listing',
                                        onClick: () {
                                          Navigator.pushNamed(
                                              context, '/managelisting');
                                        }),
                                    ProfileButton(
                                        buttonText: 'Business Order',
                                        onClick: () {
                                          Navigator.pushNamed(
                                              context, '/businessorder');
                                        }),
                                  ],
                                );
                              } else {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Are you a seller? Join us to be part of JustShop!',
                                          style: boldContentTitle,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 250,
                                          child: PurpleTextButton(
                                            buttonText:
                                                'Click here to register your business',
                                            onClick: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return YesNoAlertModal(
                                                        alertContent:
                                                            'Are you ready to register business in JustShop?',
                                                        closeOnClick: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        yesOnClick: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const RegisterBusiness()));
                                                        },
                                                        noOnClick: () {
                                                          Navigator.pop(
                                                              context);
                                                        });
                                                  });
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: WhiteTextButton(
                        buttonText: 'LOG OUT',
                        onClick: () async {
                          await _auth.signOut();

                          //Navigator.pushNamed(context, '/login');
                        }),
                  )
                ],
              ),
            );
          } else {
            return const Loading();
          }
        });
  }
}
