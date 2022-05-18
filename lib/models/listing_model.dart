class Listing {
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

  Listing(
      {required this.storeId,
      required this.storeName,
      required this.storeImage,
      required this.listingId,
      required this.listingImagePath,
      required this.selectedCategory,
      required this.selectedSubCategory,
      required this.price,
      required this.listingName,
      required this.listingDescription});
}
