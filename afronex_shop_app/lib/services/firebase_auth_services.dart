import 'package:afronex_shop_app/models/user_model.dart';
import 'package:afronex_shop_app/services/utils/toast_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? _currentUser;

  User? getCurrentUser() => _auth.currentUser;

  Future<void> _addUserToFireBase(
      String username, String email, String password, String id) async {
    try {
      final userCollection = FirebaseFirestore.instance.collection('users');

      UserModel newUser = UserModel(
          username: username,
          email: email,
          password: password,
          userId: id,
          imgUrl: null);

      await userCollection.doc(newUser.userId).set(newUser.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<User?> signUp(String username, String email, String password) async {
    if (email.isEmpty || password.isEmpty || username.isEmpty) {
      showToast(message: 'Some Fields are Empty');
      return null;
    }

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        User? user = userCredential.user;
        _addUserToFireBase(username, email, password, user!.uid);
        _currentUser = userCredential.user;
        return _currentUser;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(message: 'Email already in use');
      } else {
        showToast(message: 'An error Occured: ${e.code}');
      }
    }

    return null;
  }

  Future<User?> logIn(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      showToast(message: 'Some Fields are Empty');
      return null;
    }

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        _currentUser = userCredential.user;
        return _currentUser;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showToast(message: 'Invalid Email or Password');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }
    }
    return null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
