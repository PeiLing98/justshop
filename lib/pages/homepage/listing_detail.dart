import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/components/review_component.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/modals/alert_text_modal.dart';
import 'package:final_year_project/models/cart_model.dart';
import 'package:final_year_project/models/listing_model.dart';
import 'package:final_year_project/models/order_model.dart';
import 'package:final_year_project/models/review_model.dart';
import 'package:final_year_project/models/save_list_model.dart';
import 'package:final_year_project/models/store_model.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/pages/homepage/store_listing_detail.dart';
import 'package:final_year_project/services/database.dart';
import 'package:final_year_project/services/dynamic_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ListingDetail extends StatefulWidget {
  final Listing listing;

  const ListingDetail({
    Key? key,
    required this.listing,
  }) : super(key: key);

  @override
  _ListingDetailState createState() => _ListingDetailState();
}

class _ListingDetailState extends State<ListingDetail> {
  int quantity = 1;
  bool isSelected = false;
  double listingAverageRating = 0;
  int sales = 0;

  @override
  void initState() {
    super.initState();
    DynamicLink.initDynamicLink(context);
  }

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<MyUser?>(context)?.uid;

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
              List<Store>? matchedStore;
              matchedStore = store?.where((store) {
                return store.storeId == widget.listing.storeId;
              }).toList();

              return StreamBuilder<List<Review>>(
                  stream: DatabaseService(uid: "").review,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Review>? reviews = snapshot.data;
                      List<Review>? matchedReviews = [];

                      matchedReviews = reviews?.where((review) {
                        return review.listingId == widget.listing.listingId;
                      }).toList();

                      matchedReviews?.sort((b, a) {
                        return a.ratingStar.compareTo(b.ratingStar);
                      });

                      for (int i = 0; i < matchedReviews!.length; i++) {
                        if (i == 0) {
                          listingAverageRating =
                              double.parse(matchedReviews[0].ratingStar);
                        } else {
                          double nextRating = 0;

                          nextRating =
                              double.parse(matchedReviews[i].ratingStar);
                          listingAverageRating =
                              listingAverageRating + nextRating;
                        }
                      }

                      if (matchedReviews.isEmpty) {
                        listingAverageRating = 0;
                      } else {
                        listingAverageRating =
                            listingAverageRating / matchedReviews.length;
                      }

                      listingRatingUpdating(listingAverageRating);

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

                              return StreamBuilder<List<Listing>>(
                                  stream: DatabaseService(uid: "").item,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List<Listing>? item = snapshot.data;
                                      List<Listing>? matchedItem = [];

                                      for (int i = 0;
                                          i < matchedReviews!.length;
                                          i++) {
                                        for (int j = 0; j < item!.length; j++) {
                                          if (matchedReviews[i].listingId ==
                                              item[j].listingId) {
                                            matchedItem.add(item[j]);
                                          }
                                        }
                                      }

                                      return StreamBuilder<List<Order>>(
                                          stream:
                                              DatabaseService(uid: "").order,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              List<Order>? orders =
                                                  snapshot.data;
                                              List<int> matchedOrderQuantity =
                                                  [];

                                              for (int i = 0;
                                                  i < orders!.length;
                                                  i++) {
                                                for (int j = 0;
                                                    j <
                                                        orders[i]
                                                            .orderItem
                                                            .length;
                                                    j++) {
                                                  if (orders[i].orderItem[j]
                                                              ['listing'] ==
                                                          widget.listing
                                                              .listingId &&
                                                      orders[i].orderItem[j]
                                                              ['orderStatus'] ==
                                                          'Completed') {
                                                    matchedOrderQuantity.add(
                                                        orders[i].orderItem[j]
                                                            ['quantity']);
                                                  }
                                                }
                                              }

                                              if (matchedOrderQuantity
                                                  .isNotEmpty) {
                                                if (matchedOrderQuantity
                                                        .length ==
                                                    1) {
                                                  sales =
                                                      matchedOrderQuantity[0];
                                                } else {
                                                  sales = matchedOrderQuantity
                                                      .reduce((a, b) => a + b);
                                                }
                                              }

                                              listingSalesUpdating(sales);

                                              return Scaffold(
                                                body: SafeArea(
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.all(5),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const SizedBox(
                                                            height: 40,
                                                            child: TopAppBar()),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        SizedBox(
                                                          height: 545,
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(children: [
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          150,
                                                                      decoration: BoxDecoration(
                                                                          shape: BoxShape
                                                                              .rectangle,
                                                                          color: const Color.fromARGB(
                                                                              250,
                                                                              233,
                                                                              221,
                                                                              221),
                                                                          border: Border.all(
                                                                              width: 0.5,
                                                                              color: Colors.grey)),
                                                                      child:
                                                                          ClipRRect(
                                                                        child: Image
                                                                            .network(
                                                                          widget
                                                                              .listing
                                                                              .listingImagePath,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          filterQuality:
                                                                              FilterQuality.high,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ]),
                                                                Container(
                                                                  height: 80,
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(15),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => StoreListingDetail(store: matchedStore![0])));
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              width: 50,
                                                                              height: 50,
                                                                              decoration: BoxDecoration(shape: BoxShape.circle, color: const Color.fromARGB(250, 233, 221, 221), border: Border.all(width: 0.5, color: Colors.grey)),
                                                                              child: ClipRRect(
                                                                                borderRadius: BorderRadius.circular(50),
                                                                                child: Image.network(matchedStore![0].imagePath, fit: BoxFit.cover),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                50,
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                matchedStore[0].businessName,
                                                                                style: boldContentTitle,
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          StreamBuilder<List<SaveListModel>>(
                                                                              stream: DatabaseService(uid: "").saveList,
                                                                              builder: (context, snapshot) {
                                                                                if (snapshot.hasData) {
                                                                                  List<SaveListModel>? saveList = snapshot.data;
                                                                                  List<SaveListModel>? matchedSaveList = [];

                                                                                  matchedSaveList = saveList?.where((saveList) {
                                                                                    return saveList.userId == userId && saveList.listingId == widget.listing.listingId;
                                                                                  }).toList();

                                                                                  return IconButton(
                                                                                      padding: const EdgeInsets.all(0),
                                                                                      alignment: Alignment.centerRight,
                                                                                      onPressed: () async {
                                                                                        if (matchedSaveList!.isEmpty) {
                                                                                          showDialog(
                                                                                              context: context,
                                                                                              builder: (context) {
                                                                                                return YesNoAlertModal(
                                                                                                    alertContent: 'Are you sure to save this listing?',
                                                                                                    closeOnClick: () {
                                                                                                      Navigator.pop(context);
                                                                                                    },
                                                                                                    yesOnClick: () async {
                                                                                                      await DatabaseService(uid: userId).addSaveListData(userId!, widget.listing.listingId, widget.listing.storeId);

                                                                                                      Navigator.pop(context);
                                                                                                    },
                                                                                                    noOnClick: () {
                                                                                                      Navigator.pop(context);
                                                                                                    });
                                                                                              });
                                                                                        } else {
                                                                                          showDialog(
                                                                                              context: context,
                                                                                              builder: (context) {
                                                                                                return AlertTextModal(
                                                                                                    alertContent: 'This listing was already saved in your cart before.',
                                                                                                    onClick: () {
                                                                                                      Navigator.pop(context);
                                                                                                    });
                                                                                              });
                                                                                        }
                                                                                      },
                                                                                      icon: Icon(
                                                                                        matchedSaveList!.isNotEmpty ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                                                                                        size: 25,
                                                                                      ));
                                                                                } else {
                                                                                  return const Loading();
                                                                                }
                                                                              }),
                                                                          IconButton(
                                                                              padding: const EdgeInsets.all(0),
                                                                              alignment: Alignment.centerRight,
                                                                              onPressed: () async {
                                                                                String generatedLink = await DynamicLink.createDynamicLink(false, widget.listing);

                                                                                Share.share(generatedLink);

                                                                                //print(generatedLink);
                                                                              },
                                                                              icon: const Icon(
                                                                                Icons.share_outlined,
                                                                                size: 25,
                                                                              ))
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(horizontal: 15),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              widget.listing.listingName,
                                                                              style: boldContentTitle,
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                RatingBar.builder(
                                                                                    allowHalfRating: true,
                                                                                    ignoreGestures: true,
                                                                                    glow: false,
                                                                                    updateOnDrag: true,
                                                                                    initialRating: double.parse(widget.listing.rating),
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
                                                                                const SizedBox(
                                                                                  width: 30,
                                                                                ),
                                                                                Text(
                                                                                  'Sales: ${widget.listing.totalSales}',
                                                                                  style: ratingLabelStyle,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Text(
                                                                                  'RM ${widget.listing.price}',
                                                                                  style: const TextStyle(
                                                                                    fontSize: 12,
                                                                                    fontFamily: 'Roboto',
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(left: 30),
                                                                                  child: Container(
                                                                                    decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(5)),
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                                                      child: Text(
                                                                                        widget.listing.selectedCategory,
                                                                                        style: const TextStyle(fontSize: 10, fontFamily: 'Roboto'),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(left: 5),
                                                                                  child: Container(
                                                                                    decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(5)),
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                                                      child: Text(
                                                                                        widget.listing.selectedSubCategory,
                                                                                        style: const TextStyle(fontSize: 10, fontFamily: 'Roboto'),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            const Text('Description:',
                                                                                style: boldContentTitle),
                                                                            const SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    widget.listing.listingDescription,
                                                                                    style: const TextStyle(fontSize: 12, fontFamily: 'Roboto'),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          15,
                                                                      vertical:
                                                                          10),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        'Review (${matchedReviews?.length})',
                                                                        style:
                                                                            boldContentTitle,
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            160,
                                                                        child: matchedReviews!.isEmpty
                                                                            ? Padding(
                                                                                padding: const EdgeInsets.only(top: 10),
                                                                                child: Row(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                                                    listing: matchedItem[index],
                                                                                  );
                                                                                },
                                                                              ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                bottomNavigationBar: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          boxShadow: <
                                                              BoxShadow>[
                                                        BoxShadow(
                                                            blurRadius: 10,
                                                            color: Colors.grey,
                                                            offset:
                                                                Offset(2, 2))
                                                      ],
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    20),
                                                            topRight:
                                                                Radius.circular(
                                                                    20),
                                                          )),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20),
                                                      topRight:
                                                          Radius.circular(20),
                                                    ),
                                                    child: Container(
                                                      height: 50,
                                                      color: Colors.white,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 10,
                                                          horizontal: 20),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          QuantityButton(
                                                            width: 150,
                                                            height: 30,
                                                            addOnTap: () {
                                                              setState(() {
                                                                quantity++;
                                                              });
                                                            },
                                                            minusOnTap: () {
                                                              setState(() {
                                                                if (quantity >
                                                                    1) {
                                                                  quantity--;
                                                                }
                                                              });
                                                            },
                                                            quantity: quantity,
                                                          ),
                                                          StreamBuilder<
                                                                  List<Cart>>(
                                                              stream:
                                                                  DatabaseService(
                                                                          uid:
                                                                              "")
                                                                      .cart,
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot
                                                                    .hasData) {
                                                                  List<Cart>?
                                                                      cart =
                                                                      snapshot
                                                                          .data;
                                                                  List<Cart>?
                                                                      matchedCart =
                                                                      [];

                                                                  matchedCart =
                                                                      cart?.where(
                                                                          (cart) {
                                                                    return cart.userId ==
                                                                            userId &&
                                                                        cart.listingId ==
                                                                            widget.listing.listingId;
                                                                  }).toList();

                                                                  return SizedBox(
                                                                      width:
                                                                          150,
                                                                      child: PurpleTextButton(
                                                                          buttonText: 'Add To Cart',
                                                                          onClick: () {
                                                                            if (matchedCart!.isEmpty) {
                                                                              showDialog(
                                                                                  context: context,
                                                                                  builder: (context) {
                                                                                    return YesNoAlertModal(
                                                                                        alertContent: 'Are you sure to add this listing to the cart?',
                                                                                        closeOnClick: () {
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                        yesOnClick: () async {
                                                                                          await DatabaseService(uid: userId).addCartData(userId!, widget.listing.listingId, widget.listing.storeId, quantity, isSelected);
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                        noOnClick: () {
                                                                                          Navigator.pop(context);
                                                                                        });
                                                                                  });
                                                                            } else {
                                                                              showDialog(
                                                                                  context: context,
                                                                                  builder: (context) {
                                                                                    return AlertTextModal(
                                                                                        alertContent: 'This listing was already in your cart before.',
                                                                                        onClick: () {
                                                                                          Navigator.pop(context);
                                                                                        });
                                                                                  });
                                                                            }
                                                                          }));
                                                                } else {
                                                                  return const Loading();
                                                                }
                                                              })
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
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

  listingRatingUpdating(double rating) async {
    await DatabaseService(uid: "")
        .updateItemRating(widget.listing.listingId, rating.toString());
  }

  listingSalesUpdating(int sales) async {
    await DatabaseService(uid: "")
        .updateItemSales(widget.listing.listingId, sales);
  }
}
