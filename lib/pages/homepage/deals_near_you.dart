import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/models/listing_model.dart';
import 'package:final_year_project/models/store_model.dart';
import 'package:final_year_project/pages/homepage/listing_detail.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder2/geocoder2.dart' as geoCo;

class DealsNearYou extends StatefulWidget {
  const DealsNearYou({Key? key}) : super(key: key);

  @override
  _DealsNearYouState createState() => _DealsNearYouState();
}

class _DealsNearYouState extends State<DealsNearYou> {
  final kGoogleApiKey = '';
  String currentState = "";
  String currentCity = "";

  Future<Position> getCurrentPosition() async {
    var _permissionGranted = await Geolocator.checkPermission();

    if (_permissionGranted != LocationPermission.always ||
        _permissionGranted != LocationPermission.whileInUse) {
      await Geolocator.requestPermission();
    }

    final currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true);

    return currentPosition;
  }

  getFormattedAddressFromCoordinates(double latitude, double longtitude) async {
    var address = await geoCo.Geocoder2.getDataFromCoordinates(
        latitude: latitude,
        longitude: longtitude,
        googleMapApiKey: kGoogleApiKey);
    var city = address.postalCode;
    var state = address.state;

    // if (mounted) {
    setState(() {
      currentCity = city;
      currentState = state;
    });
    // }
  }

  @override
  void initState() {
    super.initState();
    // getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCurrentPosition(),
        builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
          if (snapshot.hasData) {
            Position? position = snapshot.data;
            if (position != null) {
              double lat = position.latitude;
              double long = position.longitude;
              getFormattedAddressFromCoordinates(lat, long);
            }

            return StreamBuilder<List<Store>>(
                stream: DatabaseService(uid: "").stores,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Store>? stores = snapshot.data;
                    List<Store>? matchedStoreItem;
                    matchedStoreItem = stores!.where((stores) {
                      return stores.city == currentCity ||
                          stores.state == currentState;
                    }).toList();

                    if (matchedStoreItem.isEmpty) {
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
                                      matchedStoreItem?[index].storeId;
                                }).toList();

                                matchedItem.sort((b, a) {
                                  return a.rating.compareTo(b.rating);
                                });

                                if (matchedItem.isEmpty) {
                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'No store is near you currently.',
                                          style: boldContentTitle,
                                        )
                                      ],
                                    ),
                                  );
                                }
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
                                                              height: 62,
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
                                                                    height: 2,
                                                                  ),
                                                                  RatingBar.builder(
                                                                      allowHalfRating: true,
                                                                      ignoreGestures: true,
                                                                      glow: false,
                                                                      updateOnDrag: true,
                                                                      initialRating: double.parse(matchedItem[index2].rating),
                                                                      unratedColor: Colors.grey[300],
                                                                      minRating: 1,
                                                                      itemSize: 13,
                                                                      itemBuilder: (context, _) => const Icon(
                                                                            Icons.star,
                                                                            color:
                                                                                secondaryColor,
                                                                          ),
                                                                      onRatingUpdate: (rating) {
                                                                        //print(rating);
                                                                      }),
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
                                                            SizedBox(
                                                              height: 10,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Text(
                                                                    'Sales: ${matchedItem[index2].totalSales}',
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            10,
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
                                      }),
                                );
                              } else {
                                // return SizedBox(
                                //   width: MediaQuery.of(context).size.width,
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.center,
                                //     children: const [
                                //       Text(
                                //         'No store is near you currently.',
                                //         style: boldContentTitle,
                                //       )
                                //     ],
                                //   ),
                                // );
                                return const Loading();
                              }
                            });
                      },
                    );
                  } else {
                    return const Loading();
                  }
                });
          } else {
            return const Loading();
          }
        });
  }
}
