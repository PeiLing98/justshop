import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on User
  MyUser? _userFromUser(User? user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<MyUser?> get user {
    return _auth.authStateChanges().map((User? user) => _userFromUser(user));

    // another way to write
    // return _auth.authStateChanges().map(_userFromUser);
  }

  Future<User?> getCurrentUid() async {
    return _auth.currentUser;
  }

  // sign in anonymously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(
      String email,
      String password,
      String username,
      String phoneNumber,
      String address,
      String postcode,
      String city,
      String state) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      await DatabaseService(uid: user!.uid).updateUserData(
          username, email, phoneNumber, address, postcode, city, state);
      //create a new document for the user with the uid
      // await DatabaseService(uid: user.uid)
      //     .updateListingData('cake', 5.50, 'soft and fluffy');
      return _userFromUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //reset password with email
  Future resetPasswordWithEmail(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
