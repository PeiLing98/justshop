import 'package:file_picker/file_picker.dart';
import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/components/input_text_box.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'dart:io' as i;

class SetupStore extends StatefulWidget {
  const SetupStore({Key? key}) : super(key: key);

  @override
  _SetupStoreState createState() => _SetupStoreState();
}

class _SetupStoreState extends State<SetupStore> {
  String selectedCategory = 'Food';
  var categoryList = ['Food', 'Product', 'Service'];
  var foodCategoryList = [
    'Malay Cuisine',
    'Chinese Cuisine',
    'Indian Cuisine',
    'Western Cuisine',
    'Korean Cuisine',
    'Japanese Cuisine',
    'Thai Cuisine',
    'Beverage',
    'Bread & Cake & Dessert',
    'Others'
  ];
  var productCategoryList = [
    'Food',
    'Health & Beauty',
    'Hair',
    'Fashion',
    'Daily Life',
    'Home & Living',
    'Electronic',
    'Sport & Outdoor',
    'Automotive',
    'Handmade',
    'Others'
  ];
  var serviceCategoryList = [
    'Home Cleaning',
    'Photography & Videography',
    'Art & Design',
    'Mover & Logistics',
    'Home Repair & Maintenance & Furnishing',
    'Party & Event',
    'Construction',
    'Education',
    'Beauty',
    'Confinement',
    'Health',
    'Others'
  ];
  String selectedSubCategory = '';
  var subCategoryList = [''];
  PlatformFile? selectedFile;
  String imagePath = '';
  String imageName = '';
  bool isSelected = true;

  //select file from local device
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg'],
    );

    if (result == null) return;

    imagePath = result.files.single.path!;
    imageName = result.files.single.name;

    setState(() {
      selectedFile = result.files.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();

    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40, child: TopAppBar()),
                const TitleAppBar(
                  title: '2: Set Up Your Store',
                  iconFlex: 1,
                  titleFlex: 3,
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Image',
                                      style: registerBusinessContentTitle),
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
                                  const Text('Business Category',
                                      style: registerBusinessContentTitle),
                                ]),
                            const SizedBox(height: 5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
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
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ]),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      ItemDropdownButton(
                                        itemValue: selectedCategory,
                                        items: categoryList,
                                        onChanged: (val) {
                                          setState(() {
                                            selectedCategory = val!;
                                          });
                                        },
                                      ),
                                      const SizedBox(height: 5),
                                      ItemDropdownButton(
                                        itemValue: selectedCategory == 'Food'
                                            ? selectedSubCategory =
                                                'Malay Cuisine'
                                            : selectedCategory == 'Product'
                                                ? selectedSubCategory = 'Food'
                                                : selectedSubCategory =
                                                    'Home Cleaning',
                                        items: selectedCategory == 'Food'
                                            ? subCategoryList = foodCategoryList
                                            : selectedCategory == 'Product'
                                                ? subCategoryList =
                                                    productCategoryList
                                                : subCategoryList =
                                                    serviceCategoryList,
                                        onChanged: (val) {
                                          setState(() {
                                            selectedSubCategory = val!;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                )
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('Listing Price',
                                      style: registerBusinessContentTitle),
                                  SizedBox(width: 110),
                                  Text('Listing Name',
                                      style: registerBusinessContentTitle),
                                ]),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 35,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  SizedBox(
                                    width: 170,
                                    child: Expanded(
                                      child: StringTextArea(
                                          label: 'Price', textLine: 1),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: StringTextArea(
                                        label:
                                            'Nasi Lemak / Face Mask / Design',
                                        textLine: 1),
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
                          children: const [
                            Text('Listing Description',
                                style: registerBusinessContentTitle),
                            SizedBox(
                              height: 5,
                            ),
                            StringTextArea(
                                label: 'Describe Your Listing In Details',
                                textLine: 4),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 60,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Do you have characterization?',
                                  style: registerBusinessContentTitle),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                height: 30,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: WhiteTextButton(
                                          buttonText: 'YES',
                                          onClick: () {
                                            setState(() {
                                              isSelected = true;
                                            });
                                          }),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: WhiteTextButton(
                                          buttonText: 'NO',
                                          onClick: () {
                                            isSelected = false;
                                          }),
                                    ),
                                  ],
                                ),
                              )
                            ]),
                      ),
                      SizedBox(
                        height: 100,
                        child: Container(
                          color: Colors.amber,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 35,
                            width: 100,
                            child: PurpleTextButton(
                              buttonText: 'Confirm',
                              onClick: () {
                                storage
                                    .uploadFile(imagePath, imageName)
                                    .then((value) => print('Done'));
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
