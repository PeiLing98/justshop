import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/components/input_text_box.dart';
import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/modals/alert_text_modal.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/pages/profile/user_profile/user_profile.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateUserProfile extends StatefulWidget {
  const UpdateUserProfile({Key? key}) : super(key: key);

  @override
  _UpdateUserProfileState createState() => _UpdateUserProfileState();
}

class _UpdateUserProfileState extends State<UpdateUserProfile> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String? _currentState = 'Perak';
  List<String> state = [
    'Johor',
    'Kedah',
    'Kelantan',
    'Melaka',
    'Negeri Sembilan',
    'Pahang',
    'Penang',
    'Perak',
    'Perlis',
    'Sabah',
    'Sarawak',
    'Selangor',
    'Terengganu',
    'Wilayah Persekutuan Kuala Lumpur',
    'Labuan',
    'Putrajaya'
  ];

  String? _currentUsername;
  String? _currentEmail;
  String? _currentPhoneNumber;
  String? _currentAddress;
  String? _currentPostcode;
  String? _currentCity;

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
      child: loading
          ? const Loading()
          : StreamBuilder<UserData>(
              stream: DatabaseService(uid: user.uid).userData,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Loading();
                }
                UserData? userData = snapshot.data;
                return Scaffold(
                  body: SafeArea(
                    child: Column(
                      children: [
                        const SizedBox(height: 40, child: TopAppBar()),
                        const Expanded(
                          flex: 1,
                          child: TitleAppBar(
                            title: "Update User Profile",
                            iconFlex: 3,
                            titleFlex: 7,
                            hasArrow: true,
                          ),
                        ),
                        Expanded(
                          flex: 12,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
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
                                                border: Border.all(
                                                    color: Colors.black)),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: const Icon(
                                                  Icons.person_rounded,
                                                  size: 30,
                                                )),
                                          ),
                                        ]),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ProfileTextField(
                                            textFieldLabel: 'Username',
                                            textFieldValue: userData!.username,
                                            textFieldLine: 1,
                                            textFieldHeight: 30,
                                            isReadOnly: false,
                                            validator: (val) => val!.isEmpty
                                                ? 'Username'
                                                : null,
                                            onChanged: (val) => setState(
                                                () => _currentUsername = val),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ProfileTextField(
                                            textFieldLabel: 'Email',
                                            textFieldValue: userData.email,
                                            textFieldLine: 1,
                                            textFieldHeight: 30,
                                            isReadOnly: true,
                                            isNotUpdated: true,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ProfileTextField(
                                            textFieldLabel: 'Phone Number',
                                            textFieldValue:
                                                userData.phoneNumber,
                                            textFieldLine: 1,
                                            textFieldHeight: 30,
                                            isReadOnly: false,
                                            validator: (val) => val!.isEmpty
                                                ? 'Phone Number'
                                                : null,
                                            onChanged: (val) => setState(() =>
                                                _currentPhoneNumber = val),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ProfileTextField(
                                            textFieldLabel: 'Address',
                                            textFieldValue: userData.address,
                                            textFieldLine: 2,
                                            textFieldHeight: 50,
                                            isReadOnly: false,
                                            validator: (val) =>
                                                val!.isEmpty ? 'Address' : null,
                                            onChanged: (val) => setState(
                                                () => _currentAddress = val),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ProfileTextField(
                                            textFieldLabel: 'Postcode',
                                            textFieldValue: userData.postcode,
                                            textFieldLine: 1,
                                            textFieldHeight: 30,
                                            isReadOnly: false,
                                            validator: (val) => val!.isEmpty
                                                ? 'Postcode'
                                                : null,
                                            onChanged: (val) => setState(
                                                () => _currentPostcode = val),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: ProfileTextField(
                                            textFieldLabel: 'City',
                                            textFieldValue: userData.city,
                                            textFieldLine: 1,
                                            textFieldHeight: 30,
                                            isReadOnly: false,
                                            // validator: (val) =>
                                            //     val!.isEmpty ? 'City' : null,
                                            onChanged: (val) => setState(
                                                () => _currentCity = val),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'State',
                                                style: buttonLabelStyle,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              SizedBox(
                                                height: 35,
                                                child: DropdownButtonFormField<
                                                        String>(
                                                    iconSize: 20,
                                                    decoration: const InputDecoration(
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                        width:
                                                                            1),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .zero),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                        width:
                                                                            1),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .zero),
                                                        contentPadding:
                                                            EdgeInsets.all(10),
                                                        hintStyle: hintStyle),
                                                    value: userData.state,
                                                    onChanged: (item) =>
                                                        setState(() =>
                                                            _currentState =
                                                                item!),
                                                    items: state
                                                        .map((item) => DropdownMenuItem<String>(
                                                            value: item,
                                                            child: Text(
                                                              item,
                                                              style: hintStyle,
                                                            )))
                                                        .toList()),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 10),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              width: 100,
                                              child: PurpleTextButton(
                                                onClick: () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return YesNoAlertModal(
                                                              alertContent:
                                                                  'Are you sure to update your user profile?',
                                                              closeOnClick: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              yesOnClick:
                                                                  () async {
                                                                await DatabaseService(uid: user.uid).updateUserData(
                                                                    _currentUsername ??
                                                                        userData
                                                                            .username,
                                                                    _currentEmail ??
                                                                        userData
                                                                            .email,
                                                                    _currentPhoneNumber ??
                                                                        userData
                                                                            .phoneNumber,
                                                                    _currentAddress ??
                                                                        userData
                                                                            .address,
                                                                    _currentPostcode ??
                                                                        userData
                                                                            .postcode,
                                                                    _currentCity ??
                                                                        userData
                                                                            .city,
                                                                    _currentState ??
                                                                        userData
                                                                            .state);
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                const UserProfile()));
                                                              },
                                                              noOnClick: () {
                                                                Navigator.pop(
                                                                    context);
                                                              });
                                                        });
                                                  }
                                                },
                                                buttonText: 'Save',
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
