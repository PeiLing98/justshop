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

class UserListingData {
  final String uid;
  final String name;
  final double price;
  final String description;

  UserListingData(
      {required this.uid,
      required this.name,
      required this.price,
      required this.description});
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
    required this.listingImagePath,
    required this.selectedCategory,
    required this.selectedSubCategory,
    required this.price,
    required this.listingName,
    required this.listingDescription,
  });
}
