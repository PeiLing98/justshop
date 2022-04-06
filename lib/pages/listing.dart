import 'package:final_year_project/models/list.dart';
import 'package:final_year_project/pages/listing_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Listing extends StatefulWidget {
  final Axis scrollDirection;
  const Listing({Key? key, required this.scrollDirection}) : super(key: key);

  @override
  _ListingState createState() => _ListingState();
}

class _ListingState extends State<Listing> {
  @override
  Widget build(BuildContext context) {
    final listing = Provider.of<List<ItemList>?>(context) ?? [];

    // listing?.forEach((list) {
    //   print(list.name);
    //   print(list.price);
    //   print(list.description);
    // });

    //print(listing.docs);
    // for (var doc in listing.docs) {
    //   print(doc.data());
    // }
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: ListView.builder(
        scrollDirection: widget.scrollDirection,
        itemCount: listing.length,
        itemBuilder: (context, index) {
          return ListingTile(list: listing[index]);
        },
        //shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
      ),
    );
  }
}
