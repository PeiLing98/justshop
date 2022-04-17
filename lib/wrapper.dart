import 'package:final_year_project/authentication_page.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/pages_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    //accessing myuser data from provider
    final user = Provider.of<MyUser?>(context);

    // return either AUthenticate(Login) or PagesController(HomePage)
    if (user == null) {
      //print('user is null');
      return const Authenticate();
    } else {
      //print('user is not null');
      return const PagesController();
    }
  }
}
