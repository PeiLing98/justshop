import 'package:flutter/material.dart';
import 'package:final_year_project/constant.dart';
import 'package:flutter/services.dart';

class StringInputTextBox extends StatefulWidget {
  final String inputLabelText;
  final Function(String)? onChanged;
  final bool isPassword;
  final String? Function(String?)? validator;

  const StringInputTextBox(
      {Key? key,
      required this.inputLabelText,
      this.onChanged,
      required this.isPassword,
      this.validator})
      : super(key: key);

  @override
  _StringInputTextBoxState createState() => _StringInputTextBoxState();
}

class _StringInputTextBoxState extends State<StringInputTextBox> {
  //final TextEditingController _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      obscureText: widget.isPassword,
      //controller: _inputController,
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
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.red),
            borderRadius: BorderRadius.zero),
      ),
      style: primaryFontStyle,
      //onChanged: () => widget.onChanged!(_inputController.text),
      onChanged: widget.onChanged,
    );
  }
}

class IntegerInputTextBox extends StatefulWidget {
  final String inputLabelText;
  final Function(int)? onChanged;

  const IntegerInputTextBox({
    Key? key,
    required this.inputLabelText,
    required this.onChanged,
  }) : super(key: key);

  @override
  _IntegerInputTextBoxState createState() => _IntegerInputTextBoxState();
}

class _IntegerInputTextBoxState extends State<IntegerInputTextBox> {
  //final formKey = GlobalKey<FormState>();
  //final TextEditingController number = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      //key: formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(35, 10, 35, 0),
        child: TextFormField(
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.number,
          //controller: number,
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
      ),
      onChanged: () => widget.onChanged,
    );
  }
}

class StringTextArea extends StatefulWidget {
  final int textLine;
  final String label;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const StringTextArea({
    Key? key,
    required this.label,
    required this.textLine,
    required this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  _StringTextAreaState createState() => _StringTextAreaState();
}

class _StringTextAreaState extends State<StringTextArea> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: hintStyle,
      minLines: widget.textLine,
      maxLines: widget.textLine,
      decoration: InputDecoration(
        hintText: widget.label,
        contentPadding: const EdgeInsets.all(10),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
      onChanged: widget.onChanged,
      validator: widget.validator,
    );
  }
}
