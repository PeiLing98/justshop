import 'package:file_picker/file_picker.dart';
import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/components/input_text_box.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/services/database.dart';
import 'package:final_year_project/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'dart:io' as i;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class RegisterBusiness extends StatefulWidget {
  const RegisterBusiness({Key? key}) : super(key: key);

  @override
  _RegisterBusinessState createState() => _RegisterBusinessState();
}

class _RegisterBusinessState extends State<RegisterBusiness> {
  final formKey = GlobalKey<FormState>();
  PlatformFile? pickedFile;
  String imagePath = '';
  String imageName = '';

  String businessName = '';
  String latitude = '';
  String longtitude = '';
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  String phoneNumber = '';
  String facebookLink = '';
  String instagramLink = '';
  String whatsappLink = '';
  String stringStartTime = '';
  String stringEndTime = '';

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
      pickedFile = result.files.first;
    });
  }

  Future pickStartTime(BuildContext context) async {
    const initialTime = TimeOfDay(hour: 9, minute: 0);
    final newStartTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (newStartTime == null) return;

    setState(() => startTime = newStartTime);
  }

  Future pickEndTime(BuildContext context) async {
    const initialTime = TimeOfDay(hour: 9, minute: 0);
    final newEndTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (newEndTime == null) return;

    setState(() => endTime = newEndTime);
  }

  String getStartTime() {
    // ignore: unnecessary_null_comparison
    if (startTime == null) {
      return 'Start Time';
    } else {
      final hours = startTime.hour.toString().padLeft(2, '0');
      final minutes = startTime.minute.toString().padLeft(2, '0');
      stringStartTime = '$hours:$minutes';
      return stringStartTime;
    }
  }

  String getEndTime() {
    // ignore: unnecessary_null_comparison
    if (endTime == null) {
      return 'End Time';
    } else {
      final hours = endTime.hour.toString().padLeft(2, '0');
      final minutes = endTime.minute.toString().padLeft(2, '0');
      stringEndTime = '$hours:$minutes';
      return stringEndTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    final userId = Provider.of<MyUser>(context).uid;

    return Container(
      margin: const EdgeInsets.all(5),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40, child: TopAppBar()),
            const TitleAppBar(
              title: '1: Register Your Business',
              iconFlex: 2,
              titleFlex: 8,
            ),
            const SizedBox(height: 5),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Text('Business Logo', style: boldContentTitle),
                              SizedBox(width: 107),
                              Text('Business Name', style: boldContentTitle),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromARGB(250, 233, 221, 221),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: (pickedFile != null)
                                          ? Image.file(
                                              i.File(pickedFile!.path!),
                                              fit: BoxFit.cover,
                                            )
                                          : null,
                                    ),
                                  )),
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: SizedBox(
                                    height: 30,
                                    child: WhiteTextButton(
                                      buttonText: 'Upload A File',
                                      onClick: selectFile,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: SizedBox(
                                        height: 65,
                                        child: StringTextArea(
                                          label: 'Business Name',
                                          textLine: 4,
                                          onChanged: (val) {
                                            setState(() => businessName = val);
                                          },
                                        )),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: 130,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Business Location',
                                style: boldContentTitle),
                            const SizedBox(height: 5),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: StringTextArea(
                                            label: 'Latitude',
                                            textLine: 3,
                                            onChanged: (val) {
                                              setState(() => latitude = val);
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: StringTextArea(
                                            label: 'Longtitude',
                                            textLine: 3,
                                            onChanged: (val) {
                                              setState(() => longtitude = val);
                                            },
                                          ),
                                        ),
                                      ]),
                                  const SizedBox(height: 5),
                                  SizedBox(
                                    height: 30,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        MapButton(
                                          title: 'LOCATE YOUR STORE BY MAP',
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                    SizedBox(
                      height: 70,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Text('Opening Time', style: boldContentTitle),
                                SizedBox(
                                  width: 115,
                                ),
                                Text('Contact Number', style: boldContentTitle),
                              ],
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 35,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      flex: 6,
                                      child: WhiteTextButton(
                                        buttonText: getStartTime(),
                                        onClick: () => pickStartTime(context),
                                      )),
                                  const Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: Text(
                                        '-',
                                        style: primaryFontStyle,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 6,
                                      child: WhiteTextButton(
                                        buttonText: getEndTime(),
                                        onClick: () => pickEndTime(context),
                                      )),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  Expanded(
                                    flex: 12,
                                    child: SizedBox(
                                      height: 35,
                                      width: 180,
                                      child: StringTextArea(
                                        label: 'Phone Number',
                                        textLine: 1,
                                        // validator: (val) {
                                        //   if (val!.isEmpty ||
                                        //       !RegExp(phoneReg).hasMatch(val)) {
                                        //     return 'PLease enter correct phone number';
                                        //   } else {
                                        //     return null;
                                        //   }
                                        // },
                                        onChanged: (val) {
                                          setState(() => phoneNumber = val);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ]),
                    ),
                    SizedBox(
                      height: 150,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Business Social Media',
                                style: boldContentTitle),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Icon(FontAwesomeIcons.facebook,
                                    size: 35,
                                    color: Color.fromRGBO(66, 103, 178, 1)),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 35,
                                    child: StringTextArea(
                                      label: 'Facebook Link',
                                      textLine: 1,
                                      onChanged: (val) {
                                        setState(() => facebookLink = val);
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.instagram,
                                  size: 35,
                                  color: Color.fromRGBO(233, 89, 80, 1),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 35,
                                    child: StringTextArea(
                                      label: 'Instagram Link',
                                      textLine: 1,
                                      onChanged: (val) {
                                        setState(() => instagramLink = val);
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.whatsapp,
                                  size: 35,
                                  color: Color.fromRGBO(40, 209, 70, 1),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 35,
                                    child: StringTextArea(
                                      label: 'WhatsApp Link',
                                      textLine: 1,
                                      onChanged: (val) {
                                        setState(() => whatsappLink = val);
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: SizedBox(
                        height: 35,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 100,
                              height: 35,
                              child: PurpleTextButton(
                                buttonText: 'Register',
                                onClick: () async {
                                  if (formKey.currentState!.validate()) {
                                    storage
                                        .uploadFile(imagePath, imageName)
                                        .then((value) => print('Done'));

                                    await DatabaseService(uid: userId)
                                        .updateStoreData(
                                            imagePath,
                                            businessName,
                                            latitude,
                                            longtitude,
                                            stringStartTime,
                                            stringEndTime,
                                            phoneNumber,
                                            facebookLink,
                                            instagramLink,
                                            whatsappLink);
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              height: 35,
                              child: PurpleTextButton(
                                buttonText: 'Next',
                                onClick: () {
                                  Navigator.pushNamed(context, '/setupstore');
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
