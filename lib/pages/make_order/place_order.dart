import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/components/input_text_box.dart';
import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/modals/alert_text_modal.dart';
import 'package:final_year_project/models/store_model.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/pages/profile/user_order/user_order.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  final _formKey = GlobalKey<FormState>();

  List<String>? requestList;
  String orderStatus = "To Ship";
  String _recipientName = "";
  String _phoneNumber = "";
  String _address = "";
  String _postcode = "";
  String _city = "";
  String _state = "";
  List<String> state = [
    'Johor',
    'Kedah',
    'Kelantan',
    'Melaka',
    'Negeri Sembilan',
    'Pahang',
    'Penang',
    'Perak',
    'Perlis',
    'Sabah',
    'Sarawak',
    'Selangor',
    'Terengganu',
    'Wilayah Persekutuan Kuala Lumpur',
    'Labuan',
    'Putrajaya'
  ];

  @override
  void initState() {
    requestList = List<String>.filled(widget.selectedCart.length, "");
    super.initState();
  }

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
      child: StreamBuilder<UserData>(
          stream: DatabaseService(uid: user?.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserData? userData = snapshot.data;

              return StreamBuilder<List<Store>>(
                  stream: DatabaseService(uid: "").stores,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Store>? store = snapshot.data;
                      List<Store>? matchedStore = [];
                      List order = [];

                      for (int i = 0; i < widget.selectedCart.length; i++) {
                        for (int j = 0; j < store!.length; j++) {
                          if (widget.selectedCart[i]['item'].storeId ==
                              store[j].storeId) {
                            matchedStore.add(store[j]);
                          }
                        }
                      }

                      for (int i = 0; i < widget.selectedCart.length; i++) {
                        order.add(
                          {
                            'store': matchedStore[i].storeId,
                            'listing': widget.selectedCart[i]['item'].listingId,
                            'quantity': widget.selectedCart[i]['cart'].quantity,
                            'request': requestList![i],
                            'orderStatus': orderStatus
                          }
                        );
                        
                      }

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
                                    const TitleAppBar(
                                        title: 'Check Out',
                                        iconFlex: 3,
                                        titleFlex: 5,
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
                                              const Text(
                                                'Your Orders:',
                                                style: boldContentTitle,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                height:
                                                    widget.selectedCart.length *
                                                        185,
                                                child: ListView.builder(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemCount: widget
                                                        .selectedCart.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 20),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
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
                                                                          child:
                                                                              Image.network(
                                                                    widget
                                                                        .selectedCart[
                                                                            index]
                                                                            [
                                                                            'item']
                                                                        .listingImagePath,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  )),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            const Icon(Icons.storefront,
                                                                                size: 15),
                                                                            const SizedBox(
                                                                              width: 5,
                                                                            ),
                                                                            SizedBox(
                                                                              width: 260,
                                                                              child: Text(
                                                                                matchedStore[index].businessName,
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
                                                                          widget
                                                                              .selectedCart[index]['item']
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
                                                                                  'RM ' + widget.selectedCart[index]['item'].price,
                                                                                  style: priceLabelStyle,
                                                                                ),
                                                                                Text(
                                                                                  ' x ' + widget.selectedCart[index]['cart'].quantity.toString(),
                                                                                  style: priceLabelStyle,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                                              children: [
                                                                                Text(
                                                                                  'Subtotal: RM' + (double.parse(widget.selectedCart[index]['item'].price) * widget.selectedCart[index]['cart'].quantity).toStringAsFixed(2),
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
                                                            const Text(
                                                              'Remark Or Any Special Request: ',
                                                              style:
                                                                  buttonLabelStyle,
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            StringTextArea(
                                                              label:
                                                                  'State here...',
                                                              textLine: 3,
                                                              onChanged: (val) {
                                                                setState(() {
                                                                  requestList![
                                                                          index] =
                                                                      val;
                                                                });
                                                              },
                                                            ),
                                                          ],
                                                        ),
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
                                                'Currently, we accept cash on delivery only.',
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
                                              Form(
                                                  key: _formKey,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 4,
                                                            child:
                                                                ProfileTextField(
                                                              textFieldLabel:
                                                                  'Recipient Name',
                                                              textFieldValue:
                                                                  userData!
                                                                      .username,
                                                              textFieldLine: 1,
                                                              textFieldHeight:
                                                                  30,
                                                              isReadOnly: false,
                                                              validator: (val) =>
                                                                  val!.isEmpty
                                                                      ? 'Username'
                                                                      : null,
                                                              onChanged: (val) =>
                                                                  setState(() =>
                                                                      _recipientName =
                                                                          val),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child:
                                                                ProfileTextField(
                                                              textFieldLabel:
                                                                  'Phone Number',
                                                              textFieldValue:
                                                                  userData
                                                                      .phoneNumber,
                                                              textFieldLine: 1,
                                                              textFieldHeight:
                                                                  30,
                                                              isReadOnly: false,
                                                              validator: (val) =>
                                                                  val!.isEmpty
                                                                      ? 'Phone Number'
                                                                      : null,
                                                              onChanged: (val) =>
                                                                  setState(() =>
                                                                      _phoneNumber =
                                                                          val),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child:
                                                                ProfileTextField(
                                                              textFieldLabel:
                                                                  'Address',
                                                              textFieldValue:
                                                                  userData
                                                                      .address,
                                                              textFieldLine: 2,
                                                              textFieldHeight:
                                                                  50,
                                                              isReadOnly: false,
                                                              validator: (val) =>
                                                                  val!.isEmpty
                                                                      ? 'Address'
                                                                      : null,
                                                              onChanged: (val) =>
                                                                  setState(() =>
                                                                      _address =
                                                                          val),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 2,
                                                            child:
                                                                ProfileTextField(
                                                              textFieldLabel:
                                                                  'Postcode',
                                                              textFieldValue:
                                                                  userData
                                                                      .postcode,
                                                              textFieldLine: 1,
                                                              textFieldHeight:
                                                                  30,
                                                              isReadOnly: false,
                                                              validator: (val) =>
                                                                  val!.isEmpty
                                                                      ? 'Postcode'
                                                                      : null,
                                                              onChanged: (val) =>
                                                                  setState(() =>
                                                                      _postcode =
                                                                          val),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Expanded(
                                                            flex: 4,
                                                            child:
                                                                ProfileTextField(
                                                              textFieldLabel:
                                                                  'City',
                                                              textFieldValue:
                                                                  userData.city,
                                                              textFieldLine: 1,
                                                              textFieldHeight:
                                                                  30,
                                                              isReadOnly: false,
                                                              validator: (val) =>
                                                                  val!.isEmpty
                                                                      ? 'City'
                                                                      : null,
                                                              onChanged: (val) =>
                                                                  setState(() =>
                                                                      _city =
                                                                          val),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                const Text(
                                                                  'State',
                                                                  style:
                                                                      ratingLabelStyle,
                                                                ),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                SizedBox(
                                                                  height: 35,
                                                                  child: DropdownButtonFormField<
                                                                          String>(
                                                                      iconSize:
                                                                          20,
                                                                      decoration: const InputDecoration(
                                                                          enabledBorder: OutlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                  width:
                                                                                      1),
                                                                              borderRadius: BorderRadius
                                                                                  .zero),
                                                                          focusedBorder: OutlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                  width:
                                                                                      1),
                                                                              borderRadius: BorderRadius
                                                                                  .zero),
                                                                          contentPadding: EdgeInsets.all(
                                                                              10),
                                                                          hintStyle:
                                                                              hintStyle),
                                                                      value: userData
                                                                          .state,
                                                                      onChanged:
                                                                          (item) =>
                                                                              setState(() => _state = item!),
                                                                      items: state
                                                                          .map((item) => DropdownMenuItem<String>(
                                                                              value: item,
                                                                              child: Text(
                                                                                item,
                                                                                style: hintStyle,
                                                                              )))
                                                                          .toList()),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ))
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
                                                widget.totalPrice
                                                    .toStringAsFixed(2),
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
                                              buttonText: 'Place Order',
                                              onClick: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return YesNoAlertModal(
                                                        alertContent:
                                                            'Are you sure to place your order?',
                                                        closeOnClick: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        yesOnClick: () async {
                                                          await DatabaseService(uid: user?.uid).addOrderData(
                                                              user!.uid,
                                                              order,
                                                              widget.totalPrice
                                                                  .toStringAsFixed(
                                                                      2),
                                                              _recipientName ==
                                                                      ""
                                                                  ? userData
                                                                      .username
                                                                  : _recipientName,
                                                              _phoneNumber == ""
                                                                  ? userData
                                                                      .phoneNumber
                                                                  : _phoneNumber,
                                                              _address == ""
                                                                  ? userData
                                                                      .address
                                                                  : _address,
                                                              _postcode == ""
                                                                  ? userData
                                                                      .postcode
                                                                  : _postcode,
                                                              _city == ""
                                                                  ? userData
                                                                      .city
                                                                  : _city,
                                                              _state == ""
                                                                  ? userData
                                                                      .state
                                                                  : _state);
                                                          for (int i = 0;
                                                              i <
                                                                  widget
                                                                      .selectedCart
                                                                      .length;
                                                              i++) {
                                                            await DatabaseService(
                                                                    uid: user
                                                                        .uid)
                                                                .deleteCartData(widget
                                                                    .selectedCart[
                                                                        i]
                                                                        ["cart"]
                                                                    .cartId);
                                                          }

                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const UserOrder()));
                                                        },
                                                        noOnClick: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      );
                                                    });
                                              }))
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
