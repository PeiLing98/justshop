class MyUser {
  final String uid;

  MyUser({required this.uid});
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

  UserData(
      {required this.uid,
      required this.username,
      required this.email,
      required this.phoneNumber,
      required this.address,
      required this.postcode,
      required this.city,
      required this.state});
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

  UserItemData({
    required this.uid,
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
  });
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
