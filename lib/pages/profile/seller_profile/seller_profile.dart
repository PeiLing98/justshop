import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/components/input_text_box.dart';
import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/pages/profile/seller_profile/seller_business_video.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SellerProfile extends StatefulWidget {
  const SellerProfile({Key? key}) : super(key: key);

  @override
  _SellerProfileState createState() => _SellerProfileState();
}

class _SellerProfileState extends State<SellerProfile> {
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

              return StreamBuilder<UserStoreAboutBusiness>(
                  stream: DatabaseService(uid: user?.uid)
                      .userStoreAboutBusinessData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      UserStoreAboutBusiness? storeBusiness = snapshot.data;

                      return Scaffold(
                          body: SafeArea(
                              child: Container(
                        margin: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(height: 40, child: TopAppBar()),
                            SizedBox(
                              height: 40,
                              child: TitleAppBar(
                                title: "Business Profile",
                                iconFlex: 3,
                                titleFlex: 6,
                                hasArrow: true,
                                onClick: () {
                                  Navigator.pushNamed(context, '/profile');
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                              child: Container(
                                height: 490,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                child: Image.network(
                                                    userStoreData!.imagePath,
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                          ]),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ProfileTextField(
                                        textFieldLabel: 'Business Name',
                                        textFieldValue:
                                            userStoreData.businessName,
                                        textFieldLine: 1,
                                        textFieldHeight: 30,
                                        isReadOnly: true,
                                        isBold: true,
                                      ),
                                      ProfileTextField(
                                        textFieldLabel: 'Business Location',
                                        textFieldValue: userStoreData.address,
                                        textFieldLine: 3,
                                        textFieldHeight: 60,
                                        isReadOnly: true,
                                        isBold: true,
                                      ),
                                      ProfileTwoTextField(
                                        textFieldLabel: 'Opening Time',
                                        textFieldValue1:
                                            userStoreData.startTime,
                                        textFieldValue2: userStoreData.endTime,
                                        textFieldLine: 1,
                                        textFieldHeight: 30,
                                        isReadOnly: true,
                                      ),
                                      ProfileTextField(
                                        textFieldLabel: 'Contact Number',
                                        textFieldValue:
                                            userStoreData.phoneNumber,
                                        textFieldLine: 1,
                                        textFieldHeight: 30,
                                        isReadOnly: true,
                                        isBold: true,
                                      ),
                                      ProfileThreeTextField(
                                        textFieldLabel: 'Business Social Media',
                                        textFieldValue1:
                                            userStoreData.facebookLink,
                                        textFieldLine: 1,
                                        textFieldHeight: 30,
                                        textFieldValue2:
                                            userStoreData.instagramLink,
                                        textFieldValue3:
                                            userStoreData.whatsappLink,
                                        isReadOnly: true,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: ProfileTextField(
                                          textFieldLabel: 'About Your Business',
                                          textFieldValue:
                                              storeBusiness!.aboutBusiness,
                                          textFieldLine: 6,
                                          textFieldHeight: 90,
                                          isReadOnly: true,
                                          isBold: true,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: SellerBusinessVideo(
                                                businessVideo: storeBusiness
                                                    .videoBusiness),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: SizedBox(
                                width: 150,
                                child: PurpleTextButton(
                                  onClick: () {
                                    Navigator.pushNamed(
                                        context, '/updatesellerprofile');
                                  },
                                  buttonText: 'Update Seller Profile',
                                ),
                              ),
                            ),
                          ],
                        ),
                      )));
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
