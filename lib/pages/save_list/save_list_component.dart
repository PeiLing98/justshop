import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/modals/alert_text_modal.dart';
import 'package:final_year_project/models/listing_model.dart';
import 'package:final_year_project/models/save_list_model.dart';
import 'package:final_year_project/models/store_model.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/pages/homepage/listing_detail.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class SaveListComponent extends StatefulWidget {
  final String listingId;
  final String listingName;
  final String listingPrice;
  final String listingImage;
  final String storeId;
  final Listing listing;

  const SaveListComponent(
      {Key? key,
      required this.listingId,
      required this.listingName,
      required this.listingPrice,
      required this.listingImage,
      required this.storeId,
      required this.listing})
      : super(key: key);

  @override
  _SaveListComponentState createState() => _SaveListComponentState();
}

class _SaveListComponentState extends State<SaveListComponent> {
  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<MyUser?>(context)?.uid;
    return StreamBuilder<List<Store>>(
        stream: DatabaseService(uid: "").stores,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Store>? store = snapshot.data;
            List<Store>? matchedStore = [];

            matchedStore = store?.where((store) {
              return store.storeId == widget.storeId;
            }).toList();

            return StreamBuilder<List<SaveListModel>>(
                stream: DatabaseService(uid: "").saveList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<SaveListModel>? saveList = snapshot.data;
                    SaveListModel? matchedSaveList;

                    matchedSaveList = saveList?.where((saveList) {
                      return saveList.userId == userId &&
                          saveList.listingId == widget.listingId;
                    }).first;

                    return SizedBox(
                      height: 80,
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
                                        listing: widget.listing)));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Expanded(
                                  child: Container(
                                    height: 80,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Color.fromRGBO(129, 89, 89, 0.98),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                    ),
                                    child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                        child: Image.network(
                                          widget.listingImage,
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                ),
                              ]),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        RatingBar.builder(
                                            allowHalfRating: true,
                                            ignoreGestures: true,
                                            glow: false,
                                            updateOnDrag: true,
                                            initialRating: double.parse(
                                                widget.listing.rating),
                                            unratedColor: Colors.grey[300],
                                            minRating: 1,
                                            itemSize: 15,
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                                  Icons.star,
                                                  color: secondaryColor,
                                                ),
                                            onRatingUpdate: (rating) {
                                              //print(rating);
                                            }),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    SizedBox(
                                      height: 15,
                                      child: Text(
                                        widget.listingName,
                                        style: const TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text('RM ' + widget.listingPrice,
                                        style: const TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 12,
                                            color: secondaryColor)),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      height: 15,
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.storefront,
                                            size: 15,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          SizedBox(
                                            width: 130,
                                            child: Text(
                                              matchedStore![0].businessName,
                                              style: const TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 10,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      height: 10,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          IconButton(
                                              padding: const EdgeInsets.all(0),
                                              alignment: Alignment.centerRight,
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return YesNoAlertModal(
                                                          alertContent:
                                                              'Are you sure to remove this listing from your save list?',
                                                          closeOnClick: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          yesOnClick: () async {
                                                            await DatabaseService(
                                                                    uid: userId)
                                                                .deleteSaveListData(
                                                                    matchedSaveList!
                                                                        .saveListId);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          noOnClick: () {
                                                            Navigator.pop(
                                                                context);
                                                          });
                                                    });
                                              },
                                              icon: const Icon(
                                                Icons.remove_circle_outline,
                                                size: 15,
                                              ))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
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
        });
  }
}
