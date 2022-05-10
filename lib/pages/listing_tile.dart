import 'package:final_year_project/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project/models/list_model.dart';

class ListingTile extends StatelessWidget {
  final ItemList list;
  const ListingTile({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return SizedBox(
      width: 250,
      height: 100,
      child: Card(
        elevation: 3,
        child: ListTile(
          leading: FutureBuilder(
              future:
                  storage.downloadURL('arno-senoner-MRjjcDIk3Gw-unsplash.jpg'),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(250, 129, 89, 89),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          snapshot.data!,
                          fit: BoxFit.cover,
                        )),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                return Container();
              }),
          title: Text(list.name),
          subtitle: Text('RM ${list.price}\n${list.description}'),
          isThreeLine: true,
        ),
      ),
    );
  }
}
