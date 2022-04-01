import 'package:flutter/material.dart';
import 'package:final_year_project/constant.dart';

class BlackTextButton extends StatefulWidget {
  final String buttonText;
  VoidCallback onClick;

  BlackTextButton({Key? key, required this.buttonText, required this.onClick})
      : super(key: key);

  @override
  _BlackTextButtonState createState() => _BlackTextButtonState();
}

class _BlackTextButtonState extends State<BlackTextButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
        child: TextButton(
          onPressed: widget.onClick,
          child: Text(widget.buttonText, style: buttonLabelStyle),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            overlayColor: MaterialStateProperty.all<Color>(secondaryColor),
          ),
        ),
      ),
    );
  }
}

class LinkButton extends StatefulWidget {
  final String buttonText;
  VoidCallback onClick;

  LinkButton({Key? key, required this.buttonText, required this.onClick})
      : super(key: key);

  @override
  _LinkButtonState createState() => _LinkButtonState();
}

class _LinkButtonState extends State<LinkButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: widget.onClick,
        child: Text(widget.buttonText, style: linkLabelStyle));
  }
}
