import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/models/listing_model.dart';
import 'package:final_year_project/models/order_model.dart';
import 'package:final_year_project/models/store_model.dart';
import 'package:final_year_project/pages/profile/user_order/user_full_order.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';

class UserOrderCard extends StatefulWidget {
  final List<Order> order;
  const UserOrderCard({Key? key, required this.order}) : super(key: key);

  @override
  _UserOrderCardState createState() => _UserOrderCardState();
}

class _UserOrderCardState extends State<UserOrderCard> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Listing>>(
        stream: DatabaseService(uid: "").item,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Listing>? item = snapshot.data;
            List<Listing>? matchedItem = [];

            for (int i = 0; i < widget.order.length; i++) {
              // for (int j = 0; j < widget.order[i].orderItem.length; j++) {
              for (int k = 0; k < item!.length; k++) {
                if (widget.order[i].orderItem[0]["listing"] ==
                    item[k].listingId) {
                  matchedItem.add(item[k]);
                }
              }
              // }
            }

            return StreamBuilder<List<Store>>(
                stream: DatabaseService(uid: "").stores,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Store>? store = snapshot.data;
                    List<Store>? matchedStore = [];

                    for (int i = 0; i < widget.order.length; i++) {
                      // for (int j = 0; j < widget.order[i].orderItem.length; j++) {
                      for (int k = 0; k < store!.length; k++) {
                        if (widget.order[i].orderItem[0]["store"] ==
                            store[k].storeId) {
                          matchedStore.add(store[k]);
                        }
                      }
                      // }
                    }

                    return SizedBox(
                      height: 520,
                      child: ListView.builder(
                          itemCount: widget.order.length,
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Order #${index + 1}",
                                          style: buttonLabelStyle,
                                        ),
                                        Text(
                                          "${widget.order[index].orderItem[0]["orderStatus"]}",
                                          style: priceLabelStyle,
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
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
                                            matchedItem[index].listingImagePath,
                                            fit: BoxFit.cover,
                                          )),
                                        ),
                                        Expanded(
                                            child: Padding(
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
                                                  SizedBox(
                                                    width: 230,
                                                    child: Text(
                                                      matchedStore[index]
                                                          .businessName,
                                                      style: buttonLabelStyle,
                                                      overflow:
                                                          TextOverflow.visible,
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
                                                children: [
                                                  Text(
                                                    'RM ' +
                                                        matchedItem[index]
                                                            .price,
                                                    style: priceLabelStyle,
                                                  ),
                                                  Text(
                                                    ' x ' +
                                                        widget
                                                            .order[index]
                                                            .orderItem[0]
                                                                ["quantity"]
                                                            .toString(),
                                                    style: priceLabelStyle,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          height: 30,
                                          child: PurpleTextButton(
                                            buttonText: "View Full Order",
                                            onClick: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UserFullOrder(
                                                              order: widget
                                                                  .order[index],
                                                              orderNo: (index +
                                                                      1)
                                                                  .toString())));
                                            },
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
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
