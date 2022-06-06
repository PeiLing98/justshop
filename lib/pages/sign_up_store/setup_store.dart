import 'package:file_picker/file_picker.dart';
import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/components/input_text_box.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/modals/alert_text_modal.dart';
import 'package:final_year_project/models/category_model.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/pages/profile/view_store.dart';
import 'package:final_year_project/services/database.dart';
import 'package:final_year_project/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'dart:io' as i;

import 'package:provider/provider.dart';

class SetupStore extends StatefulWidget {
  final String storeId;
  final String businessName;
  final String storeImage;

  const SetupStore({
    Key? key,
    required this.storeId,
    required this.businessName,
    required this.storeImage,
  }) : super(key: key);

  @override
  _SetupStoreState createState() => _SetupStoreState();
}

class _SetupStoreState extends State<SetupStore> {
  final formKey = GlobalKey<FormState>();
  final category = Category();
  final Storage storage = Storage();

  List subCategoryList = [];
  PlatformFile? selectedFile;
  List listing = [];
  int listingQuantity = 0;
  List attribute = [];

  String downloadLogoPath = "";
  String downloadListingImagePath = "";
  String listingImagePath = '';
  String listingImageName = '';
  String selectedCategory = 'Food';
  String selectedSubCategory = 'Malay Cuisine';
  String price = '';
  String listingName = '';
  String listingDescription = '';
  bool isSelected = true;
  String attributeName = "";
  List attributeValue = [];

  int attributeValueNumber = 2;
  int attributeNumber = 1;
  int addListing = 0;

  //select file from local device
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg'],
    );

    if (result == null) return;

    listingImagePath = result.files.single.path!;
    listingImageName = result.files.single.name;

    setState(() {
      selectedFile = result.files.first;
    });
  }

  @override
  void initState() {
    subCategoryList = category.subCategory[0];
    super.initState();
  }

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
      child: Scaffold(
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(5),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40, child: TopAppBar()),
                  TitleAppBar(
                    title: '2: Set Up Your Store',
                    iconFlex: 1,
                    titleFlex: 3,
                    hasArrow: true,
                    onClick: () {
                      Navigator.pop(context);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SizedBox(
                      height: 15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Listing ($listingQuantity)',
                            style: ratingLabelStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 510,
                    child: Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('Image',
                                            style: boldContentTitle),
                                        SizedBox(
                                          height: 20,
                                          child: IconButton(
                                            icon: const Icon(Icons.file_upload),
                                            iconSize: 20,
                                            padding: const EdgeInsets.all(0),
                                            onPressed: selectFile,
                                          ),
                                        ),
                                        const SizedBox(width: 100),
                                        const Text('Listing Category',
                                            style: boldContentTitle),
                                      ]),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Container(
                                          width: 170,
                                          height: 65,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color: const Color.fromARGB(
                                                250, 233, 221, 221),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: (selectedFile != null)
                                                ? Image.file(
                                                    i.File(selectedFile!.path!),
                                                    fit: BoxFit.cover,
                                                  )
                                                : null,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                          flex: 4,
                                          child: Column(
                                            children: [
                                              ItemDropdownButton(
                                                itemValue: selectedCategory,
                                                items: category.category,
                                                onChanged: (val) {
                                                  setState(() {
                                                    selectedCategory = val!;
                                                    if (val == 'Food') {
                                                      selectedSubCategory =
                                                          category.subCategory[
                                                              0][0];
                                                      subCategoryList = category
                                                          .subCategory[0];
                                                    } else if (val ==
                                                        'Product') {
                                                      selectedSubCategory =
                                                          category.subCategory[
                                                              1][0];
                                                      subCategoryList = category
                                                          .subCategory[1];
                                                    } else {
                                                      selectedSubCategory =
                                                          category.subCategory[
                                                              2][0];
                                                      subCategoryList = category
                                                          .subCategory[2];
                                                    }
                                                    // print(
                                                    //     "category: $selectedCategory");
                                                  });
                                                },
                                              ),
                                              const SizedBox(height: 5),
                                              ItemDropdownButton(
                                                itemValue: selectedSubCategory,
                                                items: subCategoryList,
                                                onChanged: (val) {
                                                  setState(() {
                                                    selectedSubCategory = val!;
                                                    // print(
                                                    //     "subCategory: $selectedSubCategory");
                                                  });
                                                },
                                              )
                                            ],
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 65,
                              child: Column(
                                children: [
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text('Listing Price',
                                            style: boldContentTitle),
                                        SizedBox(width: 110),
                                        Text('Listing Name',
                                            style: boldContentTitle),
                                      ]),
                                  const SizedBox(height: 5),
                                  SizedBox(
                                    height: 35,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            width: 170,
                                            child: StringTextArea(
                                              label: 'Price',
                                              textLine: 1,
                                              onChanged: (val) {
                                                setState(() {
                                                  price = val;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: StringTextArea(
                                            label:
                                                'Nasi Lemak / Face Mask / Design',
                                            textLine: 1,
                                            onChanged: (val) {
                                              listingName = val;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 105,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Listing Description',
                                      style: boldContentTitle),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  StringTextArea(
                                    label: 'Describe Your Listing In Details',
                                    textLine: 4,
                                    onChanged: (val) {
                                      listingDescription = val;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   height: 60,
                            //   child: Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         const Text('Do you have characterization?',
                            //             style: boldContentTitle),
                            //         const SizedBox(
                            //           height: 5,
                            //         ),
                            //         SizedBox(
                            //           height: 30,
                            //           child: WhiteTextButton(
                            //               buttonText: isSelected
                            //                   ? 'REMOVE CHARACTERIZATION'
                            //                   : 'ADD CHARACTERIZATION',
                            //               onClick: () {
                            //                 setState(() {
                            //                   isSelected = !isSelected;
                            //                 });
                            //               }),
                            //         )
                            //       ]),
                            // ),
                            // if (isSelected == true)
                            //   SizedBox(
                            //       height: 180,
                            //       child: Column(
                            //         crossAxisAlignment:
                            //             CrossAxisAlignment.start,
                            //         children: [
                            //           const Divider(
                            //             color: Colors.grey,
                            //           ),
                            //           SizedBox(
                            //             height: 25,
                            //             child: Row(
                            //               crossAxisAlignment:
                            //                   CrossAxisAlignment.start,
                            //               mainAxisAlignment:
                            //                   MainAxisAlignment.spaceBetween,
                            //               children: [
                            //                 const Text('Characterization',
                            //                     style: boldContentTitle),
                            //                 IconButton(
                            //                   onPressed: () {},
                            //                   icon: const Icon(Icons.info),
                            //                   iconSize: 20,
                            //                   padding: const EdgeInsets.all(0),
                            //                   alignment: Alignment.topRight,
                            //                 )
                            //               ],
                            //             ),
                            //           ),
                            //           SizedBox(
                            //             height: 135,
                            //             child: SingleChildScrollView(
                            //               child: Column(
                            //                 children: [
                            //                   for (int i = 0;
                            //                       i < attributeNumber;
                            //                       i++)
                            //                     Column(
                            //                       children: [
                            //                         SizedBox(
                            //                           child: Column(
                            //                             crossAxisAlignment:
                            //                                 CrossAxisAlignment
                            //                                     .start,
                            //                             children: [
                            //                               const Text(
                            //                                 'Attribute name',
                            //                                 style:
                            //                                     ratingLabelStyle,
                            //                               ),
                            //                               const SizedBox(
                            //                                 height: 5,
                            //                               ),
                            //                               SizedBox(
                            //                                 height: 30,
                            //                                 child:
                            //                                     StringTextArea(
                            //                                   label: 'Size',
                            //                                   textLine: 1,
                            //                                   onChanged: (val) {
                            //                                     setState(() {
                            //                                       attributeName =
                            //                                           val;
                            //                                       print(
                            //                                           "attributeName: $attributeName");
                            //                                     });
                            //                                   },
                            //                                 ),
                            //                               ),
                            //                             ],
                            //                           ),
                            //                         ),
                            //                         Padding(
                            //                           padding:
                            //                               const EdgeInsets.only(
                            //                                   top: 10),
                            //                           child: Column(
                            //                             crossAxisAlignment:
                            //                                 CrossAxisAlignment
                            //                                     .start,
                            //                             children: [
                            //                               SizedBox(
                            //                                 height: 15,
                            //                                 child: Row(
                            //                                   mainAxisAlignment:
                            //                                       MainAxisAlignment
                            //                                           .spaceBetween,
                            //                                   children: [
                            //                                     const Expanded(
                            //                                       flex: 10,
                            //                                       child: Text(
                            //                                         'Attribute value',
                            //                                         style:
                            //                                             ratingLabelStyle,
                            //                                       ),
                            //                                     ),
                            //                                     Expanded(
                            //                                       flex: 1,
                            //                                       child:
                            //                                           IconButton(
                            //                                         icon: const Icon(
                            //                                             Icons
                            //                                                 .add_circle),
                            //                                         iconSize:
                            //                                             20,
                            //                                         onPressed:
                            //                                             () {
                            //                                           setState(
                            //                                               () {
                            //                                             attributeValueNumber++;
                            //                                           });
                            //                                         },
                            //                                         padding:
                            //                                             const EdgeInsets
                            //                                                 .all(0),
                            //                                         alignment:
                            //                                             Alignment
                            //                                                 .centerRight,
                            //                                       ),
                            //                                     ),
                            //                                     Expanded(
                            //                                       flex: 1,
                            //                                       child:
                            //                                           IconButton(
                            //                                         icon: const Icon(
                            //                                             Icons
                            //                                                 .delete),
                            //                                         iconSize:
                            //                                             20,
                            //                                         onPressed:
                            //                                             () {
                            //                                           setState(
                            //                                               () {
                            //                                             attributeValueNumber--;
                            //                                           });
                            //                                         },
                            //                                         padding:
                            //                                             const EdgeInsets
                            //                                                 .all(0),
                            //                                         alignment:
                            //                                             Alignment
                            //                                                 .centerRight,
                            //                                       ),
                            //                                     )
                            //                                   ],
                            //                                 ),
                            //                               ),
                            //                               const SizedBox(
                            //                                 height: 5,
                            //                               ),
                            //                               ListView(
                            //                                   shrinkWrap: true,
                            //                                   physics:
                            //                                       const NeverScrollableScrollPhysics(),
                            //                                   padding:
                            //                                       const EdgeInsets
                            //                                               .only(
                            //                                           bottom:
                            //                                               5),
                            //                                   children: [
                            //                                     for (int i = 0;
                            //                                         i < attributeValueNumber;
                            //                                         i++)
                            //                                       Padding(
                            //                                         padding: const EdgeInsets
                            //                                                 .only(
                            //                                             bottom:
                            //                                                 5),
                            //                                         child:
                            //                                             SizedBox(
                            //                                           height:
                            //                                               30,
                            //                                           child:
                            //                                               StringTextArea(
                            //                                             label:
                            //                                                 'Large',
                            //                                             textLine:
                            //                                                 1,
                            //                                             onChanged:
                            //                                                 (val) {
                            //                                               setState(
                            //                                                   () {
                            //                                                 attributeValue[i] =
                            //                                                     val;
                            //                                                 print("value $i : ${attributeValue[i]}");
                            //                                               });
                            //                                             },
                            //                                           ),
                            //                                         ),
                            //                                       )
                            //                                   ]),
                            //                             ],
                            //                           ),
                            //                         ),
                            //                       ],
                            //                     ),
                            //                   SizedBox(
                            //                       height: 30,
                            //                       child: Row(
                            //                         mainAxisAlignment:
                            //                             MainAxisAlignment
                            //                                 .spaceAround,
                            //                         children: [
                            //                           SizedBox(
                            //                             width: 150,
                            //                             child: PurpleTextButton(
                            //                                 buttonText:
                            //                                     'Add Attribute',
                            //                                 onClick: () {
                            //                                   setState(() {
                            //                                     attributeNumber++;
                            //                                   });
                            //                                 }),
                            //                           ),
                            //                           SizedBox(
                            //                             width: 150,
                            //                             child: PurpleTextButton(
                            //                                 buttonText:
                            //                                     'Remove Attribute',
                            //                                 onClick: () {
                            //                                   setState(() {
                            //                                     attributeNumber--;
                            //                                   });
                            //                                 }),
                            //                           ),
                            //                         ],
                            //                       ))
                            //                 ],
                            //               ),
                            //             ),
                            //           ),
                            //       ],
                            //     )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 30,
                          width: 100,
                          child: PurpleTextButton(
                            buttonText: 'Back',
                            onClick: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          width: 100,
                          child: PurpleTextButton(
                            buttonText: 'Add listing',
                            onClick: () {
                              if (formKey.currentState!.validate()) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return YesNoAlertModal(
                                        alertContent:
                                            'Are you sure to add this listing to your store?',
                                        closeOnClick: () {
                                          Navigator.pop(context);
                                        },
                                        yesOnClick: () async {
                                          storage
                                              .uploadFile(listingImagePath,
                                                  listingImageName)
                                              .then((value) => print('Done'));

                                          downloadListingImagePath =
                                              await storage.downloadURL(
                                                  listingImageName);

                                          await DatabaseService(uid: userId)
                                              .addItemData(
                                                  widget.storeId,
                                                  widget.businessName,
                                                  widget.storeImage,
                                                  downloadListingImagePath,
                                                  selectedCategory,
                                                  selectedSubCategory,
                                                  price,
                                                  listingName,
                                                  listingDescription);

                                          setState(() {
                                            listingQuantity++;
                                          });

                                          Navigator.pop(context);
                                        },
                                        noOnClick: () {
                                          Navigator.pop(context);
                                        },
                                      );
                                    });
                              }

                              // print(downloadListingImagePath);
                              // listing.add(
                              //    listing[addListing].listingImagePath =
                              //     downloadListingImagePath,
                              // listing[addListing].selectedCategory =
                              //     selectedCategory,
                              // listing[addListing].selectedSubCategory =
                              //     selectedSubCategory,
                              // listing[addListing].price = price,
                              // listing[addListing].listingName = listingName,
                              // listing[addListing].listingDescription =
                              //     listingDescription,
                              // );

                              // addListing++;
                              // print(addListing);
                              // setState(() {
                              // Map tempListing = {
                              //   'listingImagePath': listingImagePath,
                              //   "selectedCategory": selectedCategory,
                              //   "selectedSubCategory": selectedSubCategory,
                              //   "price": price,
                              //   "listingName": listingName,
                              //   "listingDescription": listingDescription,
                              // };

                              // tempListing.forEach((key, value) =>
                              //     listing.add(Listing(key, value)));
                              //   var tempListing = Listing(
                              //       listingImagePath: listingImagePath,
                              //       selectedCategory: selectedCategory,
                              //       selectedSubCategory: selectedSubCategory,
                              //       price: price,
                              //       listingName: listingName,
                              //       listingDescription: listingDescription);

                              //   listing.add(tempListing);

                              //   print(listing);
                              // });

                              // listing.add({
                              //   // "listingImagePath": downloadListingImagePath,
                              //   // "selectedCategory": selectedCategory,
                              //   // "selectedSubCategory": selectedSubCategory,
                              //   // "price": price,
                              //   // "listingName": listingName,
                              //   // "listingDescription": listingDescription,
                              //   // "isSelected": isSelected,
                              //   // "attribute": attribute
                              // });

                              // attribute.add({
                              //   "attributeName": attributeName,
                              //   "attributeValue": attributeValue
                              // });

                              // Navigator.pop(context);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          width: 130,
                          child: PurpleTextButton(
                            buttonText: 'Set up your store',
                            onClick: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertTextModal(
                                      alertContent:
                                          'You have successfully set up your store!',
                                      onClick: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ViewStore()));
                                      },
                                    );
                                  });
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
