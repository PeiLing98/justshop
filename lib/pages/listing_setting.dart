import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListingSetting extends StatefulWidget {
  const ListingSetting({Key? key}) : super(key: key);

  @override
  _ListingSettingState createState() => _ListingSettingState();
}

class _ListingSettingState extends State<ListingSetting> {
  final _formKey = GlobalKey<FormState>();

  String? _currentName;
  double? _currentPrice;
  String? _currentDescription;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: userData!.name,
                    validator: (val) => val!.isEmpty ? 'Listing Name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  TextFormField(
                    initialValue: userData.price.toString(),
                    validator: (val) => val!.isEmpty ? 'Listing Price' : null,
                    onChanged: (val) =>
                        setState(() => _currentPrice = double.tryParse(val)),
                  ),
                  TextFormField(
                    initialValue: userData.description,
                    validator: (val) =>
                        val!.isEmpty ? 'Listing Description' : null,
                    onChanged: (val) =>
                        setState(() => _currentDescription = val),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        // print(_currentName);
                        // print(_currentPrice);
                        // print(_currentDescription);
                        // print(userData.uid);
                        if (_formKey.currentState!.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentName ?? userData.name,
                              _currentPrice ?? userData.price,
                              _currentDescription ?? userData.description);
                        }
                      },
                      child: const Text('Update'))
                ],
              ),
            );
          } else {
            return const Loading();
          }
        });
  }
}
