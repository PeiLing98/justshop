import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/models/listing_model.dart';
import 'package:final_year_project/pages/homepage/listing_detail.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class DynamicLink {
  static Future<String> createDynamicLink(bool short, Listing listing) async {
    String _linkMessage;

    final DynamicLinkParameters dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse(
          "https://www.justshop.com/listing?.listingId=${listing.listingId}"),
      uriPrefix: "https://justshop.page.link",
      androidParameters: const AndroidParameters(
        packageName: "com.example.final_year_project",
        minimumVersion: 0,
      ),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink =
          await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
      url = shortLink.shortUrl;
    } else {
      url = await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);
    }

    _linkMessage = url.toString();

    return _linkMessage;
  }

  static Future<void> initDynamicLink(BuildContext context) async {
    FirebaseDynamicLinks.instance.onLink.listen((event) {
      event.link;
      print(event.link);
    }).onError((e) async {
      print(e.toString());
    });

    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;
    var isJustShop = deepLink?.pathSegments.contains('listing');

    if (isJustShop != null) {
      String? listingId = deepLink?.queryParameters['listingId'];
      print('listingId: ' + listingId!);

      if (deepLink != null) {
        try {
          // return StreamBuilder<List<Listing>>{
          //   strea
          // }
          await FirebaseFirestore.instance
              .collection('item')
              .doc(listingId)
              .get()
              .then((snapshot) {
            Listing item = snapshot.data() as Listing;

            print(item.listingName);

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ListingDetail(
                          listing: item,
                        )));
          });
        } catch (e) {
          print(e);
        }
      } else {
        return null;
      }
    }
  }
}
