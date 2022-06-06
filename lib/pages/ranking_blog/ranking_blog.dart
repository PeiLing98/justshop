import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/models/listing_model.dart';
import 'package:final_year_project/models/store_model.dart';
import 'package:final_year_project/pages/homepage/store_listing_detail.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RankingBlog extends StatefulWidget {
  const RankingBlog({Key? key}) : super(key: key);

  @override
  _RankingBlogState createState() => _RankingBlogState();
}

class _RankingBlogState extends State<RankingBlog> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: StreamBuilder<List<Store>>(
          stream: DatabaseService(uid: "").stores,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Store>? store = snapshot.data;

              store?.sort((b, a) {
                return b.totalSales == a.totalSales
                    ? a.rating.compareTo(b.rating)
                    : a.totalSales.compareTo(b.totalSales);
              });

              return StreamBuilder<List<Listing>>(
                  stream: DatabaseService(uid: "").item,
                  builder: (context, snapshot) {
                    List<Listing>? item = snapshot.data;
                    List<String>? matchedCategory = [];
                    List<String>? matchedSubCategory = [];
                    List<String>? distinctCategory = [];
                    List<String>? distinctSubCategory = [];
                    List<List<String>>? matchedStoreCategory = [];
                    List<List<String>>? matchedStoreSubCategory = [];

                    for (int i = 0; i < 10; i++) {
                      matchedCategory.clear();
                      matchedSubCategory.clear();
                      if (item != null) {
                        for (int j = 0; j < item.length; j++) {
                          if (store?[i].storeId == item[j].storeId) {
                            matchedCategory.add(item[j].selectedCategory);
                            matchedSubCategory.add(item[j].selectedSubCategory);
                          }
                        }

                        distinctCategory = matchedCategory.toSet().toList();
                        distinctSubCategory =
                            matchedSubCategory.toSet().toList();

                        matchedStoreCategory.add(distinctCategory);
                        matchedStoreSubCategory.add(distinctSubCategory);
                      }
                    }

                    if (snapshot.hasData) {
                      return Scaffold(
                        body: SafeArea(
                            child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 40, child: TopAppBar()),
                                TitleAppBar(
                                  title: 'Ranking Blog',
                                  iconFlex: 1,
                                  titleFlex: 2,
                                  hasArrow: true,
                                  onClick: () {
                                    Navigator.pushNamed(
                                        context, '/pagescontroller');
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: SizedBox(
                                      height: 500,
                                      child: ListView.builder(
                                          itemCount: 10,
                                          itemBuilder: (context, index) {
                                            return Card(
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              StoreListingDetail(
                                                                  store: store![
                                                                      index])));
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 10),
                                                        child: Container(
                                                          width: 60,
                                                          height: 60,
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: const Color
                                                                      .fromARGB(
                                                                  250,
                                                                  233,
                                                                  221,
                                                                  221),
                                                              border: Border.all(
                                                                  width: 0.5,
                                                                  color: Colors
                                                                      .grey)),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            child: Image.network(
                                                                store![index]
                                                                    .imagePath,
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      ),
                                                      Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              height: 20,
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    store[index]
                                                                        .businessName,
                                                                    style:
                                                                        buttonLabelStyle,
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            5),
                                                                    child: RatingBar.builder(
                                                                        allowHalfRating: true,
                                                                        ignoreGestures: true,
                                                                        glow: false,
                                                                        updateOnDrag: true,
                                                                        initialRating: double.parse(store[index].rating),
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
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                const Icon(
                                                                  Icons
                                                                      .location_pin,
                                                                  size: 15,
                                                                ),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  store[index]
                                                                          .city +
                                                                      ", " +
                                                                      store[index]
                                                                          .state,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    fontFamily:
                                                                        'Roboto',
                                                                  ),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .visible,
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            5),
                                                                    child:
                                                                        Container(
                                                                      decoration: BoxDecoration(
                                                                          border:
                                                                              Border.all(color: Colors.grey),
                                                                          borderRadius: BorderRadius.circular(5)),
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                10,
                                                                            vertical:
                                                                                3),
                                                                        child:
                                                                            Text(
                                                                          matchedStoreCategory[index]
                                                                              [
                                                                              0],
                                                                          style: const TextStyle(
                                                                              fontSize: 10,
                                                                              fontFamily: 'Roboto'),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                      ),
                                                                    )),
                                                                Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            5),
                                                                    child:
                                                                        Container(
                                                                      decoration: BoxDecoration(
                                                                          border:
                                                                              Border.all(color: Colors.grey),
                                                                          borderRadius: BorderRadius.circular(5)),
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                10,
                                                                            vertical:
                                                                                3),
                                                                        child:
                                                                            Text(
                                                                          matchedStoreSubCategory[index]
                                                                              [
                                                                              0],
                                                                          style: const TextStyle(
                                                                              fontSize: 10,
                                                                              fontFamily: 'Roboto'),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                      ),
                                                                    )),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            SizedBox(
                                                              width: 260,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Text(
                                                                    'Sales: ${store[index].totalSales}',
                                                                    style:
                                                                        buttonLabelStyle,
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ])
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          })

                                      // RatingMonthTabBar(
                                      //   latestFirstMonth: 'MAY 2022',
                                      //   latestSecondMonth: 'APRIL 2022',
                                      //   latestThirdMonth: 'MARCH 2022',
                                      //   latestFirstMonthBody: SingleChildScrollView(
                                      //       child: SizedBox(
                                      //     height: 500,
                                      //     child: ListView.builder(
                                      //       itemCount: 3,
                                      //       itemBuilder: (context, index) {
                                      //         return const RankingBlogComponent();
                                      //       },
                                      //     ),
                                      //   )),
                                      //   latestSecondMonthBody: SingleChildScrollView(
                                      //       child: SizedBox(
                                      //     height: 500,
                                      //     child: ListView.builder(
                                      //       itemCount: 2,
                                      //       itemBuilder: (context, index) {
                                      //         return const RankingBlogComponent();
                                      //       },
                                      //     ),
                                      //   )),
                                      //   latestThirdMonthBody: SingleChildScrollView(
                                      //       child: SizedBox(
                                      //     height: 500,
                                      //     child: ListView.builder(
                                      //       itemCount: 1,
                                      //       itemBuilder: (context, index) {
                                      //         return const RankingBlogComponent();
                                      //       },
                                      //     ),
                                      //   )),
                                      // )
                                      ),
                                )
                              ],
                            ),
                          ),
                        )),
                      );
                    } else {
                      return const Loading();
                    }
                  });
            } else {
              return const Loading();
            }
          }),
    );
  }
}
