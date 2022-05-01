class Store {
  final int storeId;
  final String imagePath;
  final String businessName;
  final String latitude;
  final String longtitude;
  final String address;
  final String startTime;
  final String endTime;
  final String phoneNumber;
  final String facebookLink;
  final String instagramLink;
  final String whatsappLink;
  final List listing;

  Store({
    required this.storeId,
    required this.imagePath,
    required this.businessName,
    required this.latitude,
    required this.longtitude,
    required this.address,
    required this.startTime,
    required this.endTime,
    required this.phoneNumber,
    required this.facebookLink,
    required this.instagramLink,
    required this.whatsappLink,
    required this.listing,
  });
}
