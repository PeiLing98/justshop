import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateSellerProfile extends StatefulWidget {
  const UpdateSellerProfile({Key? key}) : super(key: key);

  @override
  _UpdateSellerProfileState createState() => _UpdateSellerProfileState();
}

class _UpdateSellerProfileState extends State<UpdateSellerProfile> {
  final _formKey = GlobalKey<FormState>();

  int? _currentStoreId;
  String? _currentImagePath;
  String? _currentBusinessName;
  String? _currentLatitude;
  String? _currentLongtitude;
  String? _currentAddress;
  String? _currentStartTime;
  String? _currentEndTime;
  String? _currentPhoneNumber;
  String? _currentFacebookLink;
  String? _currentInstagramLink;
  String? _currentWhatsappLink;
  List? _currentListing;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);

    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: StreamBuilder<UserStoreData>(
            stream: DatabaseService(uid: user.uid).userStoreData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserStoreData? userStoreData = snapshot.data;
                return SafeArea(
                  child: Scaffold(
                    body: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            initialValue: userStoreData!.imagePath,
                            validator: (val) =>
                                val!.isEmpty ? 'Image Path' : null,
                            onChanged: (val) =>
                                setState(() => _currentImagePath = val),
                          ),
                          TextFormField(
                            initialValue: userStoreData.businessName,
                            validator: (val) =>
                                val!.isEmpty ? 'Business Name' : null,
                            onChanged: (val) =>
                                setState(() => _currentBusinessName = val),
                          ),
                          TextFormField(
                            initialValue: userStoreData.latitude,
                            validator: (val) =>
                                val!.isEmpty ? 'Latitude' : null,
                            onChanged: (val) =>
                                setState(() => _currentLatitude = val),
                          ),
                          TextFormField(
                            initialValue: userStoreData.longtitude,
                            validator: (val) =>
                                val!.isEmpty ? 'Longtitude' : null,
                            onChanged: (val) =>
                                setState(() => _currentLongtitude = val),
                          ),
                          TextFormField(
                            initialValue: userStoreData.address,
                            validator: (val) => val!.isEmpty ? 'Address' : null,
                            onChanged: (val) =>
                                setState(() => _currentAddress = val),
                          ),
                          TextFormField(
                            initialValue: userStoreData.startTime,
                            validator: (val) =>
                                val!.isEmpty ? 'Start Time' : null,
                            onChanged: (val) =>
                                setState(() => _currentStartTime = val),
                          ),
                          TextFormField(
                            initialValue: userStoreData.endTime,
                            validator: (val) =>
                                val!.isEmpty ? 'End Time' : null,
                            onChanged: (val) =>
                                setState(() => _currentEndTime = val),
                          ),
                          TextFormField(
                            initialValue: userStoreData.phoneNumber,
                            validator: (val) =>
                                val!.isEmpty ? 'PhoneNumber' : null,
                            onChanged: (val) =>
                                setState(() => _currentPhoneNumber = val),
                          ),
                          TextFormField(
                            initialValue: userStoreData.facebookLink,
                            validator: (val) =>
                                val!.isEmpty ? 'Facebook Link' : null,
                            onChanged: (val) =>
                                setState(() => _currentFacebookLink = val),
                          ),
                          TextFormField(
                            initialValue: userStoreData.instagramLink,
                            validator: (val) =>
                                val!.isEmpty ? 'Instagram Link' : null,
                            onChanged: (val) =>
                                setState(() => _currentInstagramLink = val),
                          ),
                          TextFormField(
                            initialValue: userStoreData.whatsappLink,
                            validator: (val) =>
                                val!.isEmpty ? 'Whatsapp Link' : null,
                            onChanged: (val) =>
                                setState(() => _currentWhatsappLink = val),
                          ),
                          TextFormField(
                            initialValue: userStoreData.listing.toString(),
                            validator: (val) => val!.isEmpty ? 'Listing' : null,
                            onChanged: (val) =>
                                setState(() => _currentListing = val as List?),
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                // print(_currentName);
                                // print(_currentPrice);
                                // print(_currentDescription);
                                // print(userData.uid);
                                if (_formKey.currentState!.validate()) {
                                  await DatabaseService(uid: user.uid)
                                      .updateStoreData(
                                          _currentStoreId ??
                                              userStoreData.storeId,
                                          _currentImagePath ??
                                              userStoreData.imagePath,
                                          _currentBusinessName ??
                                              userStoreData.businessName,
                                          _currentLatitude ??
                                              userStoreData.latitude,
                                          _currentLongtitude ??
                                              userStoreData.longtitude,
                                          _currentAddress ??
                                              userStoreData.address,
                                          _currentStartTime ??
                                              userStoreData.startTime,
                                          _currentEndTime ??
                                              userStoreData.endTime,
                                          _currentPhoneNumber ??
                                              userStoreData.phoneNumber,
                                          _currentFacebookLink ??
                                              userStoreData.facebookLink,
                                          _currentInstagramLink ??
                                              userStoreData.instagramLink,
                                          _currentWhatsappLink ??
                                              userStoreData.whatsappLink,
                                          _currentListing ??
                                              userStoreData.listing);
                                }
                              },
                              child: const Text('Update'))
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const Loading();
              }
            }));
  }
}
