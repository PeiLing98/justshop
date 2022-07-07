import 'package:final_year_project/constant.dart';
import 'package:final_year_project/models/category_model.dart';
import 'package:flutter/material.dart';

class ListingTabBar extends StatefulWidget {
  final Widget foodBody;
  final Widget productBody;
  final Widget serviceBody;

  const ListingTabBar(
      {Key? key,
      required this.foodBody,
      required this.productBody,
      required this.serviceBody})
      : super(key: key);

  @override
  _ListingTabBarState createState() => _ListingTabBarState();
}

class _ListingTabBarState extends State<ListingTabBar> {
  final category = Category();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            labelColor: Colors.black,
            labelStyle: buttonLabelStyle,
            unselectedLabelColor: Colors.grey,
            indicatorColor: secondaryColor,
            indicatorWeight: 3,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
            tabs: [
              Tab(
                text: 'FOOD',
                height: 30,
              ),
              Tab(
                text: 'PRODUCT',
                height: 30,
              ),
              Tab(
                text: 'SERVICE',
                height: 30,
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: TabBarView(children: [
                widget.foodBody,
                widget.productBody,
                widget.serviceBody
              ]),
            ),
          )
        ],
      ),
    );
  }
}

class FilterTabBar extends StatefulWidget {
  final Widget filterOption;
  final Widget locationOption;

  const FilterTabBar({
    Key? key,
    required this.filterOption,
    required this.locationOption,
  }) : super(key: key);

  @override
  _FilterTabBarState createState() => _FilterTabBarState();
}

class _FilterTabBarState extends State<FilterTabBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            labelColor: Colors.black,
            labelStyle: boldContentTitle,
            unselectedLabelColor: Colors.grey,
            indicatorColor: secondaryColor,
            indicatorWeight: 3,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
            tabs: [
              Tab(
                text: 'CATEGORIES',
                height: 30,
              ),
              Tab(
                text: 'LOCATION',
                height: 30,
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: TabBarView(children: [
                widget.filterOption,
                widget.locationOption,
              ]),
            ),
          )
        ],
      ),
    );
  }
}

class StoreTabBar extends StatefulWidget {
  final Widget aboutUs;
  final Widget listingBody;
  final Widget reviewBody;

  const StoreTabBar(
      {Key? key,
      required this.listingBody,
      required this.reviewBody,
      required this.aboutUs})
      : super(key: key);

  @override
  _StoreTabBarState createState() => _StoreTabBarState();
}

class _StoreTabBarState extends State<StoreTabBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            labelColor: Colors.black,
            labelStyle: buttonLabelStyle,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black,
            indicatorWeight: 3,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
            tabs: [
              Tab(
                text: 'ABOUT US',
                height: 30,
              ),
              Tab(
                text: 'LISTINGS',
                height: 30,
              ),
              Tab(
                text: 'REVIEWS',
                height: 30,
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: TabBarView(children: [
                widget.aboutUs,
                widget.listingBody,
                widget.reviewBody,
              ]),
            ),
          )
        ],
      ),
    );
  }
}

class RatingMonthTabBar extends StatefulWidget {
  final String latestFirstMonth;
  final String latestSecondMonth;
  final String latestThirdMonth;
  final Widget latestFirstMonthBody;
  final Widget latestSecondMonthBody;
  final Widget latestThirdMonthBody;

  const RatingMonthTabBar(
      {Key? key,
      required this.latestFirstMonth,
      required this.latestSecondMonth,
      required this.latestThirdMonth,
      required this.latestFirstMonthBody,
      required this.latestSecondMonthBody,
      required this.latestThirdMonthBody})
      : super(key: key);

  @override
  _RatingMonthTabBarState createState() => _RatingMonthTabBarState();
}

class _RatingMonthTabBarState extends State<RatingMonthTabBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            labelColor: Colors.black,
            labelStyle: boldContentTitle,
            unselectedLabelColor: Colors.grey,
            indicatorColor: secondaryColor,
            indicatorWeight: 3,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 20),
            tabs: [
              Tab(
                text: widget.latestThirdMonth,
                height: 30,
              ),
              Tab(
                text: widget.latestSecondMonth,
                height: 30,
              ),
              Tab(
                text: widget.latestFirstMonth,
                height: 30,
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: TabBarView(children: [
                widget.latestThirdMonthBody,
                widget.latestSecondMonthBody,
                widget.latestFirstMonthBody
              ]),
            ),
          )
        ],
      ),
    );
  }
}

class OrderStatusTabBar extends StatefulWidget {
  final Widget toShipBody;
  final Widget toReceiveBody;
  final Widget completedBody;

  const OrderStatusTabBar(
      {Key? key,
      required this.toShipBody,
      required this.toReceiveBody,
      required this.completedBody})
      : super(key: key);

  @override
  _OrderStatusTabBarState createState() => _OrderStatusTabBarState();
}

class _OrderStatusTabBarState extends State<OrderStatusTabBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            labelColor: Colors.black,
            labelStyle: buttonLabelStyle,
            unselectedLabelColor: Colors.grey,
            indicatorColor: secondaryColor,
            indicatorWeight: 3,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
            tabs: [
              Tab(
                text: 'To Ship',
                height: 30,
              ),
              Tab(
                text: 'To Receive',
                height: 30,
              ),
              Tab(
                text: 'Completed',
                height: 30,
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: TabBarView(children: [
                widget.toShipBody,
                widget.toReceiveBody,
                widget.completedBody
              ]),
            ),
          )
        ],
      ),
    );
  }
}

class BusinessOrderStatus extends StatefulWidget {
  final Widget newOrderBody;
  final Widget deliveredBody;
  final Widget completedBody;

  const BusinessOrderStatus(
      {Key? key,
      required this.newOrderBody,
      required this.deliveredBody,
      required this.completedBody})
      : super(key: key);

  @override
  _BusinessOrderStatusState createState() => _BusinessOrderStatusState();
}

class _BusinessOrderStatusState extends State<BusinessOrderStatus> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            labelColor: Colors.black,
            labelStyle: buttonLabelStyle,
            unselectedLabelColor: Colors.grey,
            indicatorColor: secondaryColor,
            indicatorWeight: 3,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
            tabs: [
              Tab(
                text: 'New Order',
                height: 30,
              ),
              Tab(
                text: ' Delivered Order',
                height: 30,
              ),
              Tab(
                text: 'Completed Order',
                height: 30,
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: TabBarView(children: [
                widget.newOrderBody,
                widget.deliveredBody,
                widget.completedBody
              ]),
            ),
          )
        ],
      ),
    );
  }
}
