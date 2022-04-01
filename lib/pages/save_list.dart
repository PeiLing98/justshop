import 'package:final_year_project/components/top_app_bar.dart';
import 'package:flutter/material.dart';

class SaveList extends StatefulWidget {
  const SaveList({Key? key}) : super(key: key);

  @override
  _SaveListState createState() => _SaveListState();
}

class _SaveListState extends State<SaveList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: const [
              TopAppBar(),
            ],
          ),
        ))),
      ),
    );
  }
}
