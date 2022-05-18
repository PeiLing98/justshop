import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/components/search_bar.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/models/listing_model.dart';
import 'package:final_year_project/pages/filter/filter.dart';
import 'package:final_year_project/pages/homepage/listing_detail.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FilterListing extends StatefulWidget {
  final String selectedCategory;
  final String selectedSubCategory;
  final int minPriceRange;
  final int maxPriceRange;
  final int rating;
  final bool isPopularity;

  const FilterListing({
    Key? key,
    required this.selectedCategory,
    required this.selectedSubCategory,
    required this.minPriceRange,
    required this.maxPriceRange,
    required this.rating,
    required this.isPopularity,
  }) : super(key: key);

  @override
  _FilterListingState createState() => _FilterListingState();
}

class _FilterListingState extends State<FilterListing> {
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
                      if (widget.selectedCategory != "" ||
                          widget.selectedSubCategory != "" ||
                          widget.minPriceRange != 0 ||
                          widget.maxPriceRange != 0 ||
                          widget.rating != 0 ||
                          widget.isPopularity)
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
                                        if (widget.minPriceRange != 0 &&
                                            widget.maxPriceRange != 0)
                                          SelectedFilterOption(
                                              buttonText:
                                                  'RM${widget.minPriceRange} - RM${widget.maxPriceRange}'),
                                        if (widget.rating != 0)
                                          SelectedFilterOption(
                                              buttonText:
                                                  '${widget.rating} Stars'),
                                        if (widget.isPopularity == true)
                                          const SelectedFilterOption(
                                              buttonText:
                                                  'Sorted by popularity'),
                                      ])),
                              // Expanded(
                              //     flex: 2,
                              //     child: IconButton(
                              //         padding: const EdgeInsets.all(0),
                              //         alignment: Alignment.topRight,
                              //         onPressed: () {
                              //           Navigator.push(
                              //               context,
                              //               MaterialPageRoute(
                              //                   builder: (context) =>
                              //                       const Filter()));
                              //         },
                              //         icon: const Icon(
                              //           Icons.filter_list,
                              //           size: 25,
                              //         )))
                            ],
                          ),
                        ),
                      const SizedBox(
                        height: 5,
                      ),
                      if (widget.selectedCategory == "" &&
                          widget.selectedSubCategory == "" &&
                          widget.minPriceRange == 0 &&
                          widget.maxPriceRange == 0 &&
                          widget.rating == 0 &&
                          !widget.isPopularity)
                        StreamBuilder<List<Listing>>(
                            stream: DatabaseService(uid: "").item,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<Listing>? item = snapshot.data;

                                return SingleChildScrollView(
                                  child: SizedBox(
                                    height: 540,
                                    child: GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 5,
                                          crossAxisSpacing: 5,
                                        ),
                                        itemCount: item!.length,
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
                                                                  item[index],
                                                              // storeName: widget
                                                              //     .store
                                                              //     .businessName,
                                                              // storeImagePath:
                                                              //     widget.store
                                                              //         .imagePath,
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
                                                                          item[index]
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
                                                                      item[index]
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
                                                                      item[index]
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
                                                                    "RM ${item[index].price}",
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
                              } else {
                                return const Loading();
                              }
                            }),
                      if (widget.selectedCategory != "" ||
                          widget.selectedSubCategory != "" ||
                          widget.minPriceRange != 0 ||
                          widget.maxPriceRange != 0 ||
                          widget.rating != 0 ||
                          widget.isPopularity)
                        StreamBuilder<List<Listing>>(
                            stream: DatabaseService(uid: "").item,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<Listing>? item = snapshot.data;
                                List<Listing>? matchItem;

                                if (widget.selectedCategory != "" &&
                                    widget.selectedSubCategory != "" &&
                                    widget.minPriceRange == 0 &&
                                    widget.maxPriceRange == 0) {
                                  matchItem = item?.where((item) {
                                    return item.selectedCategory ==
                                            widget.selectedCategory &&
                                        item.selectedSubCategory ==
                                            widget.selectedSubCategory;
                                  }).toList();
                                } else if (widget.minPriceRange != 0 &&
                                    widget.maxPriceRange != 0 &&
                                    widget.selectedCategory == "" &&
                                    widget.selectedSubCategory == "") {
                                  matchItem = item?.where((item) {
                                    return (int.parse(item.price) >=
                                            widget.minPriceRange &&
                                        int.parse(item.price) <=
                                            widget.maxPriceRange);
                                  }).toList();
                                } else if (widget.selectedCategory != "" &&
                                    widget.selectedSubCategory != "" &&
                                    widget.minPriceRange != 0 &&
                                    widget.maxPriceRange != 0) {
                                  matchItem = item?.where((item) {
                                    return item.selectedCategory ==
                                            widget.selectedCategory &&
                                        item.selectedSubCategory ==
                                            widget.selectedSubCategory &&
                                        int.parse(item.price) >=
                                            widget.minPriceRange &&
                                        int.parse(item.price) <=
                                            widget.maxPriceRange;
                                  }).toList();
                                }

                                if (matchItem!.isEmpty) {
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
                                          itemCount: matchItem.length,
                                          itemBuilder: (context, index) {
                                            return SizedBox(
                                                height: 100,
                                                child: Card(
                                                    elevation: 5,
                                                    shape:
                                                        RoundedRectangleBorder(
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
                                                                    matchItem![
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
                                                                child:
                                                                    Container(
                                                                  height: 80,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              5),
                                                                      topRight:
                                                                          Radius.circular(
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
                                                                  child: ClipRRect(
                                                                      borderRadius: const BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(5),
                                                                        topRight:
                                                                            Radius.circular(5),
                                                                      ),
                                                                      child: Image.network(
                                                                        matchItem![index]
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
                                                                    vertical:
                                                                        5),
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
                                                                              color: secondaryColor,
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
                                                                      child:
                                                                          Text(
                                                                        matchItem[index]
                                                                            .listingName,
                                                                        style:
                                                                            listingTitle,
                                                                        overflow:
                                                                            TextOverflow.visible,
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
                                                                        size:
                                                                            15,
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        matchItem[index]
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
                                                                      "RM ${matchItem[index].price}",
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
