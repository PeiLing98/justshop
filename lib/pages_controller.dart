import 'package:final_year_project/constant.dart';
import 'package:final_year_project/pages/home_page.dart';
import 'package:final_year_project/pages/profile.dart';
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
    Center(child: Text('Filter')),
    Center(child: Text('Start Business')),
    Center(child: Text('Rank')),
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
            child: SingleChildScrollView(
          child: screens[currentIndex],
        )),
        bottomNavigationBar: BottomNavigationBar(
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
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Filter'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle), label: 'Start Business'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.stacked_bar_chart), label: 'Rank'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.portrait), label: 'Profile')
            ]),
      ),
    );
  }
}
