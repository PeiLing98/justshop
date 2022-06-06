import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/pages/make_order/cart_page_component.dart';
import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/components/tab_bar.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/models/cart_model.dart';
import 'package:final_year_project/models/listing_model.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/pages/make_order/place_order.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double totalPrice = 0;
  double firstPrice = 0;
  double secondPrice = 0;

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
      child: StreamBuilder<List<Cart>>(
          stream: DatabaseService(uid: "").cart,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Cart>? cart = snapshot.data;
              List<Cart>? matchedCart = [];
              List<Cart>? matchedSelectedCart = [];

              matchedCart = cart?.where((cart) {
                return cart.userId == userId;
              }).toList();

              matchedSelectedCart = matchedCart?.where((cart) {
                return cart.isSelected == true;
              }).toList();

              return StreamBuilder<List<Listing>>(
                  stream: DatabaseService(uid: "").item,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Listing>? item = snapshot.data;
                      List<Listing>? matchedItem = [];
                      List<Listing>? matchedFoodItem = [];
                      List<Listing>? matchedProductItem = [];
                      List<Listing>? matchedServiceItem = [];
                      List matchedSelectedItem = [];

                      for (int i = 0; i < item!.length; i++) {
                        for (int j = 0; j < matchedCart!.length; j++) {
                          if (item[i].listingId == matchedCart[j].listingId) {
                            matchedItem.add(item[i]);
                          }
                        }
                      }

                      for (var i in matchedItem) {
                        if (i.selectedCategory == "Food") {
                          matchedFoodItem.add(i);
                        } else if (i.selectedCategory == "Product") {
                          matchedProductItem.add(i);
                        } else {
                          matchedServiceItem.add(i);
                        }
                      }

                      for (int i = 0; i < item.length; i++) {
                        for (int j = 0; j < matchedSelectedCart!.length; j++) {
                          if (item[i].listingId ==
                              matchedSelectedCart[j].listingId) {
                            matchedSelectedItem.add({
                              'item': item[i],
                              'cart': matchedSelectedCart[j],
                            });
                          }
                        }
                      }

                      if (matchedSelectedItem.isEmpty) {
                        totalPrice = 0;
                      } else {
                        for (int i = 0; i < matchedSelectedItem.length; i++) {
                          if (i == 0) {
                            firstPrice =
                                (matchedSelectedItem[0]['cart'].quantity *
                                    double.parse(
                                        matchedSelectedItem[0]['item'].price));
                            totalPrice = firstPrice;
                          } else {
                            secondPrice =
                                (matchedSelectedItem[i]['cart'].quantity *
                                    double.parse(
                                        matchedSelectedItem[i]['item'].price));
                            totalPrice = totalPrice + secondPrice;
                          }
                        }
                      }

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
                                  title: 'Cart',
                                  iconFlex: 3,
                                  titleFlex: 4,
                                  hasArrow: true,
                                  onClick: () {
                                    Navigator.pushNamed(
                                        context, '/pagescontroller');
                                  },
                                ),
                                SizedBox(
                                    height: 550,
                                    child: ListingTabBar(
                                      foodBody: SingleChildScrollView(
                                          child: SizedBox(
                                        height: 500,
                                        child: ListView(
                                          children: [
                                            if (matchedFoodItem.isEmpty)
                                              const Center(
                                                child: Text(
                                                  'No food listing is added to your cart.',
                                                  style: ratingLabelStyle,
                                                ),
                                              ),
                                            CartPageComponent(
                                              listing: matchedFoodItem,
                                            )
                                          ],
                                        ),
                                      )),
                                      productBody: SingleChildScrollView(
                                          child: SizedBox(
                                        height: 500,
                                        child: ListView(children: [
                                          if (matchedProductItem.isEmpty)
                                            const Center(
                                              child: Text(
                                                'No product listing is added to your cart.',
                                                style: ratingLabelStyle,
                                              ),
                                            ),
                                          CartPageComponent(
                                            listing: matchedProductItem,
                                          )
                                        ]),
                                      )),
                                      serviceBody: SingleChildScrollView(
                                          child: SizedBox(
                                        height: 500,
                                        child: ListView(
                                          children: [
                                            if (matchedServiceItem.isEmpty)
                                              const Center(
                                                child: Text(
                                                  'No service listing is added to your cart.',
                                                  style: ratingLabelStyle,
                                                ),
                                              ),
                                            CartPageComponent(
                                              listing: matchedServiceItem,
                                            )
                                          ],
                                        ),
                                      )),
                                    )),
                              ],
                            ),
                          )),
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
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'Total: ',
                                          style: boldContentTitle,
                                        ),
                                        Text(
                                          'RM ' +
                                              totalPrice.toStringAsFixed(2) +
                                              ' (${matchedSelectedItem.length})',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.bold,
                                              color: secondaryColor),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                        width: 100,
                                        child: PurpleTextButton(
                                            buttonText: 'Checkout',
                                            onClick: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PlaceOrder(
                                                            selectedCart:
                                                                matchedSelectedItem,
                                                            totalPrice:
                                                                totalPrice,
                                                          )));
                                            }))
                                  ],
                                ),
                              )),
                        ),
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
