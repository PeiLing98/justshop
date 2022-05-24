import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/components/save_list_component.dart';
import 'package:final_year_project/components/tab_bar.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/models/listing_model.dart';
import 'package:final_year_project/models/save_list_model.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaveList extends StatefulWidget {
  const SaveList({Key? key}) : super(key: key);

  @override
  _SaveListState createState() => _SaveListState();
}

class _SaveListState extends State<SaveList> {
  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<MyUser?>(context)?.uid;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: StreamBuilder<List<SaveListModel>>(
          stream: DatabaseService(uid: "").saveList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<SaveListModel>? saveList = snapshot.data;
              List<SaveListModel>? matchedSaveList = [];

              matchedSaveList = saveList?.where((saveList) {
                return saveList.userId == userId;
              }).toList();

              return StreamBuilder<List<Listing>>(
                  stream: DatabaseService(uid: "").item,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Listing>? item = snapshot.data;
                      List<Listing>? matchedItem = [];
                      List<Listing>? matchedFoodItem = [];
                      List<Listing>? matchedProductItem = [];
                      List<Listing>? matchedServiceItem = [];

                      for (int i = 0; i < item!.length; i++) {
                        for (int j = 0; j < matchedSaveList!.length; j++) {
                          if (item[i].listingId ==
                              matchedSaveList[j].listingId) {
                            matchedItem.add(item[i]);
                          }
                        }
                      }

                      for (var i in matchedItem) {
                        if (i.selectedCategory == "Food") {
                          matchedFoodItem.add(i);
                        } else if (i.selectedCategory == "Product") {
                          matchedProductItem.add(i);
                        } else {
                          matchedServiceItem.add(i);
                        }
                      }

                      return Scaffold(
                        body: SafeArea(
                            child: SingleChildScrollView(
                                child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 40, child: TopAppBar()),
                              const TitleAppBar(
                                  title: 'Save List',
                                  iconFlex: 2,
                                  titleFlex: 3,
                                  hasArrow: true),
                              SizedBox(
                                height: 580,
                                child: ListingTabBar(
                                  foodBody: SingleChildScrollView(
                                      child: SizedBox(
                                    height: 510,
                                    child: matchedFoodItem.isEmpty
                                        ? Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Text(
                                                'No food listing is saved.',
                                                style: ratingLabelStyle,
                                              ),
                                            ],
                                          )
                                        : GridView.builder(
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisSpacing: 5,
                                              crossAxisSpacing: 5,
                                              childAspectRatio: 0.95,
                                            ),
                                            itemCount: matchedFoodItem.length,
                                            itemBuilder: (context, index) {
                                              return SaveListComponent(
                                                listingId:
                                                    matchedFoodItem[index]
                                                        .listingId,
                                                listingName:
                                                    matchedFoodItem[index]
                                                        .listingName,
                                                listingPrice:
                                                    matchedFoodItem[index]
                                                        .price,
                                                listingImage:
                                                    matchedFoodItem[index]
                                                        .listingImagePath,
                                                storeId: matchedFoodItem[index]
                                                    .storeId,
                                                listing: matchedFoodItem[index],
                                              );
                                            },
                                          ),
                                  )),
                                  productBody: SingleChildScrollView(
                                      child: SizedBox(
                                    height: 300,
                                    child: matchedProductItem.isEmpty
                                        ? Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Text(
                                                'No product listing is saved.',
                                                style: ratingLabelStyle,
                                              ),
                                            ],
                                          )
                                        : GridView.builder(
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisSpacing: 5,
                                              crossAxisSpacing: 5,
                                              childAspectRatio: 0.95,
                                            ),
                                            itemCount:
                                                matchedProductItem.length,
                                            itemBuilder: (context, index) {
                                              return SaveListComponent(
                                                listingId:
                                                    matchedProductItem[index]
                                                        .listingId,
                                                listingName:
                                                    matchedProductItem[index]
                                                        .listingName,
                                                listingPrice:
                                                    matchedProductItem[index]
                                                        .price,
                                                listingImage:
                                                    matchedProductItem[index]
                                                        .listingImagePath,
                                                storeId:
                                                    matchedProductItem[index]
                                                        .storeId,
                                                listing:
                                                    matchedProductItem[index],
                                              );
                                            },
                                          ),
                                  )),
                                  serviceBody: SingleChildScrollView(
                                      child: SizedBox(
                                    height: 500,
                                    child: matchedServiceItem.isEmpty
                                        ? Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Text(
                                                'No service listing is saved.',
                                                style: ratingLabelStyle,
                                              ),
                                            ],
                                          )
                                        : GridView.builder(
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisSpacing: 5,
                                              crossAxisSpacing: 5,
                                              childAspectRatio: 0.95,
                                            ),
                                            itemCount:
                                                matchedServiceItem.length,
                                            itemBuilder: (context, index) {
                                              return SaveListComponent(
                                                listingId:
                                                    matchedServiceItem[index]
                                                        .listingId,
                                                listingName:
                                                    matchedServiceItem[index]
                                                        .listingName,
                                                listingPrice:
                                                    matchedServiceItem[index]
                                                        .price,
                                                listingImage:
                                                    matchedServiceItem[index]
                                                        .listingImagePath,
                                                storeId:
                                                    matchedServiceItem[index]
                                                        .storeId,
                                                listing:
                                                    matchedServiceItem[index],
                                              );
                                            },
                                          ),
                                  )),
                                ),
                              )
                            ],
                          ),
                        ))),
                      );
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
