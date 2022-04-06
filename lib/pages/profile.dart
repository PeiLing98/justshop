import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/components/top_app_bar.dart';
import 'package:final_year_project/pages/listing_setting.dart';
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
          const Expanded(flex: 2, child: ListingSetting()),
          WhiteTextButton(
              buttonText: 'LOG OUT',
              onClick: () async {
                await _auth.signOut();
                //Navigator.pushNamed(context, '/login');
              })
        ],
      ),
    );
  }
}
