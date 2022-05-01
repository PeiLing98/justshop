import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/components/location_map.dart';
import 'package:final_year_project/components/tab_bar.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/models/category_model.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  bool isFoodCategory = false;
  bool isProductCategory = false;
  bool isServiceCategory = false;
  bool isPriceRange = false;
  bool isRate = false;
  bool isLocation = false;
  bool isPopular = false;

  RangeValues _currentRangeValues = const RangeValues(10, 100);
  int lowPriceRange = 10;
  int highPriceRange = 100;
  int currentRank = 5;
  var rateList = [1, 2, 3, 4, 5];

  final category = Category();
  String selectedCategory = '';
  String selectedSubCategory = '';
  String savedAddress = '';
  String savedLatitude = '';
  String savedLongtitude = '';

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<MyUser>(context).uid;
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
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
              child: Row(children: [
                Expanded(
                  flex: 12,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        if (isFoodCategory ||
                            isProductCategory ||
                            isServiceCategory)
                          SelectedFilterOption(buttonText: selectedCategory),
                        if (isFoodCategory ||
                            isProductCategory ||
                            isServiceCategory)
                          SelectedFilterOption(buttonText: selectedSubCategory),
                        if (isPriceRange)
                          SelectedFilterOption(
                              buttonText:
                                  'RM$lowPriceRange - RM$highPriceRange'),
                        if (isRate)
                          SelectedFilterOption(
                              buttonText: '$currentRank Stars'),
                        if (isLocation)
                          SelectedFilterOption(buttonText: savedAddress),
                        if (isPopular)
                          const SelectedFilterOption(
                              buttonText: 'Sorted by popularity'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: PurpleTextButton(
                      buttonText: 'Filter',
                      onClick: () async {
                        await DatabaseService(uid: userId).updateFilterData(
                            selectedCategory,
                            selectedSubCategory,
                            lowPriceRange,
                            highPriceRange,
                            currentRank,
                            savedAddress,
                            savedLatitude,
                            savedLongtitude,
                            isPopular);
                      }),
                )
              ]),
            ),
          ),
          Expanded(
            flex: 12,
            child: ListView(
              children: [
                const FilterTitleAppBar(title: 'CATEGORY'),
                SizedBox(
                  height: 150,
                  child: ListingTabBar(
                    foodBody: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: category.subCategory[0].length,
                      itemBuilder: (context, index) {
                        return ImageButton(
                          categoryLabel:
                              category.subCategory[0][index].toString(),
                          imageLink: AssetImage(
                              category.categoryImage[0][index].toString()),
                          onTap: () {
                            setState(() {
                              isFoodCategory = true;
                              selectedCategory = category.category[0];
                              selectedSubCategory =
                                  category.subCategory[0][index].toString();
                            });
                          },
                        );
                      },
                    ),
                    productBody: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: category.subCategory[1].length,
                      itemBuilder: (context, index) {
                        return ImageButton(
                          categoryLabel:
                              category.subCategory[1][index].toString(),
                          imageLink: AssetImage(
                              category.categoryImage[1][index].toString()),
                          onTap: () {
                            isProductCategory = true;
                            selectedCategory = category.category[1];
                            selectedSubCategory =
                                category.subCategory[1][index].toString();
                          },
                        );
                      },
                    ),
                    serviceBody: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: category.subCategory[2].length,
                      itemBuilder: (context, index) {
                        return ImageButton(
                          categoryLabel:
                              category.subCategory[2][index].toString(),
                          imageLink: AssetImage(
                              category.categoryImage[2][index].toString()),
                          onTap: () {
                            isProductCategory = true;
                            selectedCategory = category.category[2];
                            selectedSubCategory =
                                category.subCategory[2][index].toString();
                          },
                        );
                      },
                    ),
                  ),
                ),
                const FilterTitleAppBar(title: 'PRICE RANGE (RM)'),
                SizedBox(
                  height: 70,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'RM ${_currentRangeValues.start.round().toString()}',
                                style: ratingLabelStyle,
                              ),
                              Text(
                                'RM ${_currentRangeValues.end.round().toString()}',
                                style: ratingLabelStyle,
                              ),
                            ]),
                      ),
                      SizedBox(
                        height: 40,
                        child: RangeSlider(
                          values: _currentRangeValues,
                          min: 1,
                          max: 1000,
                          divisions: 100,
                          activeColor: secondaryColor,
                          labels: RangeLabels(
                            _currentRangeValues.start.round().toString(),
                            _currentRangeValues.end.round().toString(),
                          ),
                          onChanged: (RangeValues val) => setState(() {
                            isPriceRange = true;
                            _currentRangeValues = val;
                            lowPriceRange =
                                _currentRangeValues.start.round().toInt();
                            highPriceRange =
                                _currentRangeValues.end.round().toInt();
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                const FilterTitleAppBar(title: 'RATING'),
                SizedBox(
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                isRate = true;
                                currentRank = rateList[index];
                              });
                            },
                            child: SizedBox(
                              width: 76,
                              child: FilterOptionButton(
                                buttonText: '${index + 1} Stars',
                              ),
                            ),
                          );
                        },
                      ),
                    )),
                const FilterTitleAppBar(title: 'LOCATION'),
                SizedBox(
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: TextButton(
                          child: const Text(
                            'SEARCH BY LOCATION',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            overlayColor: MaterialStateProperty.all<Color>(
                                secondaryColor),
                            elevation: MaterialStateProperty.all<double>(1.0),
                            side: MaterialStateProperty.all<BorderSide>(
                                const BorderSide(
                                    width: 1.0, color: Colors.grey)),
                          ),
                          onPressed: () {
                            _awaitReturnValueFromLocationMap(context);
                          },
                        ))),
                const FilterTitleAppBar(title: 'SORT BY'),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 280, 10),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isPopular = !isPopular;
                        });
                      },
                      child: const FilterOptionButton(
                        buttonText: 'Popularity',
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _awaitReturnValueFromLocationMap(BuildContext context) async {
    // start the GoogleMap and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LocationMap(),
        ));

    // after the map result comes back update the Text widget with it
    setState(() {
      savedAddress = result[0];
      savedLatitude = result[1];
      savedLongtitude = result[2];
      isLocation = true;
    });
  }
}
