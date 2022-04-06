import 'package:flutter/material.dart';
import 'package:final_year_project/models/list.dart';

class ListingTile extends StatelessWidget {
  final ItemList list;
  const ListingTile({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 100,
      child: Card(
        elevation: 3,
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.brown[200],
          ),
          title: Text(list.name),
          subtitle: Text('RM ${list.price}\n${list.description}'),
          isThreeLine: true,
        ),
      ),
    );
  }
}
