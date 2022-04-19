import 'package:final_year_project/models/store_model.dart';
import 'package:flutter/material.dart';

class SellerProfileListInfo extends StatelessWidget {
  final Store store;

  const SellerProfileListInfo({Key? key, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(store.imagePath),
        Text(store.businessName),
        Text(store.latitude),
        Text(store.longtitude),
        Text(store.startTime),
        Text(store.endTime),
        Text(store.phoneNumber),
        Text(store.facebookLink),
        Text(store.instagramLink),
        Text(store.whatsappLink)
      ],
    );
  }
}
