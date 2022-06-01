import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/components/input_text_box.dart';
import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/modals/alert_text_modal.dart';
import 'package:final_year_project/models/listing_model.dart';
import 'package:final_year_project/models/order_model.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BusinessFullOrder extends StatefulWidget {
  final Order order;
  final String orderNo;

  const BusinessFullOrder(
      {Key? key, required this.order, required this.orderNo})
      : super(key: key);

  @override
  _BusinessFullOrderState createState() => _BusinessFullOrderState();
}

class _BusinessFullOrderState extends State<BusinessFullOrder> {
  double totalPrice = 0;
  double firstPrice = 0;
  double secondPrice = 0;
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
      child: StreamBuilder<UserStoreData>(
          stream: DatabaseService(uid: user?.uid).userStoreData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserStoreData? store = snapshot.data;
              List matchedOrderItem = [];
              List allOrder = [];

              for (int i = 0; i < widget.order.orderItem.length; i++) {
                if (widget.order.orderItem[i]["store"] == store?.storeId) {
                  matchedOrderItem
                      .add({'order': widget.order.orderItem[i], 'index': i});
                }
              }

              return StreamBuilder<List<Listing>>(
                  stream: DatabaseService(uid: "").item,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Listing>? item = snapshot.data;
                      List<Listing>? matchedItem = [];

                      for (int i = 0; i < matchedOrderItem.length; i++) {
                        for (int j = 0; j < item!.length; j++) {
                          if (matchedOrderItem[i]['order']["listing"] ==
                              item[j].listingId) {
                            matchedItem.add(item[j]);
                          }
                        }
                      }

                      for (int i = 0; i < matchedItem.length; i++) {
                        if (i == 0) {
                          firstPrice = (matchedOrderItem[0]['order']
                                  ['quantity'] *
                              double.parse(matchedItem[0].price));
                          totalPrice = firstPrice;
                        } else {
                          secondPrice = (matchedOrderItem[i]['order']
                                  ['quantity'] *
                              double.parse(matchedItem[i].price));
                          totalPrice = totalPrice + secondPrice;
                        }
                      }

                      for (int i = 0; i < widget.order.orderItem.length; i++) {
                        if (allOrder.length < widget.order.orderItem.length) {
                          allOrder.add(widget.order.orderItem[i]);
                        }
                      }

                      // if (orderStatus != "") {
                      //   //print(orderStatus);

                      //   for (int i = 0;
                      //       i < widget.order.orderItem.length;
                      //       i++) {
                      //     // if (widget.order.orderItem[i]["store"] ==
                      //     //     store?.storeId) {
                      //     //   allOrder.add(matchedOrderItem[i]['order']);
                      //     //   print(allOrder[i]['request']);
                      //     // }

                      //     if (widget.order.orderItem[i]['store'] ==
                      //         store?.storeId) {
                      //       for (int j = 0; j < matchedOrderItem.length; j++) {
                      //         // if (widget.order.orderItem[i]['store'] ==
                      //         //     matchedOrderItem[j]['order']['store']) {
                      //         //   allOrder.add(matchedOrderItem[i]['order']);
                      //         // }
                      //       }
                      //     } else {
                      //       allOrder.add(widget.order.orderItem[i]);
                      //     }
                      //   }
                      // }

                      return Scaffold(
                          body: SafeArea(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                        height: 40, child: TopAppBar()),
                                    TitleAppBar(
                                        title: 'Order #${widget.orderNo}',
                                        iconFlex: 4,
                                        titleFlex: 6,
                                        hasArrow: true),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: SizedBox(
                                        height: 510,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    'Order Time: ' +
                                                        widget.order.createdAt,
                                                    style: buttonLabelStyle,
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                height:
                                                    matchedOrderItem.length *
                                                        230,
                                                child: ListView.builder(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemCount:
                                                        matchedOrderItem.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 10),
                                                            child: Row(
                                                                children: [
                                                                  const Text(
                                                                    'Order Status: ',
                                                                    style:
                                                                        priceLabelStyle,
                                                                  ),
                                                                  Text(
                                                                    matchedOrderItem[index]['order']['orderStatus'] ==
                                                                            'To Ship'
                                                                        ? 'New Order!'
                                                                        : matchedOrderItem[index]['order']['orderStatus'] ==
                                                                                'To Receive'
                                                                            ? 'Order Delivered'
                                                                            : 'Completed',
                                                                    style:
                                                                        priceLabelStyle,
                                                                  ),
                                                                ]),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 80,
                                                                height: 80,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          129,
                                                                          89,
                                                                          89,
                                                                          0.98),
                                                                ),
                                                                child:
                                                                    ClipRRect(
                                                                        child: Image
                                                                            .network(
                                                                  matchedItem[
                                                                          index]
                                                                      .listingImagePath,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )),
                                                              ),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 10),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          const Icon(
                                                                              Icons.storefront,
                                                                              size: 15),
                                                                          const SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                260,
                                                                            child:
                                                                                Text(
                                                                              store!.businessName,
                                                                              style: boldContentTitle,
                                                                              overflow: TextOverflow.visible,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                        matchedItem[index]
                                                                            .listingName,
                                                                        style:
                                                                            ratingLabelStyle,
                                                                        overflow:
                                                                            TextOverflow.visible,
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.end,
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Text(
                                                                                'RM ' + matchedItem[index].price,
                                                                                style: priceLabelStyle,
                                                                              ),
                                                                              Text(
                                                                                ' x ' + matchedOrderItem[index]['order']['quantity'].toString(),
                                                                                style: priceLabelStyle,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.end,
                                                                            children: [
                                                                              Text(
                                                                                'Subtotal: RM' + (double.parse(matchedItem[index].price) * matchedOrderItem[index]['order']["quantity"]).toStringAsFixed(2),
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
                                                            height: 10,
                                                          ),
                                                          ProfileTextField(
                                                            textFieldLabel:
                                                                "Remark / Special Request",
                                                            textFieldValue:
                                                                matchedOrderItem[
                                                                            index]
                                                                        [
                                                                        'order']
                                                                    ['request'],
                                                            textFieldLine: 3,
                                                            textFieldHeight: 50,
                                                            isReadOnly: true,
                                                            isBold: true,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 10),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                SizedBox(
                                                                  width: 130,
                                                                  height: 30,
                                                                  child:
                                                                      PurpleTextButton(
                                                                    buttonText:
                                                                        'Change Order Status',
                                                                    onClick:
                                                                        () {
                                                                      showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (context) {
                                                                            return OrderStatusModal(inProgressOnClick:
                                                                                () async {
                                                                              setState(() {
                                                                                orderStatus = "To Receive";
                                                                                matchedOrderItem[index]['order']['orderStatus'] = orderStatus;
                                                                              });

                                                                              for (int i = 0; i < allOrder.length; i++) {
                                                                                if (allOrder[i]['listing'] == matchedOrderItem[index]['order']['listing']) {
                                                                                  allOrder[i] = matchedOrderItem[index]['order'];
                                                                                }
                                                                              }

                                                                              await DatabaseService(uid: user?.uid).updateOrderStatus(allOrder, widget.order.orderId);
                                                                              Navigator.pop(context);
                                                                            }, completedOnClick:
                                                                                () async {
                                                                              setState(() {
                                                                                orderStatus = "Completed";
                                                                                matchedOrderItem[index]['order']['orderStatus'] = orderStatus;
                                                                              });
                                                                              for (int i = 0; i < allOrder.length; i++) {
                                                                                if (allOrder[i]['listing'] == matchedOrderItem[index]['order']['listing']) {
                                                                                  allOrder[i] = matchedOrderItem[index]['order'];
                                                                                }
                                                                              }
                                                                              await DatabaseService(uid: user?.uid).updateOrderStatus(allOrder, widget.order.orderId);
                                                                              Navigator.pop(context);
                                                                            });
                                                                          });
                                                                    },
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
                                                style: boldContentTitle,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const Text(
                                                'Cash on delivery',
                                                style: ratingLabelStyle,
                                              ),
                                              const Divider(
                                                color: Colors.grey,
                                                thickness: 0.5,
                                                height: 20,
                                              ),
                                              const Text(
                                                'Delivery Details:',
                                                style: boldContentTitle,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 4,
                                                        child: ProfileTextField(
                                                          textFieldLabel:
                                                              'Recipient Name',
                                                          textFieldValue: widget
                                                              .order
                                                              .recipientName,
                                                          textFieldLine: 1,
                                                          textFieldHeight: 30,
                                                          isReadOnly: true,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: ProfileTextField(
                                                          textFieldLabel:
                                                              'Phone Number',
                                                          textFieldValue: widget
                                                              .order
                                                              .recipientPhoneNumber,
                                                          textFieldLine: 1,
                                                          textFieldHeight: 30,
                                                          isReadOnly: true,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: ProfileTextField(
                                                          textFieldLabel:
                                                              'Address',
                                                          textFieldValue: widget
                                                              .order
                                                              .recipientAddress,
                                                          textFieldLine: 2,
                                                          textFieldHeight: 50,
                                                          isReadOnly: true,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: ProfileTextField(
                                                          textFieldLabel:
                                                              'Postcode',
                                                          textFieldValue: widget
                                                              .order
                                                              .recipientPostcode,
                                                          textFieldLine: 1,
                                                          textFieldHeight: 30,
                                                          isReadOnly: true,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 4,
                                                        child: ProfileTextField(
                                                          textFieldLabel:
                                                              'City',
                                                          textFieldValue: widget
                                                              .order
                                                              .recipientCity,
                                                          textFieldLine: 1,
                                                          textFieldHeight: 30,
                                                          isReadOnly: true,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child:
                                                              ProfileTextField(
                                                        textFieldLabel: 'State',
                                                        textFieldValue: widget
                                                            .order
                                                            .recipientState,
                                                        textFieldLine: 1,
                                                        textFieldHeight: 30,
                                                        isReadOnly: true,
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
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Text(
                                        'Total: ',
                                        style: boldContentTitle,
                                      ),
                                      Text(
                                        'RM ' + totalPrice.toStringAsFixed(2),
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.bold,
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
          }),
    );
  }
}
