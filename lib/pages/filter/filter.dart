import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/components/location_map.dart';
import 'package:final_year_project/components/tab_bar.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/models/category_model.dart';
import 'package:final_year_project/models/store_model.dart';
import 'package:final_year_project/pages/filter/filter_listing.dart';
import 'package:final_year_project/pages/homepage/store_listing_detail.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  bool isCategory = false;
  bool isLocation = false;

  final category = Category();
  String selectedCategory = '';
  String selectedSubCategory = '';

  String savedAddress = '';
  String savedLatitude = '';
  String savedLongtitude = '';
  String savedState = "";
  String keyword = "";

  String searchingKeyword = "";
  double searchingLocationLat = 0.0;
  double searchingLocationLong = 0.0;
  List<double> distanceBetween = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                    hasArrow: false,
                  )),
              Expanded(
                flex: 13,
                child: FilterTabBar(
                    filterOption: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                            child: Row(children: [
                              Expanded(
                                flex: 12,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: SizedBox(
                                    height: 30,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        if (isCategory)
                                          SelectedFilterOption(
                                            buttonText: selectedCategory,
                                            isClose: true,
                                            closeButtonAction: () {
                                              setState(() {
                                                isCategory = false;
                                                selectedCategory = "";
                                                selectedSubCategory = "";
                                              });
                                            },
                                          ),
                                        if (isCategory)
                                          SelectedFilterOption(
                                            buttonText: selectedSubCategory,
                                            isClose: true,
                                            closeButtonAction: () {
                                              setState(() {
                                                isCategory = false;
                                                selectedSubCategory = "";
                                                selectedCategory = "";
                                              });
                                            },
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: !isCategory ? 5 : 2,
                                child: PurpleTextButton(
                                    buttonText: !isCategory
                                        ? 'Check All Listing'
                                        : 'Filter',
                                    onClick: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FilterListing(
                                                    selectedCategory:
                                                        selectedCategory,
                                                    selectedSubCategory:
                                                        selectedSubCategory,
                                                  )));
                                    }),
                              )
                            ]),
                          ),
                        ),
                        SizedBox(
                          height: 420,
                          child: ListView(
                            children: [
                              const FilterTitleAppBar(title: 'FOOD'),
                              SizedBox(
                                height: 110,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: category.subCategory[0].length,
                                    itemBuilder: (context, index) {
                                      return ImageButton(
                                        categoryLabel: category.subCategory[0]
                                                [index]
                                            .toString(),
                                        imageLink: AssetImage(category
                                            .categoryImage[0][index]
                                            .toString()),
                                        onTap: () {
                                          setState(() {
                                            isCategory = true;
                                            selectedCategory =
                                                category.category[0];
                                            selectedSubCategory = category
                                                .subCategory[0][index]
                                                .toString();
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const FilterTitleAppBar(title: 'PRODUCT'),
                              SizedBox(
                                height: 110,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: category.subCategory[1].length,
                                    itemBuilder: (context, index) {
                                      return ImageButton(
                                        categoryLabel: category.subCategory[1]
                                                [index]
                                            .toString(),
                                        imageLink: AssetImage(category
                                            .categoryImage[1][index]
                                            .toString()),
                                        onTap: () {
                                          setState(() {
                                            isCategory = true;
                                            selectedCategory =
                                                category.category[1];
                                            selectedSubCategory = category
                                                .subCategory[1][index]
                                                .toString();
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const FilterTitleAppBar(title: 'SERVICE'),
                              SizedBox(
                                height: 120,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: category.subCategory[2].length,
                                    itemBuilder: (context, index) {
                                      return ImageButton(
                                        categoryLabel: category.subCategory[2]
                                                [index]
                                            .toString(),
                                        imageLink: AssetImage(category
                                            .categoryImage[2][index]
                                            .toString()),
                                        onTap: () {
                                          setState(() {
                                            isCategory = true;
                                            selectedCategory =
                                                category.category[2];
                                            selectedSubCategory = category
                                                .subCategory[2][index]
                                                .toString();
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    locationOption: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Expanded(
                                  child: FilterTitleAppBar(title: 'LOCATION')),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 100,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Text(
                                      'Searching for: ',
                                      style: boldContentTitle,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 35,
                                  width: 270,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.zero,
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: TextField(
                                    style: ratingLabelStyle,
                                    decoration: const InputDecoration(
                                        hintText:
                                            'Search food, product, service here',
                                        hintStyle: ratingLabelStyle,
                                        border: InputBorder.none,
                                        isCollapsed: true),
                                    onChanged: (val) {
                                      keyword = val;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: [
                                const Text(
                                  'Location:',
                                  style: boldContentTitle,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: IconButton(
                                      padding: const EdgeInsets.all(0),
                                      icon: const Icon(Icons.location_searching,
                                          color: Colors.grey),
                                      iconSize: 15,
                                      onPressed: () {
                                        _awaitReturnValueFromLocationMap(
                                            context);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (isLocation)
                                  SelectedFilterOption(
                                    buttonText: savedAddress,
                                    isClose: false,
                                  ),
                                if (!isLocation)
                                  const Text(
                                    'No location is chosen.',
                                    style: ratingLabelStyle,
                                  ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 80,
                                      height: 30,
                                      child: PurpleTextButton(
                                        buttonText: "Search",
                                        onClick: () {
                                          distanceBetween.clear();
                                          setState(() {
                                            searchingKeyword = keyword;
                                            searchingLocationLat =
                                                double.parse(savedLatitude);
                                            searchingLocationLong =
                                                double.parse(savedLongtitude);
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          if (searchingKeyword != "" &&
                              searchingLocationLat != 0 &&
                              searchingLocationLong != 0)
                            Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Divider(
                                    color: Colors.grey,
                                    thickness: 0.5,
                                    height: 10,
                                  ),
                                ),
                                StreamBuilder<List<Store>>(
                                    stream: DatabaseService(uid: "").stores,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        List<Store>? store = snapshot.data;
                                        List<Store>? matchedStore = [];
                                        List sortedStore = [];

                                        for (var s in store!) {
                                          if (s.businessName
                                                  .toLowerCase()
                                                  .contains(searchingKeyword
                                                      .toLowerCase()) &&
                                              s.state == savedState) {
                                            matchedStore.add(
                                              s,
                                            );
                                          }
                                        }

                                        for (var s in matchedStore) {
                                          if (distanceBetween.length <
                                              matchedStore.length) {
                                            distanceBetween
                                                .add(getDistanceBetween(s));
                                          }
                                        }

                                        for (int i = 0;
                                            i < matchedStore.length;
                                            i++) {
                                          sortedStore.add({
                                            'store': matchedStore[i],
                                            'distance': distanceBetween[i]
                                          });

                                          // print('$i : ${sortedStore[i]}');
                                        }

                                        sortedStore.sort((a, b) => a['distance']
                                            .compareTo(b['distance']));

                                        // print(sortedStore.toString());

                                        //print(distanceBetween.toString());

                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 10, 15, 0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                sortedStore.isEmpty
                                                    ? "0 Result"
                                                    : sortedStore.length == 1
                                                        ? "1 Result"
                                                        : "${sortedStore.length} Results",
                                                style: boldContentTitle,
                                              ),
                                              SizedBox(
                                                height: 250,
                                                child: sortedStore.isEmpty
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: const [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 20),
                                                              child: Text(
                                                                "No matched store is near you.",
                                                                style:
                                                                    ratingLabelStyle,
                                                              ),
                                                            )
                                                          ])
                                                    : ListView.builder(
                                                        itemCount:
                                                            sortedStore.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return SizedBox(
                                                            height: 100,
                                                            child: Card(
                                                              elevation: 5,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child: InkWell(
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              StoreListingDetail(store: sortedStore[index]['store'])));
                                                                },
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          20,
                                                                      vertical:
                                                                          5),
                                                                  child: Row(
                                                                    children: [
                                                                      Container(
                                                                        width:
                                                                            60,
                                                                        height:
                                                                            60,
                                                                        decoration:
                                                                            const BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                          color: Color.fromARGB(
                                                                              250,
                                                                              129,
                                                                              89,
                                                                              89),
                                                                        ),
                                                                        child: ClipRRect(
                                                                            borderRadius: BorderRadius.circular(50),
                                                                            child: Image.network(
                                                                              sortedStore[index]['store'].imagePath,
                                                                              fit: BoxFit.cover,
                                                                            )),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.fromLTRB(
                                                                            15,
                                                                            5,
                                                                            0,
                                                                            5),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(sortedStore[index]['store'].businessName,
                                                                                style: buttonLabelStyle),
                                                                            const SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                const Icon(Icons.location_city, size: 15),
                                                                                const SizedBox(width: 5),
                                                                                Text(
                                                                                  '${sortedStore[index]['store'].city}, ${sortedStore[index]['store'].state}',
                                                                                  style: ratingLabelStyle,
                                                                                )
                                                                              ],
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                const Icon(Icons.location_on, size: 15),
                                                                                const SizedBox(width: 5),
                                                                                Text(
                                                                                  '${(sortedStore[index]['distance'] / 1000).toStringAsFixed(2)}km away from you',
                                                                                  style: ratingLabelStyle,
                                                                                )
                                                                              ],
                                                                            )
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                              )
                                            ],
                                          ),
                                        );
                                      } else {
                                        return const Loading();
                                      }
                                    })
                              ],
                            ),
                        ],
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  getDistanceBetween(Store store) {
    double distance = 0.0;
    distance = Geolocator.distanceBetween(
        searchingLocationLat,
        searchingLocationLong,
        double.parse(store.latitude),
        double.parse(store.longtitude));

    return distance;
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
      savedState = result[4];
      isLocation = true;
    });
  }
}
