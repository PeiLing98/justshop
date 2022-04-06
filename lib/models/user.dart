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
