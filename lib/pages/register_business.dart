import 'package:file_picker/file_picker.dart';
import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/components/button.dart';
import 'package:final_year_project/components/input_text_box.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'dart:io' as i;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterBusiness extends StatefulWidget {
  const RegisterBusiness({Key? key}) : super(key: key);

  @override
  _RegisterBusinessState createState() => _RegisterBusinessState();
}

class _RegisterBusinessState extends State<RegisterBusiness> {
  PlatformFile? pickedFile;
  String imagePath = '';
  String imageName = '';

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

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();

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
            Padding(
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
                            Text('Business Logo',
                                style: registerBusinessContentTitle),
                            SizedBox(width: 107),
                            Text('Business Name',
                                style: registerBusinessContentTitle),
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
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: SizedBox(
                                  height: 30,
                                  child: WhiteTextButton(
                                    buttonText: 'Upload A File',
                                    onClick: selectFile,
                                  ),
                                ),
                              ),
                            ),
                            const Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: SizedBox(
                                      height: 65,
                                      child: StringTextArea(
                                          label: 'Business Name', textLine: 4)),
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
                              style: registerBusinessContentTitle),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                const StringTextArea(
                                    label: 'Your Store Address', textLine: 3),
                                const SizedBox(height: 5),
                                SizedBox(
                                  height: 30,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                              Text('Opening Time',
                                  style: registerBusinessContentTitle),
                              SizedBox(
                                width: 115,
                              ),
                              Text('Contact Number',
                                  style: registerBusinessContentTitle),
                            ],
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            height: 35,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Expanded(
                                  flex: 6,
                                  child: StringTextArea(
                                      label: 'Start Time', textLine: 1),
                                ),
                                Expanded(
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
                                  child: StringTextArea(
                                      label: 'End Time', textLine: 1),
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                Expanded(
                                  flex: 12,
                                  child: SizedBox(
                                    height: 35,
                                    width: 180,
                                    child: StringTextArea(
                                        label: 'Phone Number', textLine: 1),
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
                              style: registerBusinessContentTitle),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: const [
                              Icon(FontAwesomeIcons.facebook,
                                  size: 35,
                                  color: Color.fromRGBO(66, 103, 178, 1)),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 35,
                                  child: StringTextArea(
                                      label: 'Facebook Link', textLine: 1),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: const [
                              Icon(
                                FontAwesomeIcons.instagram,
                                size: 35,
                                color: Color.fromRGBO(233, 89, 80, 1),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 35,
                                  child: StringTextArea(
                                      label: 'Instagram Link', textLine: 1),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: const [
                              Icon(
                                FontAwesomeIcons.whatsapp,
                                size: 35,
                                color: Color.fromRGBO(40, 209, 70, 1),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 35,
                                  child: StringTextArea(
                                      label: 'WhatsApp Link', textLine: 1),
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
                              onClick: () {
                                storage
                                    .uploadFile(imagePath, imageName)
                                    .then((value) => print('Done'));
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
          ],
        ),
      ),
    );
  }
}
