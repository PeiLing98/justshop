class Listing {
  final String listingImagePath;
  final String selectedCategory;
  final String selectedSubCategory;
  final String price;
  final String listingName;
  final String listingDescription;

  Listing(
      {required this.listingImagePath,
      required this.selectedCategory,
      required this.selectedSubCategory,
      required this.price,
      required this.listingName,
      required this.listingDescription});
}
