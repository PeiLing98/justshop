import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/models/list_model.dart';
import 'package:final_year_project/models/store_model.dart';
import 'package:final_year_project/models/user_model.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

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
      uid: uid,
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
      String imagePath,
      String businessName,
      String latitude,
      String longtitude,
      String startTime,
      String endTime,
      String phoneNumber,
      String facebookLink,
      String instagramLink,
      String whatsappLink) async {
    return await storeCollection.doc(uid).set({
      'imagePath': imagePath,
      'businessName': businessName,
      'latitude': latitude,
      'longtitude': longtitude,
      'startTime': startTime,
      'endTime': endTime,
      'phoneNumber': phoneNumber,
      'facebookLink': facebookLink,
      'instagramLink': instagramLink,
      'whatsappLink': whatsappLink
    });
  }

  //store list from snapshot
  List<Store> _storeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Store(
        imagePath: doc.get('imagePath') ?? '',
        businessName: doc.get('businessName') ?? '',
        latitude: doc.get('latitude') ?? '',
        longtitude: doc.get('longtitude') ?? '',
        startTime: doc.get('startTime') ?? '',
        endTime: doc.get('endTime') ?? '',
        phoneNumber: doc.get('phoneNumber') ?? '',
        facebookLink: doc.get('facebookLink') ?? '',
        instagramLink: doc.get('instagramLink') ?? '',
        whatsappLink: doc.get('whatsappLink') ?? '',
      );
    }).toList();
  }

  //userStoreData from snapshot
  UserStoreData _userStoreDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserStoreData(
      uid: uid,
      imagePath: snapshot.get('imagePath'),
      businessName: snapshot.get('businessName'),
      latitude: snapshot.get('latitude'),
      longtitude: snapshot.get('longtitude'),
      startTime: snapshot.get('startTime'),
      endTime: snapshot.get('endTime'),
      phoneNumber: snapshot.get('phoneNumber'),
      facebookLink: snapshot.get('facebookLink'),
      instagramLink: snapshot.get('instagramLink'),
      whatsappLink: snapshot.get('whatsappLink'),
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
}
