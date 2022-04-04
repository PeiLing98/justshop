import 'package:flutter/material.dart';
import 'package:final_year_project/constant.dart';

class BlackTextButton extends StatefulWidget {
  final String buttonText;
  final VoidCallback onClick;

  const BlackTextButton(
      {Key? key, required this.buttonText, required this.onClick})
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
  final VoidCallback onClick;

  const LinkButton({Key? key, required this.buttonText, required this.onClick})
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

class WhiteTextButton extends StatefulWidget {
  final String buttonText;
  final VoidCallback onClick;

  const WhiteTextButton(
      {Key? key, required this.buttonText, required this.onClick})
      : super(key: key);

  @override
  _WhiteTextButtonState createState() => _WhiteTextButtonState();
}

class _WhiteTextButtonState extends State<WhiteTextButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: TextButton(
              onPressed: widget.onClick,
              child: Text(widget.buttonText, style: buttonLabelStyle),
              style: OutlinedButton.styleFrom(
                primary: Colors.black,
                backgroundColor: Colors.white,
                side: const BorderSide(color: Colors.grey, width: 1.0),
                elevation: 1.0,
              )),
        ));
  }
}
