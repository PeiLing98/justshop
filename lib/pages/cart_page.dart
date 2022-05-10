import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/components/cart_page_component.dart';
import 'package:final_year_project/components/tab_bar.dart';
import 'package:final_year_project/constant.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40, child: TopAppBar()),
                const TitleAppBar(
                    title: 'Cart', iconFlex: 2, titleFlex: 3, hasArrow: true),
                SizedBox(
                    height: 550,
                    child: ListingTabBar(
                      foodBody: SingleChildScrollView(
                          child: SizedBox(
                        height: 500,
                        child: ListView.builder(
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return const CartPageComponent();
                          },
                        ),
                      )),
                      productBody: SingleChildScrollView(
                          child: SizedBox(
                        height: 500,
                        child: ListView.builder(
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return const CartPageComponent();
                          },
                        ),
                      )),
                      serviceBody: SingleChildScrollView(
                          child: SizedBox(
                        height: 500,
                        child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return const CartPageComponent();
                          },
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
                    blurRadius: 10, color: Colors.grey, offset: Offset(2, 2))
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
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Text(
                          'Total: ',
                          style: boldContentTitle,
                        ),
                        Text(
                          'RM100',
                          style: TextStyle(
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
                            buttonText: 'Checkout', onClick: () {}))
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
