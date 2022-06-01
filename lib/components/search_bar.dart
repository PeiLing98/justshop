import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/models/listing_model.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/pages/search/search_listing.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  List<Listing> searchResult = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.zero,
        border: Border.all(color: Colors.grey),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
        readOnly: true,
        decoration: const InputDecoration(
            icon: Icon(
              Icons.search,
              size: 20,
            ),
            hintText: 'Search food, product, service here',
            hintStyle: ratingLabelStyle,
            border: InputBorder.none,
            isCollapsed: true),
        onTap: () {
          showSearch(context: context, delegate: CustomSearchDelegate());
        },
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    final userId = Provider.of<MyUser?>(context)?.uid;

    return [
      IconButton(
        onPressed: () async {
          await DatabaseService(uid: userId)
              .updateSearchHistory(userId!, query);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SearchListing(
                        keyword: query,
                      )));
        },
        icon: const Icon(Icons.search),
        padding: const EdgeInsets.only(right: 0),
        alignment: Alignment.centerRight,
      ),
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final userId = Provider.of<MyUser?>(context)?.uid;
    return StreamBuilder<List<Listing>>(
      stream: DatabaseService(uid: "").item,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Listing>? item = snapshot.data;
          List<Listing>? matchQuery = [];
          for (var i in item!) {
            if (i.listingName.toLowerCase().contains(query.toLowerCase())) {
              matchQuery.add(
                i,
              );
            }
          }

          return GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  itemCount: matchQuery.length,
                  itemBuilder: (context, index) {
                    var resultName = matchQuery[index].listingName;

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: InkWell(
                        onTap: () async {
                          query = matchQuery[index].listingName;
                          await DatabaseService(uid: userId)
                              .updateSearchHistory(userId!, query);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchListing(
                                        keyword: resultName,
                                      )));
                        },
                        child: SizedBox(
                          height: 20,
                          child: Row(
                            children: [
                              Text(
                                resultName,
                                style: ratingLabelStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          );
        } else {
          return const Loading();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final userId = Provider.of<MyUser?>(context)?.uid;

    return StreamBuilder<List<Listing>>(
      stream: DatabaseService(uid: "").item,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Listing>? item = snapshot.data;
          List<Listing>? matchQuery = [];
          for (var i in item!) {
            if (i.listingName.toLowerCase().contains(query.toLowerCase())) {
              matchQuery.add(
                i,
              );
            }
          }

          return GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  itemCount: matchQuery.length,
                  itemBuilder: (context, index) {
                    var resultName = matchQuery[index].listingName;

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: InkWell(
                        onTap: () async {
                          query = resultName;
                          await DatabaseService(uid: userId)
                              .updateSearchHistory(userId!, query);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchListing(
                                        keyword: resultName,
                                      )));
                        },
                        child: SizedBox(
                          height: 20,
                          child: Row(
                            children: [
                              Text(
                                resultName,
                                style: ratingLabelStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          );
        } else {
          return const Loading();
        }
      },
    );
  }
}
