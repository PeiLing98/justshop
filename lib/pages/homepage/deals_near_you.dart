import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/models/listing_model.dart';
import 'package:final_year_project/models/store_model.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/pages/homepage/listing_detail.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DealsNearYou extends StatefulWidget {
  const DealsNearYou({Key? key}) : super(key: key);

  @override
  _DealsNearYouState createState() => _DealsNearYouState();
}

class _DealsNearYouState extends State<DealsNearYou> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return StreamBuilder<List<Store>>(
                stream: DatabaseService(uid: "").stores,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Store>? stores = snapshot.data;
                    List<Store>? matchedStoreItem;
                    matchedStoreItem = stores!.where((stores) {
                      return stores.city == userData?.postcode ||
                          stores.state == userData?.state;
                    }).toList();

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: matchedStoreItem.length,
                      itemBuilder: (context, index) {
                        return StreamBuilder<List<Listing>>(
                            stream: DatabaseService(uid: "").item,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<Listing>? item = snapshot.data;
                                List<Listing>? matchedItem;
                                matchedItem = item!.where((item) {
                                  return item.storeId ==
                                      matchedStoreItem![index].storeId;
                                }).toList();

                                return SizedBox(
                                  height: 100,
                                  width: matchedItem.length * 250,
                                  child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: matchedItem.length,
                                      itemBuilder: (context, index2) {
                                        return SizedBox(
                                          width: 250,
                                          child: Card(
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
                                                              ListingDetail(
                                                                listing:
                                                                    matchedItem![
                                                                        index2],
                                                                // storeImagePath:
                                                                //     matchedStore![index]
                                                                //         .imagePath,
                                                                // storeName: matchedStore[index]
                                                                //     .businessName
                                                              )));
                                                },
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 90,
                                                      height: 100,
                                                      decoration:
                                                          const BoxDecoration(
                                                        shape:
                                                            BoxShape.rectangle,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10)),
                                                        color: Color.fromARGB(
                                                            250, 129, 89, 89),
                                                      ),
                                                      child: ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10)),
                                                          child: Image.network(
                                                            matchedItem![index2]
                                                                .listingImagePath,
                                                            fit: BoxFit.cover,
                                                          )),
                                                    ),
                                                    SizedBox(
                                                      width: 150,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              height: 50,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    matchedItem[
                                                                            index2]
                                                                        .listingName,
                                                                    style:
                                                                        buttonLabelStyle,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .visible,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                    'RM ${matchedItem[index2].price}',
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      fontFamily:
                                                                          'Roboto',
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            SizedBox(
                                                              height: 15,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: const [
                                                                  Text(
                                                                    '5 Sold',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color:
                                                                            secondaryColor),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )),
                                          ),
                                        );
                                        //   } else {
                                        //     return const Loading();
                                        //   }
                                        // });
                                      }),
                                );
                              } else {
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        'No store is near you currently.',
                                        style: boldContentTitle,
                                      )
                                    ],
                                  ),
                                );
                              }
                            });
                      },
                    );
                  } else {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'No store is near you currently.',
                            style: boldContentTitle,
                          )
                        ],
                      ),
                    );
                  }
                });
          } else {
            return const Loading();
          }
        });
  }
}
