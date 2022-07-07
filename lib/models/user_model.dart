import 'package:intl/intl.dart';

class MyUser {
  final String uid;

  MyUser({required this.uid});
}

class AllUser {
  final String userId;
  final String username;
  final String email;
  final String phoneNumber;
  final String address;
  final String postcode;
  final String city;
  final String state;
  final List searchHistory;

  AllUser({
    required this.userId,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.postcode,
    required this.city,
    required this.state,
    required this.searchHistory,
  });
}

class UserData {
  final String uid;
  final String username;
  final String email;
  final String phoneNumber;
  final String address;
  final String postcode;
  final String city;
  final String state;
  final List searchHistory;

  UserData(
      {required this.uid,
      required this.username,
      required this.email,
      required this.phoneNumber,
      required this.address,
      required this.postcode,
      required this.city,
      required this.state,
      required this.searchHistory});
}

class UserStoreData {
  final String uid;
  final String storeId;
  final String imagePath;
  final String businessName;
  final String latitude;
  final String longtitude;
  final String address;
  final String city;
  final String state;
  final String startTime;
  final String endTime;
  final String phoneNumber;
  final String facebookLink;
  final String instagramLink;
  final String whatsappLink;
  final String rating;
  final int totalSales;

  UserStoreData({
    required this.uid,
    required this.storeId,
    required this.imagePath,
    required this.businessName,
    required this.latitude,
    required this.longtitude,
    required this.address,
    required this.city,
    required this.state,
    required this.startTime,
    required this.endTime,
    required this.phoneNumber,
    required this.facebookLink,
    required this.instagramLink,
    required this.whatsappLink,
    required this.rating,
    required this.totalSales,
  });
}

class UserStoreAboutBusiness {
  final String uid;
  final String storeId;
  final String aboutBusiness;
  final String videoBusiness;

  UserStoreAboutBusiness({
    required this.uid,
    required this.storeId,
    required this.aboutBusiness,
    required this.videoBusiness,
  });
}

class UserItemData {
  final String uid;
  final String storeId;
  final String storeName;
  final String storeImage;
  final String listingId;
  final String listingImagePath;
  final String selectedCategory;
  final String selectedSubCategory;
  final String price;
  final String listingName;
  final String listingDescription;
  final String rating;
  final int totalSales;

  UserItemData(
      {required this.uid,
      required this.storeId,
      required this.storeName,
      required this.storeImage,
      required this.listingId,
      required this.listingImagePath,
      required this.selectedCategory,
      required this.selectedSubCategory,
      required this.price,
      required this.listingName,
      required this.listingDescription,
      required this.rating,
      required this.totalSales});
}

class UserCartData {
  final String uid;
  final String cartId;
  final String userId;
  final String listingId;
  final String storeId;
  final String quantity;
  final bool isSelected;

  UserCartData(
      {required this.uid,
      required this.cartId,
      required this.userId,
      required this.listingId,
      required this.storeId,
      required this.quantity,
      required this.isSelected});
}

class UserSaveListData {
  final String uid;
  final String saveListId;
  final String userId;
  final String listingId;
  final String storeId;

  UserSaveListData({
    required this.uid,
    required this.saveListId,
    required this.userId,
    required this.listingId,
    required this.storeId,
  });
}

class UserOrderData {
  final String uid;
  final String orderId;
  final String userId;
  final List orderItem;
  final String totalPrice;
  final String recipientName;
  final String recipientPhoneNumber;
  final String recipientAddress;
  final String recipientPostcode;
  final String recipientCity;
  final String recipientState;
  final DateFormat createdAt;

  UserOrderData({
    required this.uid,
    required this.orderId,
    required this.userId,
    required this.orderItem,
    required this.totalPrice,
    required this.recipientName,
    required this.recipientPhoneNumber,
    required this.recipientAddress,
    required this.recipientPostcode,
    required this.recipientCity,
    required this.recipientState,
    required this.createdAt,
  });
}

class UserReviewData {
  final String uid;
  final String reviewId;
  final String userId;
  final String storeId;
  final String listingId;
  final String orderId;
  final String ratingStar;
  final String review;

  UserReviewData({
    required this.uid,
    required this.reviewId,
    required this.userId,
    required this.storeId,
    required this.listingId,
    required this.orderId,
    required this.ratingStar,
    required this.review,
  });
}

class UserChatData {
  final String uid;
  final String chatId;
  final String user1;
  final String user2;
  final List message;

  UserChatData(
      {required this.uid,
      required this.chatId,
      required this.user1,
      required this.user2,
      required this.message});
}
