import 'package:file_picker/file_picker.dart';
import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/components/input_text_box.dart';
import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/components/location_map.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/modals/alert_text_modal.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/pages/profile/seller_profile/seller_profile.dart';
import 'package:final_year_project/services/database.dart';
import 'package:final_year_project/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io' as i;

class UpdateSellerProfile extends StatefulWidget {
  const UpdateSellerProfile({Key? key}) : super(key: key);

  @override
  _UpdateSellerProfileState createState() => _UpdateSellerProfileState();
}

class _UpdateSellerProfileState extends State<UpdateSellerProfile> {
  final _formKey = GlobalKey<FormState>();
  final Storage storage = Storage();

  String imagePath = "";
  String imageName = "";
  PlatformFile? pickedFile;
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();

  String? _currentStoreId;
  String? _currentImagePath;
  String? _currentBusinessName;
  String? _currentLatitude;
  String? _currentLongtitude;
  String? _currentAddress;
  String? _currentCity;
  String? _currentState;
  String? _currentStartTime;
  String? _currentEndTime;
  String? _currentPhoneNumber;
  String? _currentFacebookLink;
  String? _currentInstagramLink;
  String? _currentWhatsappLink;
  // List<Listing>? _currentListing;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg'],
    );

    if (result == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No image is selected.')));
      return null;
    }

    imagePath = result.files.single.path!;
    imageName = result.files.single.name;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  void _awaitReturnValueFromLocationMap(BuildContext context) async {
    // start the GoogleMap and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LocationMap(),
        ));
    // after the map result comes back update the Text widget with it
    setState(() {
      _currentAddress = result[0];
      _currentLatitude = result[1];
      _currentLongtitude = result[2];
      _currentCity = result[3];
      _currentState = result[4];
    });
  }

  Future pickStartTime(BuildContext context) async {
    const initialTime = TimeOfDay(hour: 9, minute: 0);
    final newStartTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (newStartTime == null) return;

    setState(() {
      startTime = newStartTime;
      _currentStartTime = getStartTime();
    });
  }

  Future pickEndTime(BuildContext context) async {
    const initialTime = TimeOfDay(hour: 9, minute: 0);
    final newEndTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (newEndTime == null) return;

    setState(() {
      endTime = newEndTime;
      _currentEndTime = getEndTime();
    });
  }

  String? getStartTime() {
    // ignore: unnecessary_null_comparison
    if (startTime == null) {
      return 'Start Time';
    } else {
      final hours = startTime.hour.toString().padLeft(2, '0');
      final minutes = startTime.minute.toString().padLeft(2, '0');
      String start;
      start = '$hours:$minutes';
      return start;
    }
  }

  String? getEndTime() {
    // ignore: unnecessary_null_comparison
    if (endTime == null) {
      return 'End Time';
    } else {
      final hours = endTime.hour.toString().padLeft(2, '0');
      final minutes = endTime.minute.toString().padLeft(2, '0');
      String end;
      end = '$hours:$minutes';
      return end;
    }
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
        child: StreamBuilder<UserStoreData>(
            stream: DatabaseService(uid: user?.uid).userStoreData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserStoreData? userStoreData = snapshot.data;
                return Scaffold(
                    body: SafeArea(
                        child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Expanded(flex: 1, child: TopAppBar()),
                    Expanded(
                      flex: 1,
                      child: TitleAppBar(
                        title: "Update Business Profile",
                        iconFlex: 2,
                        titleFlex: 7,
                        hasArrow: true,
                        onClick: () {
                          Navigator.pushNamed(context, '/sellerprofile');
                        },
                      ),
                    ),
                    Expanded(
                        flex: 13,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                          child: SingleChildScrollView(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
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
                                            child: (pickedFile != null)
                                                ? Image.file(
                                                    i.File(pickedFile!.path!),
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.network(
                                                    userStoreData!.imagePath,
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                      ]),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 30,
                                        width: 100,
                                        child: WhiteTextButton(
                                          buttonText: 'Upload A File',
                                          onClick: selectFile,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ProfileTextField(
                                    textFieldLabel: 'Business Name',
                                    textFieldValue: userStoreData!.businessName,
                                    textFieldLine: 1,
                                    textFieldHeight: 30,
                                    isReadOnly: false,
                                    validator: (val) =>
                                        val!.isEmpty ? 'Business Name' : null,
                                    onChanged: (val) => setState(
                                        () => _currentBusinessName = val),
                                  ),
                                  ProfileTextField(
                                    textFieldLabel: 'Business Location',
                                    textFieldValue: userStoreData.address,
                                    textFieldLine: 3,
                                    textFieldHeight: 60,
                                    isReadOnly: false,
                                    validator: (val) =>
                                        val!.isEmpty ? 'Address' : null,
                                    onChanged: (val) =>
                                        setState(() => _currentAddress = val),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 30,
                                        child: TextButton(
                                          child: const Text(
                                            'LOCATE YOUR STORE BY MAP',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12),
                                          ),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.white),
                                            overlayColor: MaterialStateProperty
                                                .all<Color>(secondaryColor),
                                            elevation: MaterialStateProperty
                                                .all<double>(1.0),
                                            side: MaterialStateProperty.all<
                                                    BorderSide>(
                                                const BorderSide(
                                                    width: 1.0,
                                                    color: Colors.grey)),
                                          ),
                                          onPressed: () {
                                            _awaitReturnValueFromLocationMap(
                                                context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  ProfileTwoTextField(
                                    textFieldLabel: 'Opening Time',
                                    textFieldValue1: userStoreData.startTime,
                                    textFieldValue2: userStoreData.endTime,
                                    textFieldLine: 1,
                                    textFieldHeight: 30,
                                    isReadOnly: true,
                                    validator1: (val) =>
                                        val!.isEmpty ? 'Start Time' : null,
                                    onChanged1: (val) =>
                                        setState(() => _currentStartTime = val),
                                    onTap1: () => pickStartTime(context),
                                    validator2: (val) =>
                                        val!.isEmpty ? 'End Time' : null,
                                    onChanged2: (val) =>
                                        setState(() => _currentEndTime = val),
                                    onTap2: () => pickEndTime(context),
                                  ),
                                  ProfileTextField(
                                    textFieldLabel: 'Contact Number',
                                    textFieldValue: userStoreData.phoneNumber,
                                    textFieldLine: 1,
                                    textFieldHeight: 30,
                                    isReadOnly: false,
                                    validator: (val) =>
                                        val!.isEmpty ? 'PhoneNumber' : null,
                                    onChanged: (val) => setState(
                                        () => _currentPhoneNumber = val),
                                  ),
                                  ProfileThreeTextField(
                                    textFieldLabel: 'Business Social Media',
                                    textFieldValue1: userStoreData.facebookLink,
                                    textFieldLine: 1,
                                    textFieldHeight: 30,
                                    textFieldValue2:
                                        userStoreData.instagramLink,
                                    textFieldValue3: userStoreData.whatsappLink,
                                    isReadOnly: false,
                                    validator1: (val) =>
                                        val!.isEmpty ? 'Facebook Link' : null,
                                    onChanged1: (val) => setState(
                                        () => _currentFacebookLink = val),
                                    validator2: (val) =>
                                        val!.isEmpty ? 'Instagram Link' : null,
                                    onChanged2: (val) => setState(
                                        () => _currentInstagramLink = val),
                                    validator3: (val) =>
                                        val!.isEmpty ? 'Whatsapp Link' : null,
                                    onChanged3: (val) => setState(
                                        () => _currentWhatsappLink = val),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: PurpleTextButton(
                                          onClick: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return YesNoAlertModal(
                                                      alertContent:
                                                          'Are you sure to update your business profile?',
                                                      closeOnClick: () {
                                                        Navigator.pop(context);
                                                      },
                                                      yesOnClick: () async {
                                                        if (imagePath != "") {
                                                          storage
                                                              .uploadFile(
                                                                  imagePath,
                                                                  imageName)
                                                              .then((value) =>
                                                                  print(
                                                                      'Done'));

                                                          _currentImagePath =
                                                              await storage
                                                                  .downloadURL(
                                                                      imageName);
                                                        }

                                                        await DatabaseService(
                                                                uid: user?.uid)
                                                            .updateStoreData(
                                                          _currentStoreId ??
                                                              userStoreData
                                                                  .storeId,
                                                          _currentImagePath ??
                                                              userStoreData
                                                                  .imagePath,
                                                          _currentBusinessName ??
                                                              userStoreData
                                                                  .businessName,
                                                          _currentLatitude ??
                                                              userStoreData
                                                                  .latitude,
                                                          _currentLongtitude ??
                                                              userStoreData
                                                                  .longtitude,
                                                          _currentAddress ??
                                                              userStoreData
                                                                  .address,
                                                          _currentCity ??
                                                              userStoreData
                                                                  .city,
                                                          _currentState ??
                                                              userStoreData
                                                                  .state,
                                                          _currentStartTime ??
                                                              userStoreData
                                                                  .startTime,
                                                          _currentEndTime ??
                                                              userStoreData
                                                                  .endTime,
                                                          _currentPhoneNumber ??
                                                              userStoreData
                                                                  .phoneNumber,
                                                          _currentFacebookLink ??
                                                              userStoreData
                                                                  .facebookLink,
                                                          _currentInstagramLink ??
                                                              userStoreData
                                                                  .instagramLink,
                                                          _currentWhatsappLink ??
                                                              userStoreData
                                                                  .whatsappLink,
                                                        );

                                                        // await DatabaseService(uid: user.uid).updateItemData(
                                                        //   docId,
                                                        //   storeId,
                                                        //   storeName,
                                                        //   storeImage,
                                                        //   listingImagePath,
                                                        //   selectedCategory,
                                                        //   selectedSubCategory,
                                                        //   price, listingName, listingDescription)

                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const SellerProfile()));
                                                      },
                                                      noOnClick: () {
                                                        Navigator.pop(context);
                                                      },
                                                    );
                                                  });
                                            }
                                          },
                                          buttonText: 'Save',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                  ],
                )));
              } else {
                return const Loading();
              }
            }));
  }
}
