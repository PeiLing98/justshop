import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/components/save_list_component.dart';
import 'package:final_year_project/components/tab_bar.dart';
import 'package:flutter/material.dart';

class SaveList extends StatefulWidget {
  const SaveList({Key? key}) : super(key: key);

  @override
  _SaveListState createState() => _SaveListState();
}

class _SaveListState extends State<SaveList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40, child: TopAppBar()),
              const TitleAppBar(
                  title: 'Save List',
                  iconFlex: 2,
                  titleFlex: 3,
                  hasArrow: true),
              SizedBox(
                height: 550,
                child: ListingTabBar(
                  foodBody: SingleChildScrollView(
                      child: SizedBox(
                    height: 500,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                      ),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return const SaveListComponent(
                          listingName: 'Food',
                          listingPrice: 'Price',
                        );
                      },
                    ),
                  )),
                  productBody: SingleChildScrollView(
                      child: SizedBox(
                    height: 300,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                      ),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return const SaveListComponent(
                          listingName: 'Product',
                          listingPrice: 'Price',
                        );
                      },
                    ),
                  )),
                  serviceBody: SingleChildScrollView(
                      child: SizedBox(
                    height: 500,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                      ),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return const SaveListComponent(
                          listingName: 'Service',
                          listingPrice: 'Price',
                        );
                      },
                    ),
                  )),
                ),
              )
            ],
          ),
        ))),
      ),
    );
  }
}
