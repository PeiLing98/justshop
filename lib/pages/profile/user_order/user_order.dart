import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/components/tab_bar.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/models/order_model.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/pages/profile/user_order/user_order_card.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserOrder extends StatefulWidget {
  const UserOrder({Key? key}) : super(key: key);

  @override
  _UserOrderState createState() => _UserOrderState();
}

class _UserOrderState extends State<UserOrder> {
  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<MyUser?>(context)?.uid;

    return StreamBuilder<List<Order>>(
        stream: DatabaseService(uid: "").order,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Order>? order = snapshot.data;
            List<Order>? matchedOrder = [];
            List<Order>? toShipOrder = [];
            List<Order>? toReceiveOrder = [];
            List<Order>? completedOrder = [];

            matchedOrder = order?.where((order) {
              return order.userId == userId;
            }).toList();

            for (int i = 0; i < matchedOrder!.length; i++) {
              for (int j = 0; j < matchedOrder[i].orderItem.length; j++) {
                if (matchedOrder[i].orderItem[j]["orderStatus"] == "To Ship") {
                  if (!toShipOrder.contains(matchedOrder[i])) {
                    toShipOrder.add(matchedOrder[i]);
                  }
                } else if (matchedOrder[i].orderItem[j]["orderStatus"] ==
                    "To Receive") {
                  if (!toReceiveOrder.contains(matchedOrder[i])) {
                    toReceiveOrder.add(matchedOrder[i]);
                  }
                } else {
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
                        title: "Order",
                        iconFlex: 4,
                        titleFlex: 5,
                        hasArrow: true,
                        onClick: () {
                          Navigator.pushNamed(context, '/profile');
                        },
                      ),
                    ),
                    Expanded(
                        flex: 12,
                        child: OrderStatusTabBar(
                          toShipBody: SingleChildScrollView(
                            child: SizedBox(
                              height: 520,
                              child: ListView(
                                children: [
                                  if (toShipOrder.isEmpty)
                                    const Center(
                                      child: Text(
                                          'No orders are being shipped currently.',
                                          style: ratingLabelStyle),
                                    ),
                                  UserOrderCard(order: toShipOrder)
                                ],
                              ),
                            ),
                          ),
                          toReceiveBody: SingleChildScrollView(
                            child: SizedBox(
                              height: 520,
                              child: ListView(
                                children: [
                                  if (toReceiveOrder.isEmpty)
                                    const Center(
                                      child: Text(
                                          'No orders are being received currently.',
                                          style: ratingLabelStyle),
                                    ),
                                  UserOrderCard(order: toReceiveOrder)
                                ],
                              ),
                            ),
                          ),
                          completedBody: SingleChildScrollView(
                            child: SizedBox(
                              height: 520,
                              child: ListView(
                                children: [
                                  if (completedOrder.isEmpty)
                                    const Center(
                                      child: Text(
                                          'No completed orders currently.',
                                          style: ratingLabelStyle),
                                    ),
                                  UserOrderCard(order: completedOrder)
                                ],
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            );
          } else {
            return const Loading();
          }
        });
  }
}
