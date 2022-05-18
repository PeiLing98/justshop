import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/models/listing_model.dart';
import 'package:final_year_project/pages/homepage/listing_detail.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';

class ItemListing extends StatefulWidget {
  const ItemListing({Key? key}) : super(key: key);

  @override
  _ItemListingState createState() => _ItemListingState();
}

class _ItemListingState extends State<ItemListing> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Listing>>(
        stream: DatabaseService(uid: "").item,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Listing>? item = snapshot.data;
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: item!.length,
                itemBuilder: (context, index) {
                  // return StreamBuilder<List<Store>>(
                  //     stream: DatabaseService(uid: "").stores,
                  //     builder: (context, snapshot) {
                  //       if (snapshot.hasData) {
                  //         List<Store>? stores = snapshot.data;
                  //         List<Store>? matchedStore;

                  //         // for (int j = 0; j < stores!.length; j++) {
                  //         //   if (item[index].storeId == stores[j].storeId) {
                  //         //     matchedStore?.add([stores[j]]);
                  //         //     print('item: ${item[index].storeId}');
                  //         //     print('store: ${stores[j].storeId}');
                  //         //     print('matched: $matchedStore');
                  //         //   }
                  //         // }

                  //         matchedStore = stores?.where((stores) {
                  //           return stores.storeId == item[index].storeId;
                  //         }).toList();

                  //         //print(matchedStore![index].businessName);

                  //         // print(stores);
                  //         print(matchedStore);

                  return SizedBox(
                    width: 250,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ListingDetail(
                                          listing: item[index],
                                          // storeImagePath:
                                          //     matchedStore![index]
                                          //         .imagePath,
                                          // storeName: matchedStore[index]
                                          //     .businessName
                                        )));
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 90,
                                height: 100,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10)),
                                  color: Color.fromARGB(250, 129, 89, 89),
                                ),
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10)),
                                    child: Image.network(
                                      item[index].listingImagePath,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              SizedBox(
                                width: 150,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 50,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item[index].listingName,
                                              style: buttonLabelStyle,
                                              overflow: TextOverflow.visible,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'RM ${item[index].price}',
                                              style: const TextStyle(
                                                fontSize: 10,
                                                fontFamily: 'Roboto',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        height: 15,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: const [
                                            Text(
                                              '5 Sold',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.bold,
                                                  color: secondaryColor),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )),
                    ),
                  );
                  //   } else {
                  //     return const Loading();
                  //   }
                  // });
                });
          } else {
            return const Loading();
          }
        });
  }
}
