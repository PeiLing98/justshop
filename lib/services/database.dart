import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/models/cart_model.dart';
import 'package:final_year_project/models/chat_model.dart';
import 'package:final_year_project/models/listing_model.dart';
import 'package:final_year_project/models/order_model.dart';
import 'package:final_year_project/models/review_model.dart';
import 'package:final_year_project/models/save_list_model.dart';
import 'package:final_year_project/models/store_model.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

// ------------------------------- user -------------------------------------------
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

  Future updateUserData(String username, String email, String phoneNumber,
      String address, String postcode, String city, String state) async {
    List searchHistory = [];
    return await userCollection.doc(uid).set({
      'userId': uid,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'postcode': postcode,
      'city': city,
      'state': state,
      'searchHistory': searchHistory
    });
  }

  Future updateSearchHistory(String uid, String searchHistory) async {
    return await userCollection.doc(uid).update({
      'searchHistory': FieldValue.arrayUnion([searchHistory])
    });
  }

  List<AllUser> _allUserFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return AllUser(
          userId: doc.get('userId') ?? "",
          username: doc.get('username') ?? "",
          email: doc.get('email') ?? "",
          phoneNumber: doc.get('phoneNumber') ?? '',
          address: doc.get('address') ?? '',
          postcode: doc.get('postcode') ?? '',
          city: doc.get('city') ?? '',
          state: doc.get('state') ?? '',
          searchHistory: doc.get('searchHistory') ?? '');
    }).toList();
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
        searchHistory: snapshot.get('searchHistory'));
  }

  Stream<List<AllUser>> get allUser {
    return userCollection.snapshots().map(_allUserFromSnapshot);
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
  ) async {
    String rating = "0";
    int totalSales = 0;
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
      'rating': rating,
      'totalSales': totalSales
    });
  }

  Future updateStoreRating(String uid, String rating) async {
    return await storeCollection.doc(uid).update({'rating': rating});
  }

  Future updateStoreSales(String uid, int sales) async {
    return await storeCollection.doc(uid).update({'totalSales': sales});
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
          rating: doc.get('rating') ?? '',
          totalSales: doc.get('totalSales') ?? '');
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
      rating: snapshot.get('rating'),
      totalSales: snapshot.get('totalSales'),
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
    String rating = "0";
    int totalSales = 0;
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
      'rating': rating,
      'totalSales': totalSales
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

  Future updateItemRating(String listingId, String rating) async {
    return await itemCollection.doc(listingId).update({'rating': rating});
  }

  Future updateItemSales(String listingId, int sales) async {
    return await itemCollection.doc(listingId).update({'totalSales': sales});
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
        rating: doc.get('rating') ?? '',
        totalSales: doc.get('totalSales') ?? '',
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
      rating: snapshot.get('rating'),
      totalSales: snapshot.get('totalSales'),
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

// --------------------------------------- order ------------------------------------------
  final CollectionReference orderCollection =
      FirebaseFirestore.instance.collection('order');

  Future addOrderData(
    String userId,
    List orderItem,
    String totalPrice,
    String recipientName,
    String recipientPhoneNumber,
    String recipientAddress,
    String recipientPostcode,
    String recipientCity,
    String recipientState,
  ) async {
    String orderId = const Uuid().v1();
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

    return await orderCollection.doc(orderId).set({
      'orderId': orderId,
      'userId': userId,
      'orderItem': orderItem,
      'totalPrice': totalPrice,
      'recipientName': recipientName,
      'recipientPhoneNumber': recipientPhoneNumber,
      'recipientAddress': recipientAddress,
      'recipientPostcode': recipientPostcode,
      'recipientCity': recipientCity,
      'recipientState': recipientState,
      'createdAt': dateFormat.format(DateTime.now())
    });
  }

  Future updateOrderStatus(List order, String orderId) async {
    return await orderCollection.doc(orderId).update({
      'orderItem': order,
    });
  }

  List<Order> _orderFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Order(
        orderId: doc.get('orderId') ?? '',
        userId: doc.get('userId') ?? '',
        orderItem: doc.get('orderItem') ?? '',
        totalPrice: doc.get('totalPrice') ?? '',
        recipientName: doc.get('recipientName') ?? '',
        recipientPhoneNumber: doc.get('recipientPhoneNumber') ?? '',
        recipientAddress: doc.get('recipientAddress') ?? '',
        recipientPostcode: doc.get('recipientPostcode') ?? '',
        recipientCity: doc.get('recipientCity') ?? '',
        recipientState: doc.get('recipientState') ?? '',
        createdAt: doc.get('createdAt') ?? '',
      );
    }).toList();
  }

  UserOrderData _userOrderDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserOrderData(
      uid: uid!,
      orderId: snapshot.get('orderId'),
      userId: snapshot.get('userId'),
      orderItem: snapshot.get('orderItem'),
      totalPrice: snapshot.get('totalPrice'),
      recipientName: snapshot.get('recipientName'),
      recipientPhoneNumber: snapshot.get('recipientPhoneNumber'),
      recipientAddress: snapshot.get('recipientAddress'),
      recipientPostcode: snapshot.get('recipientPostcode'),
      recipientCity: snapshot.get('recipientCity'),
      recipientState: snapshot.get('recipientState'),
      createdAt: snapshot.get('createdAt'),
    );
  }

  // get item stream
  Stream<List<Order>> get order {
    return orderCollection.snapshots().map(_orderFromSnapshot);
  }

  //get users item doc stream
  Stream<UserOrderData> get userOrderData {
    return orderCollection.doc(uid).snapshots().map(_userOrderDataFromSnapshot);
  }

// --------------------------------------- review ------------------------------------------
  final CollectionReference reviewCollection =
      FirebaseFirestore.instance.collection('review');

  Future addReviewData(String userId, String storeId, String listingId,
      String orderId, String ratingStar, String review) async {
    String reviewId = const Uuid().v1();
    return await reviewCollection.doc(reviewId).set({
      'reviewId': reviewId,
      'userId': userId,
      'storeId': storeId,
      'listingId': listingId,
      'orderId': orderId,
      'ratingStar': ratingStar,
      'review': review
    });
  }

  List<Review> _reviewFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Review(
        reviewId: doc.get('reviewId') ?? '',
        userId: doc.get('userId') ?? '',
        storeId: doc.get('storeId') ?? '',
        listingId: doc.get('listingId') ?? '',
        orderId: doc.get('orderId') ?? '',
        ratingStar: doc.get('ratingStar') ?? '',
        review: doc.get('review') ?? '',
      );
    }).toList();
  }

  UserReviewData _userReviewDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserReviewData(
      uid: uid!,
      reviewId: snapshot.get('reviewId'),
      userId: snapshot.get('userId'),
      storeId: snapshot.get('storeId'),
      listingId: snapshot.get('listingId'),
      orderId: snapshot.get('orderId'),
      ratingStar: snapshot.get('ratingStar'),
      review: snapshot.get('review'),
    );
  }

  // get item stream
  Stream<List<Review>> get review {
    return reviewCollection.snapshots().map(_reviewFromSnapshot);
  }

  //get users item doc stream
  Stream<UserReviewData> get userReviewData {
    return reviewCollection
        .doc(uid)
        .snapshots()
        .map(_userReviewDataFromSnapshot);
  }

// ------------------------------- chat -------------------------------------------
  final CollectionReference chatCollection =
      FirebaseFirestore.instance.collection('chat');

  Future createChatRoom(String user1Id, String user2Id, List message) async {
    String chatId = const Uuid().v1();
    return await chatCollection.doc(chatId).set({
      'chatId': chatId,
      'user1': user1Id,
      'user2': user2Id,
      'message': message
    });
  }

  Future updateMessage(String chatId, List message) async {
    return await chatCollection
        .doc(chatId)
        .update({'message': FieldValue.arrayUnion(message)});
  }

  List<Chat> _chatFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Chat(
          chatId: doc.get('chatId') ?? '',
          user1: doc.get('user1') ?? '',
          user2: doc.get('user2') ?? '',
          message: doc.get('message') ?? '');
    }).toList();
  }

  UserChatData _userChatDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserChatData(
      uid: uid!,
      chatId: snapshot.get('chatId'),
      user1: snapshot.get('user1'),
      user2: snapshot.get('user2'),
      message: snapshot.get('message'),
    );
  }

  // get item stream
  Stream<List<Chat>> get chat {
    return chatCollection.snapshots().map(_chatFromSnapshot);
  }

  //get users item doc stream
  Stream<UserChatData> get userChatData {
    return chatCollection.doc(uid).snapshots().map(_userChatDataFromSnapshot);
  }
}
