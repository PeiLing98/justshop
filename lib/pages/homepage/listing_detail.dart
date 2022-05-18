import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/components/review_component.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/models/listing_model.dart';
import 'package:final_year_project/models/store_model.dart';
import 'package:final_year_project/pages/homepage/store_listing_detail.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';

class ListingDetail extends StatefulWidget {
  final Listing listing;

  const ListingDetail({
    Key? key,
    required this.listing,
  }) : super(key: key);

  @override
  _ListingDetailState createState() => _ListingDetailState();
}

class _ListingDetailState extends State<ListingDetail> {
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
            List<Store>? store = snapshot.data;
            List<Store>? matchedStore;
            matchedStore = store?.where((store) {
              return store.storeId == widget.listing.storeId;
            }).toList();

            if (snapshot.hasData) {
              return Scaffold(
                body: SafeArea(
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 40, child: TopAppBar()),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Row(children: [
                                Expanded(
                                  child: Container(
                                    height: 150,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: const Color.fromARGB(
                                            250, 233, 221, 221),
                                        border: Border.all(
                                            width: 0.5, color: Colors.grey)),
                                    child: ClipRRect(
                                      child: Image.network(
                                          widget.listing.listingImagePath,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                )
                              ])
                            ],
                          ),
                          Container(
                            height: 80,
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    StoreListingDetail(
                                                        store:
                                                            matchedStore![0])));
                                      },
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: const Color.fromARGB(
                                                250, 233, 221, 221),
                                            border: Border.all(
                                                width: 0.5,
                                                color: Colors.grey)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.network(
                                              matchedStore![0].imagePath,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          matchedStore[0].businessName,
                                          style: boldContentTitle,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        padding: const EdgeInsets.all(0),
                                        alignment: Alignment.centerRight,
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.bookmark_border_rounded,
                                          size: 25,
                                        )),
                                    IconButton(
                                        padding: const EdgeInsets.all(0),
                                        alignment: Alignment.centerRight,
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.share_outlined,
                                          size: 25,
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 150,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.listing.listingName,
                                        style: boldContentTitle,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'RM ${widget.listing.price}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Roboto',
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 30),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                child: Text(
                                                  widget
                                                      .listing.selectedCategory,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontFamily: 'Roboto'),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                child: Text(
                                                  widget.listing
                                                      .selectedSubCategory,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontFamily: 'Roboto'),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text('Description:',
                                          style: boldContentTitle),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              height: 65,
                                              child: Text(
                                                widget
                                                    .listing.listingDescription,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'Roboto'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Text(
                              'Review (0)',
                              style: boldContentTitle,
                            ),
                          ),
                          SingleChildScrollView(
                            child: Container(
                              height: 180,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: ListView.builder(
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return const ReviewComponent();
                                },
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const QuantityButton(
                            width: 150,
                            height: 30,
                          ),
                          SizedBox(
                              width: 150,
                              child: PurpleTextButton(
                                  buttonText: 'Add To Cart', onClick: () {}))
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
