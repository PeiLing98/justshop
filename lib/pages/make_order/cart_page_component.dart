import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/modals/alert_text_modal.dart';
import 'package:final_year_project/models/cart_model.dart';
import 'package:final_year_project/models/listing_model.dart';
import 'package:final_year_project/models/store_model.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/pages/homepage/listing_detail.dart';
import 'package:final_year_project/pages/homepage/store_listing_detail.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPageComponent extends StatefulWidget {
  final List<Listing> listing;

  const CartPageComponent({Key? key, required this.listing}) : super(key: key);

  @override
  _CartPageComponentState createState() => _CartPageComponentState();
}

class _CartPageComponentState extends State<CartPageComponent> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<MyUser?>(context)?.uid;
    return StreamBuilder<List<Store>>(
        stream: DatabaseService(uid: "").stores,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Store>? store = snapshot.data;
            List matchedStore = [];
            // List distinctStore = [];
            // List<Listing>? matchedListing = [];
            // List<List<Listing>>? list = [];

            for (int i = 0; i < store!.length; i++) {
              for (int j = 0; j < widget.listing.length; j++) {
                if (store[i].storeId == widget.listing[j].storeId) {
                  matchedStore
                      .add({'store': store[i], 'listing': widget.listing[j]});
                }
              }
            }

            // distinctStore = matchedStore.toSet().toList();

            // for (int i = 0; i < distinctStore.length; i++) {
            //   //matchedListing.clear();

            //   for (int j = 0; j < widget.listing.length; j++) {
            //     if (distinctStore[i].storeId == widget.listing[j].storeId) {
            //       matchedListing.add(widget.listing[j]);
            //       print(matchedListing[i]);

            //       //print(matchedListing[0].listingName);
            //     }
            //   }
            //   list.add(matchedListing);
            // }

            return SingleChildScrollView(
              child: SizedBox(
                height: 470,
                child: ListView.builder(
                    itemCount: matchedStore.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      matchedStore[index]['store'].businessName,
                                      style: boldContentTitle,
                                    ),
                                    IconButton(
                                        alignment: Alignment.topCenter,
                                        padding: const EdgeInsets.all(0),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      StoreListingDetail(
                                                          store: matchedStore[
                                                                  index]
                                                              ['store'])));
                                        },
                                        icon: const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 16,
                                        ))
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 85,
                                child: StreamBuilder<List<Cart>>(
                                    stream: DatabaseService(uid: "").cart,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        List<Cart>? cart = snapshot.data;
                                        Cart? matchedCart;

                                        matchedCart = cart?.where((cart) {
                                          return cart.userId == userId &&
                                              cart.listingId ==
                                                  matchedStore[index]['listing']
                                                      .listingId;
                                        }).first;

                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ListingDetail(
                                                                listing: matchedStore[
                                                                        index]
                                                                    ['listing'],
                                                              )));
                                                },
                                                child: Container(
                                                  width: 80,
                                                  height: 80,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    color: Color.fromRGBO(
                                                        129, 89, 89, 0.98),
                                                  ),
                                                  child: ClipRRect(
                                                      child: Image.network(
                                                    matchedStore[index]
                                                            ['listing']
                                                        .listingImagePath,
                                                    fit: BoxFit.cover,
                                                  )),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: SizedBox(
                                                  height: 80,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: 240,
                                                        height: 20,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Expanded(
                                                                flex: 8,
                                                                child: Text(
                                                                  matchedStore[
                                                                              index]
                                                                          [
                                                                          'listing']
                                                                      .listingName,
                                                                  style:
                                                                      buttonLabelStyle,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                )),
                                                            Expanded(
                                                              flex: 1,
                                                              child: IconButton(
                                                                  alignment: Alignment
                                                                      .topRight,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  onPressed:
                                                                      () async {
                                                                    setState(
                                                                        () {
                                                                      isSelected =
                                                                          !isSelected;
                                                                    });

                                                                    await DatabaseService(
                                                                            uid:
                                                                                userId)
                                                                        .updateCartSelectedListing(
                                                                            isSelected,
                                                                            matchedCart!.cartId);
                                                                  },
                                                                  icon: Icon(
                                                                    matchedCart!.isSelected ==
                                                                            true
                                                                        ? Icons
                                                                            .check_box_outlined
                                                                        : Icons
                                                                            .check_box_outline_blank,
                                                                    size: 18,
                                                                  )),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: IconButton(
                                                                  alignment:
                                                                      Alignment
                                                                          .topRight,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  onPressed:
                                                                      () {
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return YesNoAlertModal(
                                                                              alertContent: 'Are you sure to remove this listing from your cart?',
                                                                              closeOnClick: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              yesOnClick: () async {
                                                                                await DatabaseService(uid: userId).deleteCartData(matchedCart!.cartId);
                                                                                Navigator.pop(context);
                                                                              },
                                                                              noOnClick: () {
                                                                                Navigator.pop(context);
                                                                              });
                                                                        });
                                                                  },
                                                                  icon:
                                                                      const Icon(
                                                                    Icons
                                                                        .delete,
                                                                    size: 18,
                                                                  )),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 0,
                                                                bottom: 5),
                                                        child: SizedBox(
                                                          height: 25,
                                                          child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SelectedFilterOption(
                                                                  buttonText: matchedStore[
                                                                              index]
                                                                          [
                                                                          'listing']
                                                                      .selectedSubCategory,
                                                                  isClose:
                                                                      false,
                                                                ),
                                                              ]),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5),
                                                        child: SizedBox(
                                                          width: 240,
                                                          height: 20,
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'RM ${matchedStore[index]['listing'].price}',
                                                                style:
                                                                    priceLabelStyle,
                                                              ),
                                                              QuantityButton(
                                                                width: 80,
                                                                height: 20,
                                                                addOnTap:
                                                                    () async {
                                                                  await DatabaseService(
                                                                          uid:
                                                                              userId)
                                                                      .updateCartQuantity(
                                                                          (matchedCart!.quantity) +
                                                                              1,
                                                                          matchedCart
                                                                              .cartId);
                                                                },
                                                                minusOnTap:
                                                                    () async {
                                                                  if (matchedCart!
                                                                          .quantity >
                                                                      1) {
                                                                    await DatabaseService(uid: userId).updateCartQuantity(
                                                                        (matchedCart.quantity) -
                                                                            1,
                                                                        matchedCart
                                                                            .cartId);
                                                                  }
                                                                },
                                                                quantity:
                                                                    matchedCart
                                                                        .quantity,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      } else {
                                        return const Loading();
                                      }
                                    }),

                                // ListView.builder(
                                //     physics:
                                //         const NeverScrollableScrollPhysics(),
                                //     itemCount: widget.listing.length,
                                //     itemBuilder: (context, index) {
                                //       return FoodCartListingComponent(
                                //         item: widget.listing[index],
                                //       );
                                //     }),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            );
          } else {
            return const Loading();
          }
        });
  }
}
