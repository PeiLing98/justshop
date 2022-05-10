import 'dart:collection';

import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/components/tab_bar.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/models/listing_model.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/pages/homepage/listing_detail.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ViewStore extends StatefulWidget {
  const ViewStore({Key? key}) : super(key: key);

  @override
  _ViewStoreState createState() => _ViewStoreState();
}

class _ViewStoreState extends State<ViewStore> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: StreamBuilder<UserStoreData>(
          stream: DatabaseService(uid: user.uid).userStoreData,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Loading();
            }
            UserStoreData? userStoreData = snapshot.data;

            return Scaffold(
              body: SafeArea(
                  child: StreamBuilder<List<Listing>>(
                      stream: DatabaseService(uid: "").item,
                      builder: (context, snapshot) {
                        List<Listing>? item = snapshot.data;
                        List<Listing>? matchedStoreItem;
                        matchedStoreItem = item?.where((item) {
                          return item.storeId == userStoreData!.storeId;
                        }).toList();

                        if (snapshot.hasData) {
                          return Container(
                            margin: const EdgeInsets.all(5),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                      height: 40, child: TopAppBar()),
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            IconButton(
                                              padding: const EdgeInsets.all(0),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: const Icon(
                                                  Icons.arrow_back_ios),
                                              iconSize: 20,
                                              alignment: Alignment.topLeft,
                                            ),
                                            const SizedBox(
                                              width: 110,
                                            ),
                                            Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: const Color.fromARGB(
                                                      250, 233, 221, 221),
                                                  border: Border.all(
                                                      width: 0.5,
                                                      color: Colors.grey)),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: Image.network(
                                                    userStoreData!.imagePath,
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          userStoreData.businessName,
                                          style: boldContentTitle,
                                        ),
                                        RatingBar.builder(
                                            glow: false,
                                            updateOnDrag: true,
                                            initialRating: 1,
                                            unratedColor: Colors.grey[300],
                                            minRating: 1,
                                            itemSize: 20,
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                                  Icons.star,
                                                  color: secondaryColor,
                                                ),
                                            onRatingUpdate: (rating) {
                                              //print(rating);
                                            }),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: 25,
                                          alignment: Alignment.center,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: 2,
                                              itemBuilder: (context, index) {
                                                List<String> categorylist = [
                                                  matchedStoreItem![index]
                                                      .selectedCategory
                                                ];
                                                List<String> subCategorylist = [
                                                  matchedStoreItem[index]
                                                      .selectedSubCategory
                                                ];
                                                List<List<String>>
                                                    categoryDistinctList = [
                                                  LinkedHashSet<String>.from(
                                                          categorylist)
                                                      .toList(),
                                                  LinkedHashSet<String>.from(
                                                          subCategorylist)
                                                      .toList()
                                                ];

                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 5),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10,
                                                          vertical: 5),
                                                      child: Text(
                                                        categoryDistinctList[
                                                            index][0],
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'Roboto'),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10),
                                              child: Icon(
                                                Icons.location_pin,
                                                size: 20,
                                              ),
                                            ),
                                            Flexible(
                                                child: Text(
                                              userStoreData.address,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'Roboto'),
                                            ))
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10),
                                              child: Icon(
                                                Icons.access_time,
                                                size: 20,
                                              ),
                                            ),
                                            Flexible(
                                                child: Text(
                                              '${userStoreData.startTime} - ${userStoreData.endTime}',
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'Roboto'),
                                            ))
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Row(children: [
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10),
                                                  child: Icon(
                                                    Icons.phone_rounded,
                                                    size: 20,
                                                  ),
                                                ),
                                                Text(
                                                  userStoreData.phoneNumber,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: 'Roboto'),
                                                ),
                                              ]),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  if (userStoreData
                                                          .facebookLink !=
                                                      "")
                                                    SizedBox(
                                                      height: 25,
                                                      width: 25,
                                                      child: IconButton(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        alignment: Alignment
                                                            .centerRight,
                                                        onPressed: () async {
                                                          String url =
                                                              userStoreData
                                                                  .facebookLink;

                                                          if (await canLaunchUrlString(
                                                              url)) {
                                                            await launchUrlString(
                                                                url);
                                                          } else {
                                                            throw 'Could not launch $url';
                                                          }
                                                        },
                                                        icon: const Icon(
                                                            FontAwesomeIcons
                                                                .facebookSquare,
                                                            color:
                                                                Color.fromRGBO(
                                                                    66,
                                                                    103,
                                                                    178,
                                                                    1)),
                                                      ),
                                                    ),
                                                  if (userStoreData
                                                          .instagramLink !=
                                                      "")
                                                    SizedBox(
                                                      height: 25,
                                                      width: 25,
                                                      child: IconButton(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        alignment: Alignment
                                                            .centerRight,
                                                        onPressed: () async {
                                                          String url =
                                                              userStoreData
                                                                  .instagramLink;

                                                          if (await canLaunchUrlString(
                                                              url)) {
                                                            await launchUrlString(
                                                                url);
                                                          } else {
                                                            throw 'Could not launch $url';
                                                          }
                                                        },
                                                        icon: const Icon(
                                                            FontAwesomeIcons
                                                                .instagramSquare,
                                                            color:
                                                                Color.fromRGBO(
                                                                    233,
                                                                    89,
                                                                    80,
                                                                    1)),
                                                      ),
                                                    ),
                                                  if (userStoreData
                                                          .whatsappLink !=
                                                      "")
                                                    SizedBox(
                                                      height: 25,
                                                      width: 25,
                                                      child: IconButton(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        alignment: Alignment
                                                            .centerRight,
                                                        onPressed: () async {
                                                          String url =
                                                              userStoreData
                                                                  .whatsappLink;

                                                          if (await canLaunchUrlString(
                                                              url)) {
                                                            await launchUrlString(
                                                                url);
                                                          } else {
                                                            throw 'Could not launch $url';
                                                          }
                                                        },
                                                        icon: const Icon(
                                                            FontAwesomeIcons
                                                                .whatsappSquare,
                                                            color:
                                                                Color.fromRGBO(
                                                                    40,
                                                                    209,
                                                                    70,
                                                                    1)),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                            height: 345,
                                            child: StoreTabBar(
                                              listingBody:
                                                  SingleChildScrollView(
                                                child: SizedBox(
                                                    height: 300,
                                                    child: ListView.builder(
                                                        itemCount:
                                                            matchedStoreItem!
                                                                .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Card(
                                                              elevation: 3,
                                                              child: InkWell(
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) => ListingDetail(
                                                                                listing: matchedStoreItem![index],
                                                                                storeName: userStoreData.businessName,
                                                                                storeImagePath: userStoreData.imagePath,
                                                                              )));
                                                                },
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(5),
                                                                  child:
                                                                      ListTile(
                                                                    title: Text(
                                                                      matchedStoreItem![
                                                                              index]
                                                                          .listingName,
                                                                      style:
                                                                          boldContentTitle,
                                                                    ),
                                                                    subtitle:
                                                                        Text(
                                                                      'RM ${matchedStoreItem[index].price}',
                                                                      style:
                                                                          ratingLabelStyle,
                                                                    ),
                                                                    leading: Container(
                                                                        width: 100,
                                                                        height: 50,
                                                                        decoration: const BoxDecoration(
                                                                          shape:
                                                                              BoxShape.rectangle,
                                                                          color: Color.fromARGB(
                                                                              249,
                                                                              185,
                                                                              181,
                                                                              181),
                                                                        ),
                                                                        child: ClipRRect(
                                                                            child: Image.network(
                                                                          matchedStoreItem[index]
                                                                              .listingImagePath,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ))),
                                                                  ),
                                                                ),
                                                              ));
                                                        })),
                                              ),
                                              reviewBody: SingleChildScrollView(
                                                child: SizedBox(
                                                    height: 300,
                                                    child: ListView.builder(
                                                        itemCount: 5,
                                                        //userStoreData.listing.length,
                                                        itemBuilder:
                                                            (context, builder) {
                                                          return Card(
                                                            elevation: 3,
                                                            child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(5),
                                                                child: ListTile(
                                                                  title:
                                                                      const Text(
                                                                    'Username',
                                                                    style:
                                                                        boldContentTitle,
                                                                  ),
                                                                  trailing: RatingBar.builder(
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
                                                                  subtitle:
                                                                      const Text(
                                                                    'I like it very much!',
                                                                    style:
                                                                        ratingLabelStyle,
                                                                  ),
                                                                  isThreeLine:
                                                                      true,
                                                                  // title: Text(userStoreData.listing, style: boldContentTitle,),
                                                                  // subtitle: Text(userStoreData.listing, style: ratingLabelStyle,),
                                                                  leading:
                                                                      Container(
                                                                    width: 50,
                                                                    height: 50,
                                                                    decoration: BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.grey)),
                                                                    child: ClipRRect(
                                                                        borderRadius: BorderRadius.circular(50),
                                                                        child: const Icon(
                                                                          Icons
                                                                              .person_rounded,
                                                                          size:
                                                                              30,
                                                                        )),
                                                                  ),
                                                                )),
                                                          );
                                                        })),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return const Loading();
                        }
                      })),
            );
          }),
    );
  }
}
