class MyUser {
  final String uid;

  MyUser({required this.uid});
}

class UserData {
  final String uid;
  final String name;
  final double price;
  final String description;

  UserData(
      {required this.uid,
      required this.name,
      required this.price,
      required this.description});
}

class UserStoreData {
  final String uid;
  final String imagePath;
  final String businessName;
  final String latitude;
  final String longtitude;
  final String startTime;
  final String endTime;
  final String phoneNumber;
  final String facebookLink;
  final String instagramLink;
  final String whatsappLink;

  UserStoreData(
      {required this.uid,
      required this.imagePath,
      required this.businessName,
      required this.latitude,
      required this.longtitude,
      required this.startTime,
      required this.endTime,
      required this.phoneNumber,
      required this.facebookLink,
      required this.instagramLink,
      required this.whatsappLink});
}
