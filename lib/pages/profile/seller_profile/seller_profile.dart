import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/pages/profile/seller_profile/seller_profile_list.dart';
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
    final user = Provider.of<MyUser>(context);
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: StreamBuilder<UserStoreData>(
            stream: DatabaseService(uid: user.uid).userStoreData,
            //initialData: null,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserStoreData? userData = snapshot.data;
                return Scaffold(
                  body: SafeArea(
                    child: Column(
                      children: [
                        const Text('Seller Profile'),
                        const Expanded(child: SellerProfileList()),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, '/updatesellerprofile');
                          },
                          child: const Text('Update Seller Profile'),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Loading();
              }
            }));
  }
}
