import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/models/list_model.dart';
import 'package:final_year_project/models/listing_model.dart';
import 'package:final_year_project/models/store_model.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

// ------------------------------- user -------------------------------------------
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

  Future updateUserData(String username, String email, String phoneNumber,
      String address, String postcode, String city, String state) async {
    return await userCollection.doc(uid).set({
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'postcode': postcode,
      'city': city,
      'state': state
    });
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid!,
      username: snapshot.get('username'),
      email: snapshot.get('email'),
      phoneNumber: snapshot.get('phoneNumber'),
      address: snapshot.get('address'),
      postcode: snapshot.get('postcode'),
      city: snapshot.get('city'),
      state: snapshot.get('state'),
    );
  }

  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

// --------------------------- listing ---------------------------------------------------
  //collection reference
  final CollectionReference listingCollection =
      FirebaseFirestore.instance.collection('listing');

  Future updateListingData(
      String name, double price, String description) async {
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
  UserListingData _userListingDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserListingData(
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
  Stream<UserListingData> get userListingData {
    return listingCollection
        .doc(uid)
        .snapshots()
        .map(_userListingDataFromSnapshot);
  }

// -------------------------------- store --------------------------------------------------
  final CollectionReference storeCollection =
      FirebaseFirestore.instance.collection('store');

  Future updateStoreData(
    String storeId,
    String imagePath,
    String businessName,
    String latitude,
    String longtitude,
    String address,
    String city,
    String state,
    String startTime,
    String endTime,
    String phoneNumber,
    String facebookLink,
    String instagramLink,
    String whatsappLink,
    // List listing,
  ) async {
    return await storeCollection.doc(uid).set({
      'storeId': storeId,
      'imagePath': imagePath,
      'businessName': businessName,
      'latitude': latitude,
      'longtitude': longtitude,
      'city': city,
      'state': state,
      'address': address,
      'startTime': startTime,
      'endTime': endTime,
      'phoneNumber': phoneNumber,
      'facebookLink': facebookLink,
      'instagramLink': instagramLink,
      'whatsappLink': whatsappLink,
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
        city: doc.get('city') ?? '',
        state: doc.get('state') ?? '',
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
      uid: uid!,
      storeId: snapshot.get('storeId'),
      imagePath: snapshot.get('imagePath'),
      businessName: snapshot.get('businessName'),
      latitude: snapshot.get('latitude'),
      longtitude: snapshot.get('longtitude'),
      address: snapshot.get('address'),
      city: snapshot.get('city'),
      state: snapshot.get('state'),
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

// ----------------------------------- item listing ----------------------------------------------
  final CollectionReference itemCollection =
      FirebaseFirestore.instance.collection('item');

  Future updateItemData(
    String storeId,
    String storeName,
    String listingImagePath,
    String selectedCategory,
    String selectedSubCategory,
    String price,
    String listingName,
    String listingDescription,
  ) async {
    String itemId = const Uuid().v1();
    return await itemCollection.doc(itemId).set({
      'storeId': storeId,
      'storeName': storeName,
      'listingImagePath': listingImagePath,
      'selectedCategory': selectedCategory,
      'selectedSubCategory': selectedSubCategory,
      'price': price,
      'listingName': listingName,
      'listingDescription': listingDescription,
    });
  }

  List<Listing> _itemFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Listing(
        storeId: doc.get('storeId') ?? '',
        storeName: doc.get('storeName') ?? '',
        listingImagePath: doc.get('listingImagePath') ?? '',
        selectedCategory: doc.get('selectedCategory') ?? '',
        selectedSubCategory: doc.get('selectedSubCategory') ?? '',
        price: doc.get('price') ?? '',
        listingName: doc.get('listingName') ?? '',
        listingDescription: doc.get('listingDescription') ?? '',
      );
    }).toList();
  }

  UserItemData _userItemDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserItemData(
      uid: uid!,
      storeId: snapshot.get('storeId'),
      storeName: snapshot.get('storeName'),
      listingImagePath: snapshot.get('listingImagePath'),
      selectedCategory: snapshot.get('selectedCategory'),
      selectedSubCategory: snapshot.get('selectedSubCategory'),
      price: snapshot.get('price'),
      listingName: snapshot.get('listingName'),
      listingDescription: snapshot.get('listingDescription'),
    );
  }

// get item stream
  Stream<List<Listing>> get item {
    return itemCollection.snapshots().map(_itemFromSnapshot);
  }

  //get users item doc stream
  Stream<UserItemData> get userItemData {
    return itemCollection.doc(uid).snapshots().map(_userItemDataFromSnapshot);
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
