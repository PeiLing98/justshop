class Store {
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

  Store({
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

class StoreAboutBusiness {
  final String storeId;
  final String aboutBusiness;
  final String videoBusiness;

  StoreAboutBusiness({
    required this.storeId,
    required this.aboutBusiness,
    required this.videoBusiness,
  });
}
