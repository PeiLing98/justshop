import 'package:flutter/material.dart';
import 'package:final_year_project/constant.dart';

class StringInputTextBox extends StatefulWidget {
  final String inputLabelText;

  // ignore: use_key_in_widget_constructors
  const StringInputTextBox({Key? key, required this.inputLabelText})
      : super(key: key);

  @override
  _StringInputTextBoxState createState() => _StringInputTextBoxState();
}

class _StringInputTextBoxState extends State<StringInputTextBox> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(35, 10, 35, 0),
          child: TextFormField(
            cursorHeight: 18,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              labelText: widget.inputLabelText,
              floatingLabelStyle: const TextStyle(
                fontSize: 20,
                color: secondaryColor,
              ),
              contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            style: primaryFontStyle,
          ),
        ));
  }
}
