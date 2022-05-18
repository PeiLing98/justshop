import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/pages/cart_page.dart';
import 'package:final_year_project/pages/profile/manage_listing/manage_listing.dart';
import 'package:final_year_project/pages/profile/seller_profile/seller_profile.dart';
import 'package:final_year_project/pages/filter/filter.dart';
import 'package:final_year_project/pages/onboarding/forget_password.dart';
import 'package:final_year_project/pages/homepage/home_page.dart';
import 'package:final_year_project/components/location_map.dart';
import 'package:final_year_project/pages/onboarding/login.dart';
import 'package:final_year_project/pages/profile/profile.dart';
import 'package:final_year_project/pages/profile/user_profile/update_user_profile.dart';
import 'package:final_year_project/pages/profile/user_profile/user_profile.dart';
import 'package:final_year_project/pages/profile/view_store.dart';
import 'package:final_year_project/pages/sign_up_store/register_business.dart';
import 'package:final_year_project/pages/save_list.dart';
import 'package:final_year_project/pages/profile/seller_profile/update_seller_profile.dart';
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
          '/login': (context) => const Login(),
          '/forgetpassword': (context) => const ForgetPassword(),
          '/homepage': (context) => const HomePage(),
          '/pagescontroller': (context) => const PagesController(),
          '/savelist': (context) => const SaveList(),
          '/filter': (context) => const Filter(),
          '/profile': (context) => const Profile(),
          '/locationmap': (context) => const LocationMap(),
          '/registerbusiness': (context) => const RegisterBusiness(),
          '/sellerprofile': (context) => const SellerProfile(),
          '/updatesellerprofile': (context) => const UpdateSellerProfile(),
          '/managelisting': (context) => const ManageListing(),
          '/viewstore': (context) => const ViewStore(),
          '/cartpage': (context) => const CartPage(),
          '/userprofile': (context) => const UserProfile(),
          '/updateuserprofile': (context) => const UpdateUserProfile(),
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
