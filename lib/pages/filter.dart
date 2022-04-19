import 'dart:ffi';

import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/constant.dart';
import 'package:flutter/material.dart';

class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  RangeValues _currentRangeValues = const RangeValues(10, 100);
  var options = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Expanded(flex: 1, child: TopAppBar()),
          const Expanded(
              flex: 1,
              child: TitleAppBar(
                title: 'Filter',
                iconFlex: 3,
                titleFlex: 4,
              )),
          Expanded(
            flex: 12,
            child: ListView(
              children: [
                const FilterTitleAppBar(title: 'CATEGORY'),
                SizedBox(
                  height: 150,
                  child: DefaultTabController(
                    length: 3,
                    child: Column(
                      children: const [
                        TabBar(
                          labelColor: Colors.black,
                          labelStyle: boldContentTitle,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: secondaryColor,
                          indicatorWeight: 3,
                          indicatorPadding:
                              EdgeInsets.symmetric(horizontal: 20),
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
                          child: TabBarView(children: [
                            Text('food'),
                            Text('product'),
                            Text('service'),
                          ]),
                        )
                      ],
                    ),
                  ),
                ),
                const FilterTitleAppBar(title: 'PRICE RANGE (RM)'),
                SizedBox(
                  height: 80,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'RM ${_currentRangeValues.start.round().toString()}',
                                style: primaryFontStyle,
                              ),
                              Text(
                                'RM ${_currentRangeValues.end.round().toString()}',
                                style: primaryFontStyle,
                              ),
                            ]),
                      ),
                      RangeSlider(
                        values: _currentRangeValues,
                        min: 1,
                        max: 1000,
                        divisions: 1000,
                        activeColor: secondaryColor,
                        labels: RangeLabels(
                          _currentRangeValues.start.round().toString(),
                          _currentRangeValues.end.round().toString(),
                        ),
                        onChanged: (RangeValues val) => setState(() {
                          _currentRangeValues = val;
                        }),
                      ),
                    ],
                  ),
                ),
                const FilterTitleAppBar(title: 'RATING'),
                const SizedBox(
                  height: 100,
                ),
                const FilterTitleAppBar(title: 'LOCATION'),
                SizedBox(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                      child: MapButton(title: 'SEARCH BY LOCATION')),
                ),
                const FilterTitleAppBar(title: 'SORT BY'),
                const SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
