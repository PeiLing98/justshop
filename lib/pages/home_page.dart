import 'package:final_year_project/components/top_app_bar.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/components/search_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Column(children: [
        const TopAppBar(),
        const SearchBar(),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 230,
          child: const Image(
            image: AssetImage('assets/images/home_page_poster.png'),
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [Text('Deals Near You', style: secondaryFontStyle)],
          ),
        )
      ]),
    );
  }
}
