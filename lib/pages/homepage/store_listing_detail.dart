import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/components/review_component.dart';
import 'package:final_year_project/components/tab_bar.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/models/chat_model.dart';
import 'package:final_year_project/models/listing_model.dart';
import 'package:final_year_project/models/order_model.dart';
import 'package:final_year_project/models/review_model.dart';
import 'package:final_year_project/models/store_model.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/pages/homepage/listing_detail.dart';
import 'package:final_year_project/pages/profile/user_chat/user_chat_conversation.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class StoreListingDetail extends StatefulWidget {
  final Store store;
  const StoreListingDetail({Key? key, required this.store}) : super(key: key);

  @override
  _StoreListingDetailState createState() => _StoreListingDetailState();
}

class _StoreListingDetailState extends State<StoreListingDetail> {
  List<Listing> matchedList = [];
  double totalRatingStar = 0;
  int sales = 0;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: StreamBuilder<List<Listing>>(
          stream: DatabaseService(uid: "").item,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Listing>? item = snapshot.data;
              List<Listing>? matchedStoreItem;
              matchedStoreItem = item!.where((item) {
                return item.storeId == widget.store.storeId;
              }).toList();

              matchedStoreItem.sort((a, b) {
                return a.listingName
                    .toLowerCase()
                    .compareTo(b.listingName.toLowerCase());
              });

              return StreamBuilder<List<Review>>(
                  stream: DatabaseService(uid: "").review,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Review>? reviews = snapshot.data;
                      List<Review>? matchedReviews = [];

                      matchedReviews = reviews?.where((review) {
                        return review.storeId == widget.store.storeId;
                      }).toList();

                      matchedReviews?.sort((b, a) {
                        return a.ratingStar.compareTo(b.ratingStar);
                      });

                      for (int i = 0; i < matchedReviews!.length; i++) {
                        if (i == 0) {
                          totalRatingStar =
                              double.parse(matchedReviews[0].ratingStar);
                        } else {
                          double nextRating = 0;

                          nextRating =
                              double.parse(matchedReviews[i].ratingStar);
                          totalRatingStar = totalRatingStar + nextRating;
                        }
                      }

                      if (matchedReviews.isEmpty) {
                        totalRatingStar = 0;
                      } else {
                        totalRatingStar =
                            totalRatingStar / matchedReviews.length;
                      }

                      storeRatingUpdating(totalRatingStar);

                      return StreamBuilder<List<AllUser>>(
                          stream: DatabaseService(uid: "").allUser,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<AllUser>? allUser = snapshot.data;
                              List<AllUser>? matchedUser = [];

                              for (int i = 0; i < matchedReviews!.length; i++) {
                                for (int j = 0; j < allUser!.length; j++) {
                                  if (matchedReviews[i].userId ==
                                      allUser[j].userId) {
                                    matchedUser.add(allUser[j]);
                                  }
                                }
                              }

                              List<Listing>? matchedUserItem = [];

                              for (int i = 0; i < matchedReviews.length; i++) {
                                for (int j = 0; j < item.length; j++) {
                                  if (matchedReviews[i].listingId ==
                                      item[j].listingId) {
                                    matchedUserItem.add(item[j]);
                                  }
                                }
                              }

                              return StreamBuilder<List<Order>>(
                                  stream: DatabaseService(uid: "").order,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List<Order>? orders = snapshot.data;
                                      List<int> matchedOrderQuantity = [];

                                      for (int i = 0; i < orders!.length; i++) {
                                        for (int j = 0;
                                            j < orders[i].orderItem.length;
                                            j++) {
                                          if (orders[i].orderItem[j]['store'] ==
                                                  widget.store.storeId &&
                                              orders[i].orderItem[j]
                                                      ['orderStatus'] ==
                                                  'Completed') {
                                            matchedOrderQuantity.add(orders[i]
                                                .orderItem[j]['quantity']);
                                          }
                                        }
                                      }

                                      if (matchedOrderQuantity.isNotEmpty) {
                                        if (matchedOrderQuantity.length == 1) {
                                          sales = matchedOrderQuantity[0];
                                        } else {
                                          sales = matchedOrderQuantity
                                              .reduce((a, b) => a + b);
                                        }
                                      }

                                      storeSalesUpdating(sales);

                                      return StreamBuilder<List<Chat>>(
                                          stream: DatabaseService(uid: "").chat,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              List<Chat>? chat = snapshot.data;
                                              List<Chat>? matchedChat = [];

                                              matchedChat = chat?.where((chat) {
                                                return chat.user1 ==
                                                        user?.uid &&
                                                    chat.user2 ==
                                                        widget.store.storeId;
                                              }).toList();

                                              return Scaffold(
                                                body: SafeArea(
                                                    child: Container(
                                                  margin:
                                                      const EdgeInsets.all(5),
                                                  child: SingleChildScrollView(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const SizedBox(
                                                            height: 40,
                                                            child: TopAppBar()),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  IconButton(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(0),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .arrow_back_ios),
                                                                    iconSize:
                                                                        20,
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 110,
                                                                  ),
                                                                  Container(
                                                                    width: 60,
                                                                    height: 60,
                                                                    decoration: BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: const Color.fromARGB(
                                                                            250,
                                                                            233,
                                                                            221,
                                                                            221),
                                                                        border: Border.all(
                                                                            width:
                                                                                0.5,
                                                                            color:
                                                                                Colors.grey)),
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50),
                                                                      child: Image.network(
                                                                          widget
                                                                              .store
                                                                              .imagePath,
                                                                          fit: BoxFit
                                                                              .cover),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text(
                                                                widget.store
                                                                    .businessName,
                                                                style:
                                                                    boldContentTitle,
                                                              ),
                                                              RatingBar.builder(
                                                                  allowHalfRating:
                                                                      true,
                                                                  ignoreGestures:
                                                                      true,
                                                                  glow: false,
                                                                  updateOnDrag:
                                                                      true,
                                                                  initialRating: double
                                                                      .parse(widget
                                                                          .store
                                                                          .rating),
                                                                  unratedColor:
                                                                      Colors
                                                                              .grey[
                                                                          300],
                                                                  minRating: 1,
                                                                  itemSize: 20,
                                                                  itemBuilder:
                                                                      (context,
                                                                              _) =>
                                                                          const Icon(
                                                                            Icons.star,
                                                                            color:
                                                                                secondaryColor,
                                                                          ),
                                                                  onRatingUpdate:
                                                                      (rating) {}),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                'Sales: ${widget.store.totalSales}',
                                                                style:
                                                                    buttonLabelStyle,
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  const Padding(
                                                                    padding: EdgeInsets.only(
                                                                        right:
                                                                            10),
                                                                    child: Icon(
                                                                      Icons
                                                                          .location_pin,
                                                                      size: 20,
                                                                    ),
                                                                  ),
                                                                  Flexible(
                                                                      child:
                                                                          Text(
                                                                    widget.store
                                                                        .address,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontFamily:
                                                                            'Roboto'),
                                                                  ))
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  const Padding(
                                                                    padding: EdgeInsets.only(
                                                                        right:
                                                                            10),
                                                                    child: Icon(
                                                                      Icons
                                                                          .access_time,
                                                                      size: 20,
                                                                    ),
                                                                  ),
                                                                  Flexible(
                                                                      child:
                                                                          Text(
                                                                    '${widget.store.startTime} - ${widget.store.endTime}',
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontFamily:
                                                                            'Roboto'),
                                                                  ))
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                    flex: 2,
                                                                    child: Row(
                                                                        children: [
                                                                          const Padding(
                                                                            padding:
                                                                                EdgeInsets.only(right: 10),
                                                                            child:
                                                                                Icon(
                                                                              Icons.phone_rounded,
                                                                              size: 20,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            widget.store.phoneNumber,
                                                                            style:
                                                                                const TextStyle(fontSize: 12, fontFamily: 'Roboto'),
                                                                          ),
                                                                        ]),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        if (widget.store.facebookLink !=
                                                                            "")
                                                                          SizedBox(
                                                                            height:
                                                                                25,
                                                                            width:
                                                                                25,
                                                                            child:
                                                                                IconButton(
                                                                              padding: const EdgeInsets.all(0),
                                                                              alignment: Alignment.centerRight,
                                                                              onPressed: () async {
                                                                                String url = widget.store.facebookLink;

                                                                                if (await canLaunchUrlString(url)) {
                                                                                  await launchUrlString(url);
                                                                                } else {
                                                                                  throw 'Could not launch $url';
                                                                                }
                                                                              },
                                                                              icon: const Icon(FontAwesomeIcons.facebookSquare, color: Color.fromRGBO(66, 103, 178, 1)),
                                                                            ),
                                                                          ),
                                                                        if (widget.store.instagramLink !=
                                                                            "")
                                                                          SizedBox(
                                                                            height:
                                                                                25,
                                                                            width:
                                                                                25,
                                                                            child:
                                                                                IconButton(
                                                                              padding: const EdgeInsets.all(0),
                                                                              alignment: Alignment.centerRight,
                                                                              onPressed: () async {
                                                                                String url = widget.store.instagramLink;

                                                                                if (await canLaunchUrlString(url)) {
                                                                                  await launchUrlString(url);
                                                                                } else {
                                                                                  throw 'Could not launch $url';
                                                                                }
                                                                              },
                                                                              icon: const Icon(FontAwesomeIcons.instagramSquare, color: Color.fromRGBO(233, 89, 80, 1)),
                                                                            ),
                                                                          ),
                                                                        if (widget.store.whatsappLink !=
                                                                            "")
                                                                          SizedBox(
                                                                            height:
                                                                                25,
                                                                            width:
                                                                                25,
                                                                            child:
                                                                                IconButton(
                                                                              padding: const EdgeInsets.all(0),
                                                                              alignment: Alignment.centerRight,
                                                                              onPressed: () async {
                                                                                String url = widget.store.whatsappLink;

                                                                                if (await canLaunchUrlString(url)) {
                                                                                  await launchUrlString(url);
                                                                                } else {
                                                                                  throw 'Could not launch $url';
                                                                                }
                                                                              },
                                                                              icon: const Icon(FontAwesomeIcons.whatsappSquare, color: Color.fromRGBO(40, 209, 70, 1)),
                                                                            ),
                                                                          ),
                                                                        SizedBox(
                                                                          height:
                                                                              25,
                                                                          width:
                                                                              25,
                                                                          child:
                                                                              IconButton(
                                                                            padding:
                                                                                const EdgeInsets.all(0),
                                                                            alignment:
                                                                                Alignment.centerRight,
                                                                            onPressed:
                                                                                () async {
                                                                              if (matchedChat!.isEmpty) {
                                                                                Chat newChat = Chat(chatId: "", user1: user!.uid, user2: widget.store.storeId, message: []);

                                                                                Navigator.push(
                                                                                    context,
                                                                                    MaterialPageRoute(
                                                                                        builder: (context) => UserChatConversation(
                                                                                              chat: newChat,
                                                                                              store: widget.store,
                                                                                            )));
                                                                              } else {
                                                                                Navigator.push(
                                                                                    context,
                                                                                    MaterialPageRoute(
                                                                                        builder: (context) => UserChatConversation(
                                                                                              chat: matchedChat![0],
                                                                                              store: widget.store,
                                                                                            )));
                                                                              }
                                                                            },
                                                                            icon:
                                                                                const Icon(Icons.send, size: 20),
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
                                                                  height: 400,
                                                                  child:
                                                                      StoreTabBar(
                                                                          listingBody:
                                                                              SingleChildScrollView(
                                                                            child: SizedBox(
                                                                                height: 320,
                                                                                child: ListView.builder(
                                                                                    itemCount: matchedStoreItem?.length,
                                                                                    itemBuilder: (context, index) {
                                                                                      return Card(
                                                                                          elevation: 3,
                                                                                          child: InkWell(
                                                                                            onTap: () {
                                                                                              Navigator.push(
                                                                                                  context,
                                                                                                  MaterialPageRoute(
                                                                                                    builder: (context) => ListingDetail(
                                                                                                      listing: matchedStoreItem![index],
                                                                                                    ),
                                                                                                  ));
                                                                                            },
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsets.all(5),
                                                                                              child: ListTile(
                                                                                                title: Text(
                                                                                                  matchedStoreItem![index].listingName,
                                                                                                  style: boldContentTitle,
                                                                                                ),
                                                                                                subtitle: Text(
                                                                                                  matchedStoreItem[index].price == "" ? "RM -" : 'RM ${matchedStoreItem[index].price}',
                                                                                                  style: ratingLabelStyle,
                                                                                                ),
                                                                                                leading: Container(
                                                                                                    width: 100,
                                                                                                    height: 50,
                                                                                                    decoration: const BoxDecoration(
                                                                                                      shape: BoxShape.rectangle,
                                                                                                      color: Color.fromARGB(249, 185, 181, 181),
                                                                                                    ),
                                                                                                    child: ClipRRect(
                                                                                                        child: Image.network(
                                                                                                      matchedStoreItem[index].listingImagePath,
                                                                                                      fit: BoxFit.cover,
                                                                                                    ))),
                                                                                              ),
                                                                                            ),
                                                                                          ));
                                                                                      // );
                                                                                    })),
                                                                          ),
                                                                          reviewBody:
                                                                              SingleChildScrollView(
                                                                            child: SizedBox(
                                                                                height: 350,
                                                                                child: matchedReviews!.isEmpty
                                                                                    ? Padding(
                                                                                        padding: const EdgeInsets.only(top: 10),
                                                                                        child: Row(
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          children: const [
                                                                                            Text(
                                                                                              'No reviews currently.',
                                                                                              style: ratingLabelStyle,
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      )
                                                                                    : ListView.builder(
                                                                                        itemCount: matchedReviews.length,
                                                                                        itemBuilder: (context, index) {
                                                                                          return ReviewComponent(
                                                                                            review: matchedReviews![index],
                                                                                            user: matchedUser[index],
                                                                                            listing: matchedUserItem[index],
                                                                                          );
                                                                                        })),
                                                                          ))),
                                                            ],
                                                          ),
                                                        ),
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
                                  });
                            } else {
                              return const Loading();
                            }
                          });
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

  storeRatingUpdating(double rating) async {
    var a = await FirebaseFirestore.instance
        .collection("store")
        .where("storeId", isEqualTo: widget.store.storeId)
        .get();
    String id = a.docs[0].id;
    await DatabaseService(uid: "").updateStoreRating(id, rating.toString());
  }

  storeSalesUpdating(int sales) async {
    var a = await FirebaseFirestore.instance
        .collection("store")
        .where("storeId", isEqualTo: widget.store.storeId)
        .get();
    String id = a.docs[0].id;
    await DatabaseService(uid: "").updateStoreSales(id, sales);
  }
}
