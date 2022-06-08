import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/components/tab_bar.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/models/order_model.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/pages/profile/business_order/business_order_card.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BusinessOrder extends StatefulWidget {
  const BusinessOrder({Key? key}) : super(key: key);

  @override
  _BusinessOrderState createState() => _BusinessOrderState();
}

class _BusinessOrderState extends State<BusinessOrder> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    return StreamBuilder<UserStoreData>(
      stream: DatabaseService(uid: user?.uid).userStoreData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserStoreData? userStoreData = snapshot.data;

          return StreamBuilder<List<Order>>(
              stream: DatabaseService(uid: "").order,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Order>? order = snapshot.data;
                  List<Order>? matchedOrder = [];
                  List<Order>? newOrder = [];
                  List<Order>? deliveredOrder = [];
                  List<Order>? completedOrder = [];

                  for (int i = 0; i < order!.length; i++) {
                    for (int j = 0; j < order[i].orderItem.length; j++) {
                      if (order[i].orderItem[j]["store"] ==
                          userStoreData?.storeId) {
                        if (!matchedOrder.contains(order[i])) {
                          matchedOrder.add(order[i]);
                        }
                      }
                    }
                  }

                  for (int i = 0; i < matchedOrder.length; i++) {
                    for (int j = 0; j < matchedOrder[i].orderItem.length; j++) {
                      if ((matchedOrder[i].orderItem[j]["orderStatus"] ==
                                  "To Ship" &&
                              matchedOrder[i].orderItem[j]["store"] ==
                                  userStoreData?.storeId) ||
                          (matchedOrder[i].orderItem[j]["orderStatus"] ==
                                  "Preparing" &&
                              matchedOrder[i].orderItem[j]["store"] ==
                                  userStoreData?.storeId)) {
                        if (!newOrder.contains(matchedOrder[i])) {
                          newOrder.add(matchedOrder[i]);
                        }
                      } else if (matchedOrder[i].orderItem[j]["orderStatus"] ==
                              "To Receive" &&
                          matchedOrder[i].orderItem[j]["store"] ==
                              userStoreData?.storeId) {
                        if (!deliveredOrder.contains(matchedOrder[i])) {
                          deliveredOrder.add(matchedOrder[i]);
                        }
                      } else if (matchedOrder[i].orderItem[j]["orderStatus"] ==
                              "Completed" &&
                          matchedOrder[i].orderItem[j]["store"] ==
                              userStoreData?.storeId) {
                        if (!completedOrder.contains(matchedOrder[i])) {
                          completedOrder.add(matchedOrder[i]);
                        }
                      }
                    }
                  }

                  return Scaffold(
                    body: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 40, child: TopAppBar()),
                          Expanded(
                            flex: 1,
                            child: TitleAppBar(
                              title: "Business Order",
                              iconFlex: 3,
                              titleFlex: 6,
                              hasArrow: true,
                              onClick: () {
                                Navigator.pushNamed(context, '/profile');
                              },
                            ),
                          ),
                          Expanded(
                              flex: 12,
                              child: BusinessOrderStatus(
                                newOrderBody: SingleChildScrollView(
                                    child: SizedBox(
                                  height: 520,
                                  child: ListView(
                                    children: [
                                      if (newOrder.isEmpty)
                                        const Center(
                                          child: Text(
                                              'No new orders currently.',
                                              style: ratingLabelStyle),
                                        ),
                                      BusinessOrderCard(
                                        order: newOrder,
                                        storeId: userStoreData!.storeId,
                                      )
                                    ],
                                  ),
                                )),
                                deliveredBody: SingleChildScrollView(
                                    child: SizedBox(
                                  height: 520,
                                  child: ListView(
                                    children: [
                                      if (deliveredOrder.isEmpty)
                                        const Center(
                                          child: Text(
                                              'No orders are delivered currently.',
                                              style: ratingLabelStyle),
                                        ),
                                      BusinessOrderCard(
                                        order: deliveredOrder,
                                        storeId: userStoreData.storeId,
                                      )
                                    ],
                                  ),
                                )),
                                completedBody: SingleChildScrollView(
                                    child: SizedBox(
                                  height: 520,
                                  child: ListView(
                                    children: [
                                      if (completedOrder.isEmpty)
                                        const Center(
                                          child: Text(
                                              'No completed order currently.',
                                              style: ratingLabelStyle),
                                        ),
                                      BusinessOrderCard(
                                        order: completedOrder,
                                        storeId: userStoreData.storeId,
                                      )
                                    ],
                                  ),
                                )),
                              ))
                        ],
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
      },
    );
  }
}
