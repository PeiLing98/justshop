import 'package:final_year_project/authentication_page.dart';
import 'package:final_year_project/models/user.dart';
import 'package:final_year_project/pages_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //accessing myuser data from provider
    final user = Provider.of<MyUser?>(context);

    // return either AUthenticate(Login) or PagesController(HomePage)
    if (user == null) {
      return const Authenticate();
    } else {
      return const PagesController();
    }
  }
}
