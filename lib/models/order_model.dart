class Order {
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
  final String createdAt;

  Order({
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

// class OrderItem {
//   String store;
//   String listing;
//   int quantity;
//   String request;
//   String orderStatus;

//   OrderItem(
//       {required this.store,
//       required this.listing,
//       required this.quantity,
//       required this.request,
//       required this.orderStatus});
// }
