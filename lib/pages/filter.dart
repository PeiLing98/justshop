import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/components/tab_bar.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/models/category_model.dart';
import 'package:flutter/material.dart';

class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  RangeValues _currentRangeValues = const RangeValues(10, 100);
  int currentRank = 5;
  var rateList = [1, 2, 3, 4, 5];
  bool isPopular = false;

  final category = Category();
  String selectedCategory = '';
  String selectedSubCategory = '';

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
                        FilterOptionButton(buttonText: selectedCategory),
                        FilterOptionButton(buttonText: selectedSubCategory),
                        FilterOptionButton(
                            buttonText:
                                'RM${_currentRangeValues.start.round().toString()} - RM${_currentRangeValues.end.round().toString()}'),
                        FilterOptionButton(buttonText: '$currentRank Stars'),
                        if (isPopular)
                          const FilterOptionButton(
                              buttonText: 'Sorted by popularity'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: PurpleTextButton(buttonText: 'Filter', onClick: () {}),
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
                            _currentRangeValues = val;
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
                      child: MapButton(title: 'SEARCH BY LOCATION')),
                ),
                const FilterTitleAppBar(title: 'SORT BY'),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 280, 10),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isPopular = !isPopular;
                          print(isPopular);
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
}
