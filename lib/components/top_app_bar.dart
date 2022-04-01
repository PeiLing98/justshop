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
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/savelist');
          },
          icon: const Icon(Icons.bookmark_border_rounded),
          iconSize: 30,
        ),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/pagescontroller');
            },
            child: const Text('JUSTSHOP', style: logoLabel)),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.shopping_bag_outlined),
          iconSize: 30,
        ),
      ],
    );
  }
}
