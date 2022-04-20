import 'package:final_year_project/constant.dart';
import 'package:flutter/material.dart';

class ListingTabBar extends StatefulWidget {
  final Widget foodBody;
  final Widget productBody;
  final Widget serviceBody;

  const ListingTabBar(
      {Key? key,
      required this.foodBody,
      required this.productBody,
      required this.serviceBody})
      : super(key: key);

  @override
  _ListingTabBarState createState() => _ListingTabBarState();
}

class _ListingTabBarState extends State<ListingTabBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            labelColor: Colors.black,
            labelStyle: boldContentTitle,
            unselectedLabelColor: Colors.grey,
            indicatorColor: secondaryColor,
            indicatorWeight: 3,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
            tabs: [
              Tab(
                text: 'FOOD',
                height: 30,
              ),
              Tab(
                text: 'PRODUCT',
                height: 30,
              ),
              Tab(
                text: 'SERVICE',
                height: 30,
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: TabBarView(children: [
                widget.foodBody,
                widget.productBody,
                widget.serviceBody
              ]),
            ),
          )
        ],
      ),
    );
  }
}
