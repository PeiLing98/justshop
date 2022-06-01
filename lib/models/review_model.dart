class Review {
  final String reviewId;
  final String userId;
  final String storeId;
  final String listingId;
  final String orderId;
  final String ratingStar;
  final String review;

  Review(
      {required this.reviewId,
      required this.userId,
      required this.storeId,
      required this.listingId,
      required this.orderId,
      required this.ratingStar,
      required this.review});
}
