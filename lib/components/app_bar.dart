import 'package:final_year_project/constant.dart';
import 'package:flutter/material.dart';

class TopAppBar extends StatelessWidget {
  const TopAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          child: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/savelist');
            },
            icon: const Icon(Icons.bookmark_border_rounded),
            iconSize: 30,
          ),
        ),
        SizedBox(
          child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/pagescontroller');
              },
              child: const Text('JUSTSHOP', style: logoLabel)),
        ),
        SizedBox(
          child: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/cartpage');
            },
            icon: const Icon(Icons.shopping_bag_outlined),
            iconSize: 30,
          ),
        ),
      ],
    );
  }
}

class TitleAppBar extends StatefulWidget {
  final String title;
  final int iconFlex;
  final int titleFlex;
  final bool hasArrow;
  final VoidCallback? onClick;

  const TitleAppBar(
      {Key? key,
      required this.title,
      required this.iconFlex,
      required this.titleFlex,
      required this.hasArrow,
      this.onClick})
      : super(key: key);

  @override
  State<TitleAppBar> createState() => _TitleAppBarState();
}

class _TitleAppBarState extends State<TitleAppBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.hasArrow == true)
            Expanded(
              flex: widget.iconFlex,
              child: IconButton(
                onPressed: widget.onClick,
                icon: const Icon(Icons.arrow_back_ios),
                iconSize: 20,
                alignment: Alignment.centerLeft,
              ),
            ),
          if (widget.hasArrow == true)
            Expanded(
              flex: widget.titleFlex,
              child: Text(widget.title, style: titleAppBarFontStyle),
            ),
          if (widget.hasArrow == false)
            Expanded(
              flex: widget.titleFlex,
              child: Center(
                  child: Text(widget.title, style: titleAppBarFontStyle)),
            )
        ],
      ),
    );
  }
}

class FilterTitleAppBar extends StatefulWidget {
  final String title;
  const FilterTitleAppBar({Key? key, required this.title}) : super(key: key);

  @override
  _FilterTitleAppBarState createState() => _FilterTitleAppBarState();
}

class _FilterTitleAppBarState extends State<FilterTitleAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: secondaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 18),
        child: Text(
          widget.title,
          style: filterTitleFontStyle,
        ),
      ),
    );
  }
}
