import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'dart:io' as i;

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  //upload file to firebase storage
  // Future<void> uploadFile(i.File image) async {
  //   var pathImage = image.toString();
  //   var temp = pathImage.lastIndexOf('/');
  //   var result = pathImage.substring(temp + 1);
  //   print(result);
  //   final ref = storage.ref().child('test').child(result);
  //   var response = await ref.putFile(image);
  //   print("Updated $response");
  //   var imageUrl = await ref.getDownloadURL();

  //   try {
  //     var response = await FirebaseFirestore.instance.collection('store').add({
  //       'imagePath': imageUrl,
  //     });
  //     print("Firebase response111 $response");
  //   } catch (exception) {
  //     print('Error uploading image at firestore $response');
  //   }
  // }
  Future<void> uploadFile(
    String filePath,
    String fileName,
  ) async {
    i.File file = i.File(filePath);
    try {
      await storage.ref('test/$fileName').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<firebase_storage.ListResult> listFiles() async {
    firebase_storage.ListResult result = await storage.ref('test').listAll();

    result.items.forEach((firebase_storage.Reference ref) {
      print('Found file: $ref');
    });

    return result;
  }

  //retrieve file from firebase storage
  Future<String> downloadURL(String imageName) async {
    String downloadURL = await storage.ref('test/$imageName').getDownloadURL();

    return downloadURL;
  }
}
