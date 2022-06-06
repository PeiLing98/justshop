import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/components/input_text_box.dart';
import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/modals/alert_text_modal.dart';
import 'package:final_year_project/models/listing_model.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/pages/profile/manage_listing/add_listing.dart';
import 'package:final_year_project/pages/profile/manage_listing/update_listing.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageListing extends StatefulWidget {
  const ManageListing({Key? key}) : super(key: key);

  @override
  _ManageListingState createState() => _ManageListingState();
}

class _ManageListingState extends State<ManageListing> {
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
      child: StreamBuilder<UserStoreData>(
          stream: DatabaseService(uid: user?.uid).userStoreData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserStoreData? userStoreData = snapshot.data;
              return Scaffold(
                  body: SafeArea(
                child: StreamBuilder<List<Listing>>(
                    stream: DatabaseService(uid: "").item,
                    builder: (context, snapshot) {
                      List<Listing>? item = snapshot.data;
                      List<Listing>? matchedStoreItem;
                      matchedStoreItem = item?.where((item) {
                        return item.storeId == userStoreData!.storeId;
                      }).toList();

                      if (snapshot.hasData) {
                        return Container(
                          margin: const EdgeInsets.all(5),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 40, child: TopAppBar()),
                                TitleAppBar(
                                  title: 'Manage Listing',
                                  iconFlex: 2,
                                  titleFlex: 4,
                                  hasArrow: true,
                                  onClick: () {
                                    Navigator.pushNamed(context, '/profile');
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Container(
                                    height: 17,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Total of listing: ${matchedStoreItem!.length}',
                                          style: boldContentTitle,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                                padding: const EdgeInsets.only(
                                                    right: 5),
                                                alignment:
                                                    Alignment.centerRight,
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            AddListing(
                                                          storeId:
                                                              userStoreData!
                                                                  .storeId,
                                                          businessName:
                                                              userStoreData
                                                                  .businessName,
                                                          storeImage:
                                                              userStoreData
                                                                  .imagePath,
                                                          listingQuantity:
                                                              matchedStoreItem!
                                                                  .length,
                                                        ),
                                                      ));
                                                },
                                                icon: const Icon(
                                                  Icons.add_outlined,
                                                  size: 13,
                                                )),
                                            const Text(
                                              'Add Listing',
                                              style: boldContentTitle,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 540,
                                  child: ListView.builder(
                                      itemCount: matchedStoreItem.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 18,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '#Listing ${index + 1}',
                                                          style:
                                                              boldContentTitle,
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            IconButton(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(0),
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                onPressed: () {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return YesNoAlertModal(
                                                                            alertContent:
                                                                                'Are you sure to delete this listing?',
                                                                            closeOnClick:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            yesOnClick:
                                                                                () async {
                                                                              await DatabaseService(uid: user?.uid).deleteItemData(matchedStoreItem![index].listingId);
                                                                              Navigator.pop(context);
                                                                            },
                                                                            noOnClick:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            });
                                                                      });
                                                                },
                                                                icon:
                                                                    const Icon(
                                                                  Icons.delete,
                                                                  size: 18,
                                                                )),
                                                            SizedBox(
                                                              width: 30,
                                                              child: IconButton(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          0),
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              UpdateListing(
                                                                            storeId:
                                                                                userStoreData!.storeId,
                                                                            businessName:
                                                                                userStoreData.businessName,
                                                                            storeImage:
                                                                                userStoreData.imagePath,
                                                                            listingIndex:
                                                                                index + 1,
                                                                            listing:
                                                                                matchedStoreItem![index],
                                                                          ),
                                                                        ));
                                                                  },
                                                                  icon:
                                                                      const Icon(
                                                                    Icons.edit,
                                                                    size: 18,
                                                                  )),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        height: 120,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text('Image',
                                                                style:
                                                                    buttonLabelStyle),
                                                            const SizedBox(
                                                                height: 5),
                                                            Container(
                                                              width: 180,
                                                              height: 90,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                color: const Color
                                                                        .fromARGB(
                                                                    250,
                                                                    233,
                                                                    221,
                                                                    221),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child: Image
                                                                    .network(
                                                                  matchedStoreItem![
                                                                          index]
                                                                      .listingImagePath,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      SizedBox(
                                                        height: 120,
                                                        width: 170,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            ProfileTextField(
                                                                textFieldLabel:
                                                                    'Category',
                                                                textFieldValue:
                                                                    matchedStoreItem[
                                                                            index]
                                                                        .selectedCategory,
                                                                textFieldLine:
                                                                    1,
                                                                textFieldHeight:
                                                                    30,
                                                                isReadOnly:
                                                                    true),
                                                            ProfileTextField(
                                                                textFieldLabel:
                                                                    'Sub Category',
                                                                textFieldValue:
                                                                    matchedStoreItem[
                                                                            index]
                                                                        .selectedSubCategory,
                                                                textFieldLine:
                                                                    1,
                                                                textFieldHeight:
                                                                    30,
                                                                isReadOnly:
                                                                    true)
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: ProfileTextField(
                                                            textFieldLabel:
                                                                'Price',
                                                            textFieldValue:
                                                                matchedStoreItem[
                                                                        index]
                                                                    .price,
                                                            textFieldLine: 1,
                                                            textFieldHeight: 30,
                                                            isReadOnly: true),
                                                      ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: ProfileTextField(
                                                            textFieldLabel:
                                                                'Name',
                                                            textFieldValue:
                                                                matchedStoreItem[
                                                                        index]
                                                                    .listingName,
                                                            textFieldLine: 1,
                                                            textFieldHeight: 30,
                                                            isReadOnly: true),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: ProfileTextField(
                                                            textFieldLabel:
                                                                'Description',
                                                            textFieldValue:
                                                                matchedStoreItem[
                                                                        index]
                                                                    .listingDescription,
                                                            textFieldLine: 4,
                                                            textFieldHeight: 80,
                                                            isReadOnly: true),
                                                      )
                                                    ],
                                                  ),
                                                  // const Divider(
                                                  //   color: Colors.grey,
                                                  //   height: 5,
                                                  //   thickness: 0.5,
                                                  // )
                                                ],
                                              ),
                                            )
                                          ],
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return const Loading();
                      }
                    }),
              ));
            } else {
              return const Loading();
            }
          }),
    );
  }
}
