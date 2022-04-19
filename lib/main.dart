import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/pages/seller_profile/seller_profile.dart';
import 'package:final_year_project/pages/filter.dart';
import 'package:final_year_project/pages/onboarding/forget_password.dart';
import 'package:final_year_project/pages/home_page.dart';
import 'package:final_year_project/components/location_map.dart';
import 'package:final_year_project/pages/onboarding/login.dart';
import 'package:final_year_project/pages/profile.dart';
import 'package:final_year_project/pages/register_business.dart';
import 'package:final_year_project/pages/save_list.dart';
import 'package:final_year_project/pages/setup_store.dart';
import 'package:final_year_project/pages/onboarding/sign_up_two.dart';
import 'package:final_year_project/pages/seller_profile/update_seller_profile.dart';
import 'package:final_year_project/pages_controller.dart';
import 'package:final_year_project/services/auth.dart';
import 'package:final_year_project/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project/pages/onboarding/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(StreamProvider<MyUser?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        //initialRoute: '/login',
        routes: {
          '/signup': (context) => const SignUp(),
          '/signuptwo': (context) => const SignUpTwo(),
          '/login': (context) => const Login(),
          '/forgetpassword': (context) => const ForgetPassword(),
          '/homepage': (context) => const HomePage(),
          '/pagescontroller': (context) => const PagesController(),
          '/savelist': (context) => const SaveList(),
          '/filter': (context) => const Filter(),
          '/profile': (context) => const Profile(),
          '/locationmap': (context) => const LocationMap(),
          '/registerbusiness': (context) => const RegisterBusiness(),
          '/setupstore': (context) => const SetupStore(),
          '/sellerprofile': (context) => const SellerProfile(),
          '/updatesellerprofile': (context) => const UpdateSellerProfile(),
        },
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            fontFamily: 'Roboto',
            textTheme: const TextTheme(
              bodyText1: TextStyle(color: Colors.black),
            )),
        home: const Wrapper(),
      )));
}
