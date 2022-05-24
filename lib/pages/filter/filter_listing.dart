import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/components/search_bar.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/models/listing_model.dart';
import 'package:final_year_project/pages/homepage/listing_detail.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FilterListing extends StatefulWidget {
  final String selectedCategory;
  final String selectedSubCategory;

  const FilterListing({
    Key? key,
    required this.selectedCategory,
    required this.selectedSubCategory,
  }) : super(key: key);

  @override
  _FilterListingState createState() => _FilterListingState();
}

class _FilterListingState extends State<FilterListing> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  RangeValues _currentRangeValues = const RangeValues(10, 100);
  var rateList = [1, 2, 3, 4, 5];

  bool isPriceRange = false;
  bool isRate = false;
  bool isPopular = false;

  int lowPriceRange = 0;
  int highPriceRange = 0;
  int currentRank = 0;

  int minPrice = 0;
  int maxPrice = 0;
  int rating = 0;
  bool sortedByPopularity = false;

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
        key: _scaffoldKey,
        endDrawer: SafeArea(
            child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: 280,
          child: Drawer(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Icon(Icons.filter_alt, size: 15),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Filter Options',
                            style: boldContentTitle,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 560,
                      child: ListView(children: [
                        const FilterTitleAppBar(title: 'PRICE RANGE (RM)'),
                        SizedBox(
                          height: 80,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(18, 10, 18, 0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                  divisions: 1000,
                                  activeColor: secondaryColor,
                                  labels: RangeLabels(
                                    _currentRangeValues.start
                                        .round()
                                        .toString(),
                                    _currentRangeValues.end.round().toString(),
                                  ),
                                  onChanged: (RangeValues val) => setState(() {
                                    isPriceRange = true;
                                    _currentRangeValues = val;
                                    lowPriceRange = _currentRangeValues.start
                                        .round()
                                        .toInt();
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
                            height: 70,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
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
                        const FilterTitleAppBar(title: 'SORT BY'),
                        SizedBox(
                          height: 70,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isPopular = true;
                                });
                              },
                              child: const FilterOptionButton(
                                buttonText: 'Popularity',
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          child: Text(
                            'Selected:',
                            style: boldContentTitle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 0),
                          child: SizedBox(
                            height: 30,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                if (isPriceRange)
                                  SelectedFilterOption(
                                    buttonText:
                                        'RM$lowPriceRange - RM$highPriceRange',
                                    isClose: true,
                                    closeButtonAction: () {
                                      setState(() {
                                        isPriceRange = false;
                                        _currentRangeValues =
                                            const RangeValues(10, 100);
                                        lowPriceRange = 0;
                                        highPriceRange = 0;
                                      });
                                    },
                                  ),
                                if (isRate)
                                  SelectedFilterOption(
                                    buttonText: '$currentRank Stars',
                                    isClose: true,
                                    closeButtonAction: () {
                                      setState(() {
                                        isRate = false;
                                        currentRank = 0;
                                      });
                                    },
                                  ),
                                if (isPopular)
                                  SelectedFilterOption(
                                      buttonText: 'Sorted by popularity',
                                      isClose: true,
                                      closeButtonAction: () {
                                        setState(() {
                                          isPopular = false;
                                        });
                                      }),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 130,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 80,
                                height: 30,
                                child: PurpleTextButton(
                                    buttonText: 'Filter',
                                    onClick: () {
                                      setState(() {
                                        minPrice = lowPriceRange;
                                        maxPrice = highPriceRange;
                                        rating = currentRank;
                                        sortedByPopularity = isPopular;
                                        Navigator.pop(context);
                                      });
                                    }),
                              )
                            ],
                          ),
                        )
                      ]),
                    ),
                  ]),
            ),
          ),
        )),
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40, child: TopAppBar()),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: IconButton(
                            padding: const EdgeInsets.all(0),
                            alignment: Alignment.centerLeft,
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              size: 20,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )),
                      const Expanded(flex: 9, child: SearchBar())
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 12,
                                child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      if (widget.selectedCategory != "")
                                        SelectedFilterOption(
                                            buttonText:
                                                widget.selectedCategory),
                                      if (widget.selectedSubCategory != "")
                                        SelectedFilterOption(
                                            buttonText:
                                                widget.selectedSubCategory),
                                      if (minPrice != 0 && maxPrice != 0)
                                        SelectedFilterOption(
                                            buttonText:
                                                'RM$minPrice - RM$maxPrice'),
                                      if (rating != 0)
                                        SelectedFilterOption(
                                            buttonText: '$rating Stars'),
                                      if (sortedByPopularity == true)
                                        const SelectedFilterOption(
                                          buttonText: 'Sorted by popularity',
                                        ),
                                    ])),
                            Expanded(
                                flex: 2,
                                child: IconButton(
                                    padding: const EdgeInsets.all(0),
                                    alignment: Alignment.topRight,
                                    onPressed: () {
                                      _scaffoldKey.currentState
                                          ?.openEndDrawer();
                                    },
                                    icon: const Icon(
                                      Icons.filter_list,
                                      size: 25,
                                    )))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      StreamBuilder<List<Listing>>(
                          stream: DatabaseService(uid: "").item,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<Listing>? item = snapshot.data;
                              List<Listing>? matchedItem = [];

                              if (widget.selectedCategory == "" &&
                                  widget.selectedSubCategory == "") {
                                matchedItem = item;
                                if (minPrice != 0 ||
                                    maxPrice != 0 ||
                                    rating != 0 ||
                                    sortedByPopularity) {
                                  if (minPrice != 0 && maxPrice != 0) {
                                    matchedItem = matchedItem?.where((item) {
                                      return (int.parse(item.price) >=
                                              minPrice &&
                                          int.parse(item.price) <= maxPrice);
                                    }).toList();
                                  }
                                }
                              } else {
                                matchedItem = item?.where((item) {
                                  return item.selectedCategory ==
                                          widget.selectedCategory &&
                                      item.selectedSubCategory ==
                                          widget.selectedSubCategory;
                                }).toList();
                                if (minPrice != 0 && maxPrice != 0) {
                                  matchedItem = matchedItem?.where((item) {
                                    return (int.parse(item.price) >= minPrice &&
                                        int.parse(item.price) <= maxPrice);
                                  }).toList();
                                }
                              }

                              if (matchedItem!.isEmpty) {
                                return const SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      'No matched result is found.',
                                      style: ratingLabelStyle,
                                    ),
                                  ),
                                );
                              } else {
                                return SingleChildScrollView(
                                  child: SizedBox(
                                    height: 500,
                                    child: GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 5,
                                          crossAxisSpacing: 5,
                                        ),
                                        itemCount: matchedItem.length,
                                        itemBuilder: (context, index) {
                                          return SizedBox(
                                              height: 100,
                                              child: Card(
                                                  elevation: 5,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                ListingDetail(
                                                              listing:
                                                                  matchedItem![
                                                                      index],
                                                            ),
                                                          ));
                                                    },
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                height: 80,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            5),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            5),
                                                                  ),
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          250,
                                                                          129,
                                                                          89,
                                                                          89),
                                                                ),
                                                                child:
                                                                    ClipRRect(
                                                                        borderRadius:
                                                                            const BorderRadius
                                                                                .only(
                                                                          topLeft:
                                                                              Radius.circular(5),
                                                                          topRight:
                                                                              Radius.circular(5),
                                                                        ),
                                                                        child: Image
                                                                            .network(
                                                                          matchedItem![index]
                                                                              .listingImagePath,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        )),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 5),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  RatingBar.builder(
                                                                      glow: false,
                                                                      updateOnDrag: true,
                                                                      initialRating: 1,
                                                                      unratedColor: Colors.grey[300],
                                                                      minRating: 1,
                                                                      itemSize: 15,
                                                                      itemBuilder: (context, _) => const Icon(
                                                                            Icons.star,
                                                                            color:
                                                                                secondaryColor,
                                                                          ),
                                                                      onRatingUpdate: (rating) {
                                                                        //print(rating);
                                                                      }),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                      matchedItem[
                                                                              index]
                                                                          .listingName,
                                                                      style:
                                                                          listingTitle,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .visible,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        5),
                                                                child: Row(
                                                                  children: [
                                                                    const Icon(
                                                                      Icons
                                                                          .business_center,
                                                                      size: 15,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Text(
                                                                      matchedItem[
                                                                              index]
                                                                          .storeName,
                                                                      style:
                                                                          listingDescription,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  const Icon(
                                                                    Icons
                                                                        .price_change,
                                                                    size: 15,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Text(
                                                                    "RM ${matchedItem[index].price}",
                                                                    style:
                                                                        listingDescription,
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )));
                                        }),
                                  ),
                                );
                              }
                            } else {
                              return const Loading();
                            }
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
