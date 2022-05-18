import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/models/store_model.dart';
import 'package:final_year_project/pages/homepage/store_listing_detail.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';

class StoreListing extends StatefulWidget {
  const StoreListing({Key? key}) : super(key: key);

  @override
  _StoreListingState createState() => _StoreListingState();
}

// const kGoogleApiKey = 'AIzaSyCoho5rQrIjW0KGmJXpwZmuo_dgJXCgTTs';

class _StoreListingState extends State<StoreListing> {
  //var timeNow = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Store>>(
      stream: DatabaseService(uid: "").stores,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Store>? store = snapshot.data;
          return SizedBox(
            height: (115 * store!.length).toDouble(),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
              ),
              itemCount: store.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 100,
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
                                builder: (context) =>
                                    StoreListingDetail(store: store[index])));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(250, 129, 89, 89),
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    store[index].imagePath,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              store[index].businessName,
                              style: buttonLabelStyle,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_pin,
                                  size: 15,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                  child: Text(
                                    store[index].city +
                                        ", " +
                                        store[index].state,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'Roboto',
                                    ),
                                    overflow: TextOverflow.visible,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  size: 15,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(store[index].startTime,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'Roboto',
                                    )),
                                const Text(' - ',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'Roboto',
                                    )),
                                Text(store[index].endTime,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'Roboto',
                                    )),
                              ],
                            ),
                            // SizedBox(
                            //   height: 25,
                            //   width: 50,
                            //   child: ListView(
                            //     shrinkWrap: true,
                            //     scrollDirection: Axis.horizontal,
                            //     children: [
                            //       Padding(
                            //         padding: const EdgeInsets.only(right: 5),
                            //         child: Container(
                            //           decoration: BoxDecoration(
                            //               border: Border.all(color: Colors.grey),
                            //               borderRadius: BorderRadius.circular(5)),
                            //           child: Padding(
                            //             padding: const EdgeInsets.symmetric(
                            //                 horizontal: 10, vertical: 5),
                            //             child: Text(
                            //               '123',
                            //               style: const TextStyle(
                            //                   fontSize: 12, fontFamily: 'Roboto'),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              // }).toList(),
            ),
          );
        } else {
          return const Loading();
        }
      },
    );
  }
}
