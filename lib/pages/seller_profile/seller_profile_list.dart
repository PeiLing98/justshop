import 'package:final_year_project/models/store_model.dart';
import 'package:final_year_project/pages/seller_profile/seller_profile_list_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SellerProfileList extends StatefulWidget {
  const SellerProfileList({Key? key}) : super(key: key);

  @override
  _SellerProfileListState createState() => _SellerProfileListState();
}

class _SellerProfileListState extends State<SellerProfileList> {
  @override
  Widget build(BuildContext context) {
    final stores = Provider.of<List<Store>>(context);

    return ListView.builder(
      itemCount: stores.length,
      itemBuilder: (context, index) {
        return SellerProfileListInfo(store: stores[index]);
      },
    );
  }
}
