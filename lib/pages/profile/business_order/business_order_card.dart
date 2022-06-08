import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/models/listing_model.dart';
import 'package:final_year_project/models/order_model.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/pages/profile/business_order/business_full_order.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';

class BusinessOrderCard extends StatefulWidget {
  final List<Order> order;
  final String storeId;
  const BusinessOrderCard(
      {Key? key, required this.order, required this.storeId})
      : super(key: key);

  @override
  _BusinessOrderCardState createState() => _BusinessOrderCardState();
}

class _BusinessOrderCardState extends State<BusinessOrderCard> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<AllUser>>(
        stream: DatabaseService(uid: "").allUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<AllUser>? allUser = snapshot.data;
            List<AllUser>? matchedUser = [];

            for (int i = 0; i < widget.order.length; i++) {
              for (int k = 0; k < allUser!.length; k++) {
                if (widget.order[i].userId == allUser[k].userId) {
                  matchedUser.add(allUser[k]);
                }
              }
            }

            return StreamBuilder<List<Listing>>(
                stream: DatabaseService(uid: "").item,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Listing>? item = snapshot.data;
                    List<Listing>? matchedItem = [];
                    List matchedOrderStatus = [];

                    for (int i = 0; i < widget.order.length; i++) {
                      for (int k = 0;
                          k < widget.order[i].orderItem.length;
                          k++) {
                        if (widget.order[i].orderItem[k]['store'] ==
                            widget.storeId) {
                          for (int j = 0; j < item!.length; j++) {
                            if (widget.order[i].orderItem[k]['listing'] ==
                                    item[j].listingId &&
                                !(matchedItem.length == i + 1)) {
                              matchedItem.add(item[j]);
                            }
                          }
                        }
                      }
                    }

                    for (int i = 0; i < widget.order.length; i++) {
                      for (int j = 0;
                          j < widget.order[i].orderItem.length;
                          j++) {
                        if (widget.order[i].orderItem[j]['store'] ==
                            widget.storeId) {
                          for (int k = 0; k < matchedItem.length; k++) {
                            if (widget.order[i].orderItem[j]['listing'] ==
                                    matchedItem[k].listingId &&
                                !(matchedOrderStatus.length == i + 1)) {
                              matchedOrderStatus.add(
                                  widget.order[i].orderItem[j]['orderStatus']);
                            }
                          }
                        }
                      }
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
                                          'Order #${index + 1}',
                                          style: buttonLabelStyle,
                                        ),
                                        Text(
                                          matchedOrderStatus[index] == "To Ship"
                                              ? 'New Order!'
                                              : matchedOrderStatus[index] ==
                                                      "Preparing"
                                                  ? 'Preparing'
                                                  : matchedOrderStatus[index] ==
                                                          "To Receive"
                                                      ? 'Order Delivered'
                                                      : "Completed",
                                          style: priceLabelStyle,
                                        ),
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
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    'Order placed by: ',
                                                    style: buttonLabelStyle,
                                                  ),
                                                  Text(
                                                    matchedUser[index].username,
                                                    style: ratingLabelStyle,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(children: [
                                                const Text(
                                                  'Contact number: ',
                                                  style: buttonLabelStyle,
                                                ),
                                                Text(
                                                  matchedUser[index]
                                                      .phoneNumber,
                                                  style: ratingLabelStyle,
                                                ),
                                              ]),
                                            ],
                                          ),
                                        ))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
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
                                                          BusinessFullOrder(
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
