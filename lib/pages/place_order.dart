import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/models/store_model.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';

class PlaceOrder extends StatefulWidget {
  final List selectedCart;
  final double totalPrice;
  const PlaceOrder(
      {Key? key, required this.selectedCart, required this.totalPrice})
      : super(key: key);

  @override
  _PlaceOrderState createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
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
              List<Store>? matchedStore = [];

              for (int i = 0; i < widget.selectedCart.length; i++) {
                for (int j = 0; j < store!.length; j++) {
                  if (widget.selectedCart[i]['item'].storeId ==
                      store[j].storeId) {
                    matchedStore.add(store[j]);
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
                          const TitleAppBar(
                              title: 'Check Out',
                              iconFlex: 3,
                              titleFlex: 5,
                              hasArrow: true),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: SizedBox(
                              height: 550,
                              child: ListView.builder(
                                  itemCount: widget.selectedCart.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 80,
                                            height: 80,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: Color.fromRGBO(
                                                  129, 89, 89, 0.98),
                                            ),
                                            child: ClipRRect(
                                                child: Image.network(
                                              widget.selectedCart[index]['item']
                                                  .listingImagePath,
                                              fit: BoxFit.cover,
                                            )),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(Icons.storefront,
                                                        size: 15),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      matchedStore[index]
                                                          .businessName,
                                                      style: buttonLabelStyle,
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  widget
                                                      .selectedCart[index]
                                                          ['item']
                                                      .listingName,
                                                  style: ratingLabelStyle,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'RM ' +
                                                      widget
                                                          .selectedCart[index]
                                                              ['item']
                                                          .price,
                                                  style: priceLabelStyle,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          )
                          // Text(widget.selectedCart[0]['item'].listingName),
                          // Text(widget.totalPrice.toString()),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return const Loading();
            }
          }),
    );
  }
}
