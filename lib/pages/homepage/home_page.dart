import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/components/search_bar.dart';
import 'package:final_year_project/models/list_model.dart';
import 'package:final_year_project/pages/homepage/store_listing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_year_project/services/database.dart';
import 'package:final_year_project/pages/listing.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<ItemList>?>.value(
      value: DatabaseService(uid: '').listings,
      initialData: null,
      child: Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          children: [
            const TopAppBar(),
            const SearchBar(),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(shrinkWrap: true, children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 230,
                  child: const Image(
                    image: AssetImage('assets/images/home_page_poster.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text('Deals Near You', style: secondaryFontStyle)
                    ],
                  ),
                ),
                const SizedBox(
                    height: 100,
                    child: Listing(scrollDirection: Axis.horizontal)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text('Recommend for you', style: secondaryFontStyle)
                    ],
                  ),
                ),
                const SizedBox(
                    height: 100,
                    child: Listing(scrollDirection: Axis.horizontal)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text('All Stores', style: secondaryFontStyle)
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: SizedBox(height: 500, child: StoreListing()),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
