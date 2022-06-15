import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/components/input_text_box.dart';
import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/modals/alert_text_modal.dart';
import 'package:final_year_project/models/listing_model.dart';
import 'package:final_year_project/models/order_model.dart';
import 'package:final_year_project/models/review_model.dart';
import 'package:final_year_project/models/store_model.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/pages/homepage/store_listing_detail.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class UserFullOrder extends StatefulWidget {
  final Order order;
  final String orderNo;

  const UserFullOrder({Key? key, required this.order, required this.orderNo})
      : super(key: key);

  @override
  _UserFullOrderState createState() => _UserFullOrderState();
}

class _UserFullOrderState extends State<UserFullOrder> {
  double stars = 0;
  String review = "";
  String orderStatus = "";
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
                List<Listing>? matchedItem = [];

                for (int i = 0; i < widget.order.orderItem.length; i++) {
                  for (int j = 0; j < item!.length; j++) {
                    if (widget.order.orderItem[i]["listing"] ==
                        item[j].listingId) {
                      matchedItem.add(item[j]);
                    }
                  }
                }

                return StreamBuilder<List<Store>>(
                    stream: DatabaseService(uid: "").stores,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Store>? store = snapshot.data;
                        List<Store>? matchedStore = [];

                        for (int i = 0;
                            i < widget.order.orderItem.length;
                            i++) {
                          for (int j = 0; j < store!.length; j++) {
                            if (widget.order.orderItem[i]["store"] ==
                                store[j].storeId) {
                              matchedStore.add(store[j]);
                            }
                          }
                        }

                        return StreamBuilder<List<Review>>(
                            stream: DatabaseService(uid: "").review,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<Review>? reviews = snapshot.data;
                                List<Review>? matchedReview = [];
                                List orderedMatchedReview =
                                    List.filled(matchedItem.length, "");
                                List allOrder = [];

                                matchedReview = reviews?.where((review) {
                                  return review.orderId == widget.order.orderId;
                                }).toList();

                                //print(matchedReview?[2].review);

                                for (int i = 0; i < matchedItem.length; i++) {
                                  for (int j = 0;
                                      j < matchedReview!.length;
                                      j++) {
                                    if (matchedItem[i].listingId ==
                                        matchedReview[j].listingId) {
                                      orderedMatchedReview[i] =
                                          matchedReview[j];
                                    }
                                  }
                                }

                                for (int i = 0;
                                    i < widget.order.orderItem.length;
                                    i++) {
                                  if (allOrder.length <
                                      widget.order.orderItem.length) {
                                    allOrder.add(widget.order.orderItem[i]);
                                  }
                                }

                                return Scaffold(
                                    body: SafeArea(
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                  height: 40,
                                                  child: TopAppBar()),
                                              TitleAppBar(
                                                title:
                                                    'Order #${widget.orderNo}',
                                                iconFlex: 4,
                                                titleFlex: 6,
                                                hasArrow: true,
                                                onClick: () {
                                                  Navigator.pushNamed(
                                                      context, '/userorder');
                                                },
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                child: SizedBox(
                                                  height: 510,
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              'Order Time: ' +
                                                                  widget.order
                                                                      .createdAt,
                                                              style:
                                                                  buttonLabelStyle,
                                                            )
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        SizedBox(
                                                          height: orderedMatchedReview
                                                                  .every(
                                                                      (element) {
                                                            return element ==
                                                                "";
                                                          })
                                                              ? widget
                                                                      .order
                                                                      .orderItem
                                                                      .length *
                                                                  230
                                                              : ((widget
                                                                          .order
                                                                          .orderItem
                                                                          .length *
                                                                      230) +
                                                                  (orderedMatchedReview
                                                                          .length *
                                                                      40)),
                                                          child:
                                                              ListView.builder(
                                                                  physics:
                                                                      const NeverScrollableScrollPhysics(),
                                                                  itemCount: widget
                                                                      .order
                                                                      .orderItem
                                                                      .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(bottom: 10),
                                                                          child:
                                                                              Row(children: [
                                                                            Text(
                                                                              'Order Status: ' + widget.order.orderItem[index]['orderStatus'],
                                                                              style: priceLabelStyle,
                                                                            ),
                                                                          ]),
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Container(
                                                                              width: 80,
                                                                              height: 80,
                                                                              decoration: const BoxDecoration(
                                                                                shape: BoxShape.rectangle,
                                                                                color: Color.fromRGBO(129, 89, 89, 0.98),
                                                                              ),
                                                                              child: ClipRRect(
                                                                                  child: Image.network(
                                                                                matchedItem[index].listingImagePath,
                                                                                fit: BoxFit.cover,
                                                                              )),
                                                                            ),
                                                                            Expanded(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(left: 10),
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Row(
                                                                                      children: [
                                                                                        const Icon(Icons.storefront, size: 15),
                                                                                        const SizedBox(
                                                                                          width: 5,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 260,
                                                                                          child: Text(
                                                                                            matchedStore[index].businessName,
                                                                                            style: boldContentTitle,
                                                                                            overflow: TextOverflow.visible,
                                                                                          ),
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      height: 10,
                                                                                    ),
                                                                                    Text(
                                                                                      matchedItem[index].listingName,
                                                                                      style: ratingLabelStyle,
                                                                                      overflow: TextOverflow.visible,
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      height: 10,
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                                                      children: [
                                                                                        Row(
                                                                                          children: [
                                                                                            Text(
                                                                                              'RM ' + (matchedItem[index].price == "" ? '-' : matchedItem[index].price),
                                                                                              style: priceLabelStyle,
                                                                                            ),
                                                                                            Text(
                                                                                              ' x ' + widget.order.orderItem[index]['quantity'].toString(),
                                                                                              style: priceLabelStyle,
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                                                          children: [
                                                                                            Text(
                                                                                              'Subtotal: RM' + (double.parse(matchedItem[index].price == "" ? '0' : matchedItem[index].price) * widget.order.orderItem[index]["quantity"]).toStringAsFixed(2),
                                                                                              style: priceLabelStyle,
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        ProfileTextField(
                                                                          textFieldLabel:
                                                                              "Remark / Special Request",
                                                                          textFieldValue: widget
                                                                              .order
                                                                              .orderItem[index]['request'],
                                                                          textFieldLine:
                                                                              3,
                                                                          textFieldHeight:
                                                                              50,
                                                                          isReadOnly:
                                                                              true,
                                                                          isBold:
                                                                              true,
                                                                        ),
                                                                        if (orderedMatchedReview[index] !=
                                                                            "")
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  const Text(
                                                                                    'Review: ',
                                                                                    style: buttonLabelStyle,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 325,
                                                                                    child: Text(
                                                                                      orderedMatchedReview[index].review,
                                                                                      style: ratingLabelStyle,
                                                                                      overflow: TextOverflow.visible,
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              const SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  const Text(
                                                                                    'Rating: ',
                                                                                    style: buttonLabelStyle,
                                                                                  ),
                                                                                  RatingBar.builder(
                                                                                    glow: false,
                                                                                    updateOnDrag: true,
                                                                                    initialRating: double.parse(orderedMatchedReview[index].ratingStar),
                                                                                    unratedColor: Colors.grey[300],
                                                                                    minRating: 1,
                                                                                    itemSize: 15,
                                                                                    itemBuilder: (context, _) => const Icon(
                                                                                      Icons.star,
                                                                                      color: secondaryColor,
                                                                                    ),
                                                                                    onRatingUpdate: (val) {},
                                                                                    ignoreGestures: true,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              const SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(bottom: 10),
                                                                          child:
                                                                              Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              SizedBox(
                                                                                width: 100,
                                                                                height: 30,
                                                                                child: PurpleTextButton(
                                                                                  buttonText: 'Contact Seller',
                                                                                  onClick: () {
                                                                                    Navigator.push(
                                                                                        context,
                                                                                        MaterialPageRoute(
                                                                                            builder: (context) => StoreListingDetail(
                                                                                                  store: matchedStore[index],
                                                                                                )));
                                                                                  },
                                                                                ),
                                                                              ),
                                                                              if (widget.order.orderItem[index]['orderStatus'] == "To Receive")
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(left: 10),
                                                                                  child: SizedBox(
                                                                                    width: 100,
                                                                                    height: 30,
                                                                                    child: PurpleTextButton(
                                                                                      buttonText: 'Order Received',
                                                                                      onClick: () {
                                                                                        showDialog(
                                                                                            context: context,
                                                                                            builder: (context) {
                                                                                              return YesNoAlertModal(
                                                                                                  alertContent: 'Have you received the order?',
                                                                                                  closeOnClick: () {
                                                                                                    Navigator.pop(context);
                                                                                                  },
                                                                                                  yesOnClick: () async {
                                                                                                    setState(() {
                                                                                                      orderStatus = "Completed";
                                                                                                      widget.order.orderItem[index]['orderStatus'] = orderStatus;
                                                                                                    });

                                                                                                    for (int i = 0; i < allOrder.length; i++) {
                                                                                                      if (allOrder[i]['listing'] == widget.order.orderItem[index]['listing']) {
                                                                                                        allOrder[i] = widget.order.orderItem[index];
                                                                                                      }
                                                                                                    }

                                                                                                    await DatabaseService(uid: user?.uid).updateOrderStatus(allOrder, widget.order.orderId);
                                                                                                    Navigator.pop(context);
                                                                                                  },
                                                                                                  noOnClick: () {
                                                                                                    Navigator.pop(context);
                                                                                                  });
                                                                                            });
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              if (orderedMatchedReview[index] == "" && widget.order.orderItem[index]['orderStatus'] == "Completed")
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(left: 10),
                                                                                  child: SizedBox(
                                                                                    width: 100,
                                                                                    height: 30,
                                                                                    child: PurpleTextButton(
                                                                                      buttonText: 'Write a review',
                                                                                      onClick: () {
                                                                                        showDialog(
                                                                                            context: context,
                                                                                            builder: (context) {
                                                                                              return ReviewModal(
                                                                                                updateStars: (rating) {
                                                                                                  stars = rating;
                                                                                                  print(stars);
                                                                                                },
                                                                                                reviewUpdate: (val) {
                                                                                                  setState(() {
                                                                                                    review = val;
                                                                                                    print(review);
                                                                                                  });
                                                                                                },
                                                                                                confirmOnClick: () async {
                                                                                                  await DatabaseService(uid: user?.uid).addReviewData(widget.order.userId, widget.order.orderItem[index]['store'], widget.order.orderItem[index]['listing'], widget.order.orderId, stars.toString(), review);
                                                                                                  Navigator.pop(context);
                                                                                                },
                                                                                              );
                                                                                            });
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                            ],
                                                                          ),
                                                                        )
                                                                      ],
                                                                    );
                                                                  }),
                                                        ),
                                                        const Divider(
                                                          color: Colors.grey,
                                                          thickness: 0.5,
                                                          height: 20,
                                                        ),
                                                        const Text(
                                                          'Payment Method: ',
                                                          style:
                                                              boldContentTitle,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        const Text(
                                                          'Cash on delivery',
                                                          style:
                                                              ratingLabelStyle,
                                                        ),
                                                        const Divider(
                                                          color: Colors.grey,
                                                          thickness: 0.5,
                                                          height: 20,
                                                        ),
                                                        const Text(
                                                          'Delivery Details:',
                                                          style:
                                                              boldContentTitle,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  flex: 4,
                                                                  child:
                                                                      ProfileTextField(
                                                                    textFieldLabel:
                                                                        'Recipient Name',
                                                                    textFieldValue:
                                                                        widget
                                                                            .order
                                                                            .recipientName,
                                                                    textFieldLine:
                                                                        1,
                                                                    textFieldHeight:
                                                                        30,
                                                                    isReadOnly:
                                                                        true,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                      ProfileTextField(
                                                                    textFieldLabel:
                                                                        'Phone Number',
                                                                    textFieldValue:
                                                                        widget
                                                                            .order
                                                                            .recipientPhoneNumber,
                                                                    textFieldLine:
                                                                        1,
                                                                    textFieldHeight:
                                                                        30,
                                                                    isReadOnly:
                                                                        true,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      ProfileTextField(
                                                                    textFieldLabel:
                                                                        'Address',
                                                                    textFieldValue:
                                                                        widget
                                                                            .order
                                                                            .recipientAddress,
                                                                    textFieldLine:
                                                                        2,
                                                                    textFieldHeight:
                                                                        50,
                                                                    isReadOnly:
                                                                        true,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                      ProfileTextField(
                                                                    textFieldLabel:
                                                                        'Postcode',
                                                                    textFieldValue:
                                                                        widget
                                                                            .order
                                                                            .recipientPostcode,
                                                                    textFieldLine:
                                                                        1,
                                                                    textFieldHeight:
                                                                        30,
                                                                    isReadOnly:
                                                                        true,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Expanded(
                                                                  flex: 4,
                                                                  child:
                                                                      ProfileTextField(
                                                                    textFieldLabel:
                                                                        'City',
                                                                    textFieldValue:
                                                                        widget
                                                                            .order
                                                                            .recipientCity,
                                                                    textFieldLine:
                                                                        1,
                                                                    textFieldHeight:
                                                                        30,
                                                                    isReadOnly:
                                                                        true,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                    child:
                                                                        ProfileTextField(
                                                                  textFieldLabel:
                                                                      'State',
                                                                  textFieldValue:
                                                                      widget
                                                                          .order
                                                                          .recipientState,
                                                                  textFieldLine:
                                                                      1,
                                                                  textFieldHeight:
                                                                      30,
                                                                  isReadOnly:
                                                                      true,
                                                                ))
                                                              ],
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    bottomNavigationBar: Container(
                                        decoration: const BoxDecoration(
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  blurRadius: 10,
                                                  color: Colors.grey,
                                                  offset: Offset(2, 2))
                                            ],
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            )),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                          child: Container(
                                            height: 50,
                                            color: Colors.white,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                const Text(
                                                  'Total: ',
                                                  style: boldContentTitle,
                                                ),
                                                Text(
                                                  'RM ' +
                                                      widget.order.totalPrice,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: secondaryColor),
                                                )
                                              ],
                                            ),
                                          ),
                                        )));
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
            }));
  }
}
