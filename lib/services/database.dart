import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/models/cart_model.dart';
import 'package:final_year_project/models/listing_model.dart';
import 'package:final_year_project/models/save_list_model.dart';
import 'package:final_year_project/models/store_model.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/pages/save_list.dart';
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

  Future addItemData(
    String storeId,
    String storeName,
    String storeImage,
    String listingImagePath,
    String selectedCategory,
    String selectedSubCategory,
    String price,
    String listingName,
    String listingDescription,
  ) async {
    String listingId = const Uuid().v1();
    return await itemCollection.doc(listingId).set({
      'storeId': storeId,
      'storeName': storeName,
      'storeImage': storeImage,
      'listingId': listingId,
      'listingImagePath': listingImagePath,
      'selectedCategory': selectedCategory,
      'selectedSubCategory': selectedSubCategory,
      'price': price,
      'listingName': listingName,
      'listingDescription': listingDescription,
    });
  }

  Future updateItemData(
    String docId,
    String storeId,
    String storeName,
    String storeImage,
    String listingImagePath,
    String selectedCategory,
    String selectedSubCategory,
    String price,
    String listingName,
    String listingDescription,
  ) async {
    return await itemCollection.doc(docId).update({
      'storeId': storeId,
      'storeName': storeName,
      'storeImage': storeImage,
      'listingImagePath': listingImagePath,
      'selectedCategory': selectedCategory,
      'selectedSubCategory': selectedSubCategory,
      'price': price,
      'listingName': listingName,
      'listingDescription': listingDescription,
    });
  }

  Future deleteItemData(String docId) async {
    return await itemCollection.doc(docId).delete();
  }

  List<Listing> _itemFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Listing(
        storeId: doc.get('storeId') ?? '',
        storeName: doc.get('storeName') ?? '',
        storeImage: doc.get('storeImage') ?? '',
        listingId: doc.get('listingId') ?? '',
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
      storeImage: snapshot.get('storeImage'),
      listingId: snapshot.get('listingId'),
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

// --------------------------------------- cart ------------------------------------------
  final CollectionReference cartCollection =
      FirebaseFirestore.instance.collection('cart');

  Future addCartData(
    String userId,
    String listingId,
    String storeId,
    int quantity,
    bool isSelected,
  ) async {
    String cartId = const Uuid().v1();
    return await cartCollection.doc(cartId).set({
      'cartId': cartId,
      'userId': userId,
      'listingId': listingId,
      'storeId': storeId,
      'quantity': quantity,
      'isSelected': isSelected,
    });
  }

  Future updateCartQuantity(int quantity, String cartId) async {
    return await cartCollection.doc(cartId).update({
      'quantity': quantity,
    });
  }

  Future updateCartSelectedListing(bool isSelected, String cartId) async {
    return await cartCollection.doc(cartId).update({
      'isSelected': isSelected,
    });
  }

  Future deleteCartData(String cartId) async {
    return await cartCollection.doc(cartId).delete();
  }

  List<Cart> _cartFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Cart(
        cartId: doc.get('cartId') ?? '',
        userId: doc.get('userId') ?? '',
        listingId: doc.get('listingId') ?? '',
        storeId: doc.get('storeId') ?? '',
        quantity: doc.get('quantity') ?? '',
        isSelected: doc.get('isSelected') ?? '',
      );
    }).toList();
  }

  UserCartData _userCartDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserCartData(
        uid: uid!,
        cartId: snapshot.get('cartId'),
        userId: snapshot.get('userId'),
        listingId: snapshot.get('listingId'),
        storeId: snapshot.get('storeId'),
        quantity: snapshot.get('quantity'),
        isSelected: snapshot.get('isSelected'));
  }

  // get item stream
  Stream<List<Cart>> get cart {
    return cartCollection.snapshots().map(_cartFromSnapshot);
  }

  //get users item doc stream
  Stream<UserCartData> get userCartData {
    return cartCollection.doc(uid).snapshots().map(_userCartDataFromSnapshot);
  }

// --------------------------------------- save list ------------------------------------------
  final CollectionReference saveListCollection =
      FirebaseFirestore.instance.collection('saveList');

  Future addSaveListData(
    String userId,
    String listingId,
    String storeId,
  ) async {
    String saveListId = const Uuid().v1();
    return await saveListCollection.doc(saveListId).set({
      'saveListId': saveListId,
      'userId': userId,
      'listingId': listingId,
      'storeId': storeId,
    });
  }

  Future deleteSaveListData(String saveListId) async {
    return await saveListCollection.doc(saveListId).delete();
  }

  List<SaveListModel> _saveListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return SaveListModel(
        saveListId: doc.get('saveListId') ?? '',
        userId: doc.get('userId') ?? '',
        listingId: doc.get('listingId') ?? '',
        storeId: doc.get('storeId') ?? '',
      );
    }).toList();
  }

  UserSaveListData _userSaveListDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserSaveListData(
      uid: uid!,
      saveListId: snapshot.get('saveListId'),
      userId: snapshot.get('userId'),
      listingId: snapshot.get('listingId'),
      storeId: snapshot.get('storeId'),
    );
  }

  // get item stream
  Stream<List<SaveListModel>> get saveList {
    return saveListCollection.snapshots().map(_saveListFromSnapshot);
  }

  //get users item doc stream
  Stream<UserSaveListData> get userSaveListData {
    return saveListCollection
        .doc(uid)
        .snapshots()
        .map(_userSaveListDataFromSnapshot);
  }
}
