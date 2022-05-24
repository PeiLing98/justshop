import 'package:file_picker/file_picker.dart';
import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/components/input_text_box.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/modals/alert_text_modal.dart';
import 'package:final_year_project/models/category_model.dart';
import 'package:final_year_project/models/listing_model.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/pages/profile/manage_listing/manage_listing.dart';
import 'package:final_year_project/services/database.dart';
import 'package:final_year_project/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'dart:io' as i;

import 'package:provider/provider.dart';

class UpdateListing extends StatefulWidget {
  final String storeId;
  final String businessName;
  final String storeImage;
  final int listingIndex;
  final Listing listing;

  const UpdateListing(
      {Key? key,
      required this.storeId,
      required this.businessName,
      required this.listingIndex,
      required this.listing,
      required this.storeImage})
      : super(key: key);

  @override
  _UpdateListingState createState() => _UpdateListingState();
}

class _UpdateListingState extends State<UpdateListing> {
  final formKey = GlobalKey<FormState>();
  PlatformFile? selectedFile;
  final category = Category();
  final Storage storage = Storage();
  List subCategoryList = [];

  String listingImagePath = '';
  String listingImageName = "";

  // String selectedCategory = 'Food';
  // String selectedSubCategory = 'Malay Cuisine';

  String? _currentImagePath;
  String _currentSelectedCategory = "";
  String _currentSelectedSubCategory = "";
  String? _currentPrice;
  String? _currentListingName;
  String? _currentListingDescription;

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
    _currentSelectedCategory = widget.listing.selectedCategory;
    _currentSelectedSubCategory = widget.listing.selectedSubCategory;

    if (widget.listing.selectedCategory == "Food") {
      subCategoryList = category.subCategory[0];
    } else if (widget.listing.selectedCategory == "Product") {
      subCategoryList = category.subCategory[1];
    } else {
      subCategoryList = category.subCategory[2];
    }

    super.initState();

    print(widget.listing.listingId);
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
                const TitleAppBar(
                  title: 'Update Listing',
                  iconFlex: 1,
                  titleFlex: 2,
                  hasArrow: true,
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
                          '#Listing ${widget.listingIndex}',
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
                                                : Image.network(
                                                    widget.listing
                                                        .listingImagePath,
                                                    fit: BoxFit.cover,
                                                  ),
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
                                                itemValue:
                                                    _currentSelectedCategory,
                                                items: category.category,
                                                onChanged: (val) {
                                                  setState(() {
                                                    _currentSelectedCategory =
                                                        val!;
                                                    if (val == 'Food') {
                                                      _currentSelectedSubCategory =
                                                          category.subCategory[
                                                              0][0];
                                                      subCategoryList = category
                                                          .subCategory[0];
                                                    } else if (val ==
                                                        'Product') {
                                                      _currentSelectedSubCategory =
                                                          category.subCategory[
                                                              1][0];
                                                      subCategoryList = category
                                                          .subCategory[1];
                                                    } else {
                                                      _currentSelectedSubCategory =
                                                          category.subCategory[
                                                              2][0];
                                                      subCategoryList = category
                                                          .subCategory[2];
                                                    }
                                                    print(
                                                        "category: $_currentSelectedCategory");
                                                    // print(
                                                    //     "subCategory: $selectedSubCategory");
                                                  });
                                                },
                                              ),
                                              const SizedBox(height: 5),
                                              ItemDropdownButton(
                                                itemValue:
                                                    _currentSelectedSubCategory,
                                                items: subCategoryList,
                                                onChanged: (val) {
                                                  setState(() {
                                                    _currentSelectedSubCategory =
                                                        val!;
                                                    print(
                                                        "subCategory: $_currentSelectedSubCategory");
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
                                              initialValue:
                                                  widget.listing.price,
                                              label: 'Price',
                                              textLine: 1,
                                              onChanged: (val) {
                                                setState(() {
                                                  _currentPrice = val;
                                                  print(_currentPrice);
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
                                            initialValue:
                                                widget.listing.listingName,
                                            label:
                                                'Nasi Lemak / Face Mask / Design',
                                            textLine: 1,
                                            onChanged: (val) {
                                              _currentListingName = val;
                                              print(_currentListingName);
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
                                    initialValue:
                                        widget.listing.listingDescription,
                                    label: 'Describe Your Listing In Details',
                                    textLine: 4,
                                    onChanged: (val) {
                                      _currentListingDescription = val;
                                      print(_currentListingDescription);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 30,
                        width: 100,
                        child: PurpleTextButton(
                            buttonText: 'Update',
                            onClick: () {
                              if (formKey.currentState!.validate()) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return YesNoAlertModal(
                                        alertContent:
                                            'Are you sure to update this listing?',
                                        closeOnClick: () {
                                          Navigator.pop(context);
                                        },
                                        yesOnClick: () async {
                                          if (listingImagePath != "") {
                                            storage
                                                .uploadFile(listingImagePath,
                                                    listingImageName)
                                                .then((value) => print('Done'));

                                            _currentImagePath = await storage
                                                .downloadURL(listingImageName);
                                          }

                                          await DatabaseService(uid: userId)
                                              .updateItemData(
                                                  widget.listing.listingId,
                                                  widget.storeId,
                                                  widget.businessName,
                                                  widget.storeImage,
                                                  _currentImagePath ??
                                                      widget.listing
                                                          .listingImagePath,
                                                  _currentSelectedCategory,
                                                  _currentSelectedSubCategory,
                                                  _currentPrice ??
                                                      widget.listing.price,
                                                  _currentListingName ??
                                                      widget
                                                          .listing.listingName,
                                                  _currentListingDescription ??
                                                      widget.listing
                                                          .listingDescription);

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const ManageListing(),
                                              ));
                                        },
                                        noOnClick: () {
                                          Navigator.pop(context);
                                        },
                                      );
                                    });
                              }
                            }),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
