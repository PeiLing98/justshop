class Cart {
  final String cartId;
  final String userId;
  final String listingId;
  final String storeId;
  final int quantity;
  final bool isSelected;

  Cart(
      {required this.cartId,
      required this.userId,
      required this.listingId,
      required this.storeId,
      required this.quantity,
      required this.isSelected});
}
