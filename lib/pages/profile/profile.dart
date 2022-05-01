import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/services/auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
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
                      children: const [
                        Icon(
                          Icons.person_rounded,
                          size: 50,
                        ),
                        Text(
                          "Profile",
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
                  ProfileButton(buttonText: 'User Profile', onClick: () {}),
                  ProfileButton(buttonText: 'Order', onClick: () {}),
                  const SizedBox(
                    height: 30,
                  ),
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
                        Navigator.pushNamed(context, '/sellerprofile');
                      }),
                  ProfileButton(buttonText: 'View Store', onClick: () {}),
                  ProfileButton(
                      buttonText: 'Manage Listing',
                      onClick: () {
                        Navigator.pushNamed(context, '/listingsetting');
                      }),
                  ProfileButton(buttonText: 'Business Order', onClick: () {}),
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
                }),
          )
        ],
      ),
    );
  }
}
