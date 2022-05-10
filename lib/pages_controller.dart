import 'package:final_year_project/constant.dart';
import 'package:final_year_project/pages/filter.dart';
import 'package:final_year_project/pages/homepage/home_page.dart';
import 'package:final_year_project/pages/profile/profile.dart';
import 'package:final_year_project/pages/ranking_blog.dart';
import 'package:final_year_project/pages/sign_up_store/register_business.dart';
import 'package:flutter/material.dart';

class PagesController extends StatefulWidget {
  const PagesController({Key? key}) : super(key: key);

  @override
  _PagesControllerState createState() => _PagesControllerState();
}

class _PagesControllerState extends State<PagesController> {
  int currentIndex = 0;
  final screens = const [
    HomePage(),
    Filter(),
    RegisterBusiness(),
    RankingBlog(),
    Profile()
  ];

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
          child: screens[currentIndex],
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    blurRadius: 10, color: Colors.grey, offset: Offset(2, 2))
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.grey[50],
                selectedItemColor: secondaryColor,
                unselectedItemColor: Colors.grey[700],
                selectedFontSize: 12,
                iconSize: 28,
                showUnselectedLabels: false,
                currentIndex: currentIndex,
                onTap: (index) => setState(() => currentIndex = index),
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.list), label: 'Filter'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.add_circle), label: 'Start Business'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.stacked_bar_chart), label: 'Rank'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.portrait), label: 'Profile')
                ]),
          ),
        ),
      ),
    );
  }
}
