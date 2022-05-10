import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/constant.dart';
import 'package:flutter/material.dart';

class CartPageComponent extends StatefulWidget {
  const CartPageComponent({Key? key}) : super(key: key);

  @override
  _CartPageComponentState createState() => _CartPageComponentState();
}

class _CartPageComponentState extends State<CartPageComponent> {
  @override
  Widget build(BuildContext context) {
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
                  const Text(
                    'Store Name',
                    style: boldContentTitle,
                  ),
                  IconButton(
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.all(0),
                      onPressed: () {},
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
              height: 180,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return const CartListingComponent();
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class CartListingComponent extends StatefulWidget {
  const CartListingComponent({Key? key}) : super(key: key);

  @override
  _CartListingComponentState createState() => _CartListingComponentState();
}

class _CartListingComponentState extends State<CartListingComponent> {
  int quantity = 1;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: Color.fromRGBO(129, 89, 89, 0.98),
            ),
            child: const ClipRRect(
                // child: Image.network(
                //   store[index].imagePath,
                //   fit: BoxFit.cover,
                // )
                ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SizedBox(
              height: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 240,
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                            flex: 8,
                            child: Text(
                              'Listing Name',
                              style: buttonLabelStyle,
                            )),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                              alignment: Alignment.topRight,
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                setState(() {
                                  isSelected = !isSelected;
                                });
                              },
                              icon: Icon(
                                isSelected == false
                                    ? Icons.check_box_outline_blank
                                    : Icons.check_box_outlined,
                                size: 18,
                              )),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                              alignment: Alignment.topRight,
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              icon: const Icon(
                                Icons.delete,
                                size: 18,
                              )),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: SizedBox(
                      width: 240,
                      height: 30,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Expanded(
                                child: Text(
                              '123',
                              style: ratingLabelStyle,
                            )),
                          ]),
                    ),
                  ),
                  SizedBox(
                    width: 240,
                    height: 20,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'RM100',
                          style: priceLabelStyle,
                        ),
                        QuantityButton(
                          width: 80,
                          height: 20,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
