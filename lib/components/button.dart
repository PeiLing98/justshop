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

class PurpleTextButton extends StatefulWidget {
  final String buttonText;
  final VoidCallback onClick;

  const PurpleTextButton(
      {Key? key, required this.buttonText, required this.onClick})
      : super(key: key);

  @override
  _PurpleTextButtonState createState() => _PurpleTextButtonState();
}

class _PurpleTextButtonState extends State<PurpleTextButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: widget.onClick,
        child: Text(widget.buttonText, style: buttonLabelStyle),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(secondaryColor),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          overlayColor: MaterialStateProperty.all<Color>(secondaryColor),
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
        child: TextButton(
            onPressed: widget.onClick,
            child: Text(widget.buttonText, style: buttonLabelStyle),
            style: OutlinedButton.styleFrom(
              primary: Colors.black,
              backgroundColor: Colors.white,
              side: const BorderSide(color: Colors.grey, width: 1.0),
              elevation: 1.0,
            )));
  }
}

class ItemDropdownButton extends StatefulWidget {
  String itemValue = '';
  var items = [''];
  final void Function(String?) onChanged;

  ItemDropdownButton(
      {Key? key,
      required this.itemValue,
      required this.items,
      required this.onChanged})
      : super(key: key);

  @override
  _ItemDropdownButtonState createState() => _ItemDropdownButtonState();
}

class _ItemDropdownButtonState extends State<ItemDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1),
              borderRadius: BorderRadius.zero),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1),
              borderRadius: BorderRadius.zero),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
        ),
        value: widget.itemValue,
        iconSize: 18,
        items: widget.items.map<DropdownMenuItem<String>>((items) {
          return DropdownMenuItem<String>(
            value: items,
            child: Text(
              items,
              style: primaryFontStyle,
            ),
          );
        }).toList(),
        onChanged: widget.onChanged,
      ),
    );
  }
}

class MapButton extends StatefulWidget {
  String title;
  MapButton({Key? key, required this.title}) : super(key: key);

  @override
  _MapButtonState createState() => _MapButtonState();
}

class _MapButtonState extends State<MapButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        widget.title,
        style: const TextStyle(color: Colors.black, fontSize: 12),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        overlayColor: MaterialStateProperty.all<Color>(secondaryColor),
        elevation: MaterialStateProperty.all<double>(1.0),
        side: MaterialStateProperty.all<BorderSide>(
            const BorderSide(width: 1.0, color: Colors.grey)),
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/locationmap');
      },
    );
  }
}

class ImageButton extends StatefulWidget {
  final String categoryLabel;
  final AssetImage imageLink;
  final VoidCallback onTap;

  const ImageButton(
      {Key? key,
      required this.categoryLabel,
      required this.imageLink,
      required this.onTap})
      : super(key: key);

  @override
  _ImageButtonState createState() => _ImageButtonState();
}

class _ImageButtonState extends State<ImageButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: secondaryColor,
        child: InkWell(
          splashColor: Colors.black26,
          onTap: widget.onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Ink.image(
                image: widget.imageLink,
                height: 50,
                width: 70,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 70,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Center(
                    child: Text(
                      widget.categoryLabel,
                      style: categoryText,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FilterOptionButton extends StatefulWidget {
  final String buttonText;

  const FilterOptionButton({Key? key, required this.buttonText})
      : super(key: key);

  @override
  _FilterOptionButtonState createState() => _FilterOptionButtonState();
}

class _FilterOptionButtonState extends State<FilterOptionButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: SizedBox(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            alignment: Alignment.center,
            child: Text(widget.buttonText, style: ratingLabelStyle),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(5))),
      ),
    );
  }
}
