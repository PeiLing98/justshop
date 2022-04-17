import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/models/list_model.dart';
import 'package:final_year_project/models/user_model.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  //collection reference
  final CollectionReference listingCollection =
      FirebaseFirestore.instance.collection('listing');

  Future updateUserData(String name, double price, String description) async {
    return await listingCollection.doc(uid).set({
      'name': name,
      'price': price,
      'description': description,
    });
  }

  // listing from snapshot
  List<ItemList> _itemListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ItemList(
          name: doc.get('name') ?? '',
          price: doc.get('price') ?? 0,
          description: doc.get('description') ?? '');
    }).toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.get('name'),
      price: snapshot.get('price'),
      description: snapshot.get('description'),
    );
  }

  // get listing streams
  Stream<List<ItemList>> get listings {
    return listingCollection.snapshots().map(_itemListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return listingCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
