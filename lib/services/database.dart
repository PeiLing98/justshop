import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/models/list_model.dart';
import 'package:final_year_project/models/store_model.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

// --------------------------- listing ---------------------------------------------------
  //collection reference
  final CollectionReference listingCollection =
      FirebaseFirestore.instance.collection('listing');

  Future updateUserData(String name, double price, String description) async {
    return await listingCollection.doc(uid).set({
      'name': name,
      'price': price,
      'description': description,
    });
  }

  // listing from snapshot
  List<ItemList> _itemListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ItemList(
          name: doc.get('name') ?? '',
          price: doc.get('price') ?? 0,
          description: doc.get('description') ?? '');
    }).toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid!,
      name: snapshot.get('name'),
      price: snapshot.get('price'),
      description: snapshot.get('description'),
    );
  }

  // get listing streams
  Stream<List<ItemList>> get listings {
    return listingCollection.snapshots().map(_itemListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return listingCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

// -------------------------------- store --------------------------------------------------
  final CollectionReference storeCollection =
      FirebaseFirestore.instance.collection('store');

  Future updateStoreData(
    int storeId,
    String imagePath,
    String businessName,
    String latitude,
    String longtitude,
    String address,
    String startTime,
    String endTime,
    String phoneNumber,
    String facebookLink,
    String instagramLink,
    String whatsappLink,
    List listing,
  ) async {
    return await storeCollection.doc(uid).set({
      'storeId': storeId,
      'imagePath': imagePath,
      'businessName': businessName,
      'latitude': latitude,
      'longtitude': longtitude,
      'address': address,
      'startTime': startTime,
      'endTime': endTime,
      'phoneNumber': phoneNumber,
      'facebookLink': facebookLink,
      'instagramLink': instagramLink,
      'whatsappLink': whatsappLink,
      'listing': listing,
    });
  }

  //store list from snapshot
  List<Store> _storeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Store(
        storeId: doc.get('storeId') ?? '',
        imagePath: doc.get('imagePath') ?? '',
        businessName: doc.get('businessName') ?? '',
        latitude: doc.get('latitude') ?? '',
        longtitude: doc.get('longtitude') ?? '',
        address: doc.get('address') ?? '',
        startTime: doc.get('startTime') ?? '',
        endTime: doc.get('endTime') ?? '',
        phoneNumber: doc.get('phoneNumber') ?? '',
        facebookLink: doc.get('facebookLink') ?? '',
        instagramLink: doc.get('instagramLink') ?? '',
        whatsappLink: doc.get('whatsappLink') ?? '',
        listing: doc.get('listing') ?? '',
      );
    }).toList();
  }

  //userStoreData from snapshot
  UserStoreData _userStoreDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserStoreData(
      uid: uid!,
      storeId: snapshot.get('storeId'),
      imagePath: snapshot.get('imagePath'),
      businessName: snapshot.get('businessName'),
      latitude: snapshot.get('latitude'),
      longtitude: snapshot.get('longtitude'),
      address: snapshot.get('address'),
      startTime: snapshot.get('startTime'),
      endTime: snapshot.get('endTime'),
      phoneNumber: snapshot.get('phoneNumber'),
      facebookLink: snapshot.get('facebookLink'),
      instagramLink: snapshot.get('instagramLink'),
      whatsappLink: snapshot.get('whatsappLink'),
      listing: snapshot.get('listing'),
    );
  }

  // get store stream
  Stream<List<Store>> get stores {
    return storeCollection.snapshots().map(_storeListFromSnapshot);
  }

  //get users store doc stream
  Stream<UserStoreData> get userStoreData {
    return storeCollection.doc(uid).snapshots().map(_userStoreDataFromSnapshot);
  }

// // --------------------------------------- store listing -----------------------------------------
//   final CollectionReference storeListingCollection =
//       FirebaseFirestore.instance.collection('storeListing');
//   // int? storeId;
//   // Future getStoreId() async {
//   //   QuerySnapshot querySnapshot =
//   //       await FirebaseFirestore.instance.collection('store').get();
//   //   return querySnapshot.docs.map((doc) {
//   //     storeId = doc.get('storeId');
//   //   });
//   // }

//   Future addStoreListingData(Map listingData, File image) async {
//     return await storeListingCollection.doc(uid).set({});
//   }

//   // Future updateStoreListingData(Map listingData, File image) async {
//   //   var pathimage = image.toString();
//   //   var temp = pathimage.lastIndexOf('/');
//   //   var result = pathimage.substring(temp + 1);
//   //   print(result);
//   //   final ref = FirebaseStorage.instance.ref().child('imagePath').child(result);
//   //   var response = await ref.putFile(image);
//   //   print("Updated $response");
//   //   var imageUrl = await ref.getDownloadURL();

//   //   try{
//   //     var response = await storeListingCollection.doc(storeId.toString()).set({
//   //       'imagePath':
//   //     })
//   //   }catch(e){

//   //   }
//   //   return await storeListingCollection.doc(storeId.toString()).set({});
//   // }

//--------------------------------------- categories --------------------------------------
  final CollectionReference categoriesCollection =
      FirebaseFirestore.instance.collection('categories');

// --------------------------------------- filter ------------------------------------------
  final CollectionReference filterCollection =
      FirebaseFirestore.instance.collection('filter');

  Future updateFilterData(
    String category,
    String subCategory,
    int lowPriceRange,
    int highPriceRange,
    int rate,
    String address,
    String latitude,
    String longtitude,
    bool popularity,
  ) async {
    return await filterCollection.doc(uid).set({
      'category': category,
      'subCategory': subCategory,
      'lowPriceRange': lowPriceRange,
      'highPriceRange': highPriceRange,
      'rate': rate,
      'address': address,
      'latitude': latitude,
      'longtitude': longtitude,
      'popularity': popularity,
    });
  }
}
