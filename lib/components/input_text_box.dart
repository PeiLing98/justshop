import 'package:flutter/material.dart';
import 'package:final_year_project/constant.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[/ @ . , a-z A-Z 0-9]'))
      ],
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
  final String? Function(String?)? validator;

  const IntegerInputTextBox({
    Key? key,
    required this.inputLabelText,
    required this.onChanged,
    this.validator,
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
      child: TextFormField(
        validator: widget.validator,
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
      onChanged: () => widget.onChanged,
    );
  }
}

class StringTextArea extends StatefulWidget {
  final int textLine;
  final String label;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? initialValue;

  const StringTextArea({
    Key? key,
    required this.label,
    required this.textLine,
    required this.onChanged,
    this.validator,
    this.initialValue,
  }) : super(key: key);

  @override
  _StringTextAreaState createState() => _StringTextAreaState();
}

class _StringTextAreaState extends State<StringTextArea> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
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

class ProfileTextField extends StatefulWidget {
  final String textFieldLabel;
  final String textFieldValue;
  final int textFieldLine;
  final double textFieldHeight;
  final bool isReadOnly;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final bool? isNotUpdated;
  final bool? isBold;
  final bool? isRequired;
  final TextInputType? keyboardType;

  const ProfileTextField({
    Key? key,
    required this.textFieldLabel,
    required this.textFieldValue,
    required this.textFieldLine,
    required this.textFieldHeight,
    required this.isReadOnly,
    this.validator,
    this.onChanged,
    this.isNotUpdated,
    this.isBold,
    this.keyboardType,
    this.isRequired,
  }) : super(key: key);

  @override
  _ProfileTextFieldState createState() => _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.textFieldLabel,
              style:
                  widget.isBold == true ? buttonLabelStyle : ratingLabelStyle,
            ),
            if (widget.isRequired == true)
              const Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  '*',
                  style: TextStyle(color: Colors.red),
                ),
              )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            height: widget.textFieldHeight,
            color:
                widget.isNotUpdated == true ? Colors.grey[300] : Colors.white,
            child: TextFormField(
              keyboardType: widget.keyboardType,
              validator: widget.validator,
              onChanged: widget.onChanged,
              readOnly: widget.isReadOnly,
              initialValue: widget.textFieldValue,
              style: hintStyle,
              minLines: widget.textFieldLine,
              maxLines: widget.textFieldLine,
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ProfileTwoTextField extends StatefulWidget {
  final String textFieldLabel;
  final String textFieldValue1;
  final String textFieldValue2;
  final int textFieldLine;
  final double textFieldHeight;
  final bool isReadOnly;
  final bool? isRequired;
  final String? Function(String?)? validator1;
  final String? Function(String?)? validator2;
  final Function(String)? onChanged1;
  final Function(String)? onChanged2;
  final VoidCallback? onTap1;
  final VoidCallback? onTap2;

  const ProfileTwoTextField(
      {Key? key,
      required this.textFieldLabel,
      required this.textFieldValue1,
      required this.textFieldLine,
      required this.textFieldHeight,
      required this.textFieldValue2,
      required this.isReadOnly,
      this.validator1,
      this.validator2,
      this.onChanged1,
      this.onChanged2,
      this.onTap1,
      this.onTap2,
      this.isRequired})
      : super(key: key);

  @override
  _ProfileTwoTextFieldState createState() => _ProfileTwoTextFieldState();
}

class _ProfileTwoTextFieldState extends State<ProfileTwoTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.textFieldLabel,
              style: buttonLabelStyle,
            ),
            if (widget.isRequired == true)
              const Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  '*',
                  style: TextStyle(color: Colors.red),
                ),
              )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SizedBox(
            height: widget.textFieldHeight,
            child: Row(
              children: [
                SizedBox(
                  width: 80,
                  child: TextFormField(
                    validator: widget.validator1,
                    onChanged: widget.onChanged1,
                    onTap: widget.onTap1,
                    readOnly: widget.isReadOnly,
                    initialValue: widget.textFieldValue1,
                    style: hintStyle,
                    minLines: widget.textFieldLine,
                    maxLines: widget.textFieldLine,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'to',
                  style: primaryFontStyle,
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 80,
                  child: TextFormField(
                    validator: widget.validator2,
                    onChanged: widget.onChanged2,
                    onTap: widget.onTap2,
                    readOnly: widget.isReadOnly,
                    initialValue: widget.textFieldValue2,
                    style: hintStyle,
                    minLines: widget.textFieldLine,
                    maxLines: widget.textFieldLine,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ProfileThreeTextField extends StatefulWidget {
  final String textFieldLabel;
  final String textFieldValue1;
  final String textFieldValue2;
  final String textFieldValue3;
  final int textFieldLine;
  final double textFieldHeight;
  final bool isReadOnly;
  final String? Function(String?)? validator1;
  final String? Function(String?)? validator2;
  final String? Function(String?)? validator3;
  final Function(String)? onChanged1;
  final Function(String)? onChanged2;
  final Function(String)? onChanged3;

  const ProfileThreeTextField(
      {Key? key,
      required this.textFieldLabel,
      required this.textFieldValue1,
      required this.textFieldLine,
      required this.textFieldHeight,
      required this.textFieldValue2,
      required this.textFieldValue3,
      required this.isReadOnly,
      this.validator1,
      this.validator2,
      this.validator3,
      this.onChanged1,
      this.onChanged2,
      this.onChanged3})
      : super(key: key);

  @override
  _ProfileThreeTextFieldState createState() => _ProfileThreeTextFieldState();
}

class _ProfileThreeTextFieldState extends State<ProfileThreeTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.textFieldLabel,
          style: buttonLabelStyle,
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SizedBox(
            height: widget.textFieldHeight,
            child: Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Icon(FontAwesomeIcons.facebook,
                      size: 30, color: Color.fromRGBO(66, 103, 178, 1)),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 9,
                  child: TextFormField(
                    validator: widget.validator1,
                    onChanged: widget.onChanged1,
                    readOnly: widget.isReadOnly,
                    initialValue: widget.textFieldValue1,
                    style: hintStyle,
                    minLines: widget.textFieldLine,
                    maxLines: widget.textFieldLine,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SizedBox(
            height: widget.textFieldHeight,
            child: Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Icon(FontAwesomeIcons.instagram,
                      size: 30, color: Color.fromRGBO(233, 89, 80, 1)),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 9,
                  child: TextFormField(
                    validator: widget.validator2,
                    onChanged: widget.onChanged2,
                    readOnly: widget.isReadOnly,
                    initialValue: widget.textFieldValue2,
                    style: hintStyle,
                    minLines: widget.textFieldLine,
                    maxLines: widget.textFieldLine,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SizedBox(
            height: widget.textFieldHeight,
            child: Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Icon(
                    FontAwesomeIcons.whatsapp,
                    size: 30,
                    color: Color.fromRGBO(40, 209, 70, 1),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 9,
                  child: TextFormField(
                    validator: widget.validator3,
                    onChanged: widget.onChanged3,
                    readOnly: widget.isReadOnly,
                    initialValue: widget.textFieldValue3,
                    style: hintStyle,
                    minLines: widget.textFieldLine,
                    maxLines: widget.textFieldLine,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
