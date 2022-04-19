import 'package:final_year_project/models/store_model.dart';
import 'package:final_year_project/pages/seller_profile/seller_profile_list.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SellerProfile extends StatefulWidget {
  const SellerProfile({Key? key}) : super(key: key);

  @override
  _SellerProfileState createState() => _SellerProfileState();
}

class _SellerProfileState extends State<SellerProfile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: StreamProvider<List<Store>>.value(
          value: DatabaseService(uid: '').stores,
          initialData: [],
          child: Scaffold(
            body: SafeArea(
              child: Column(
                children: const [
                  Text('Seller Profile'),
                  Expanded(child: SellerProfileList()),
                ],
              ),
            ),
          ),
        ));
  }
}
