import 'package:afronex_shop_app/models/user_model.dart';
import 'package:afronex_shop_app/services/firebase_auth_services.dart';
import 'package:afronex_shop_app/services/utils/toast_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  final userCollection = FirebaseFirestore.instance.collection('users');
  AuthServices services = AuthServices();

  late User? currentUser;
  late UserModel user;

  UserProvider() {
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    try {
      currentUser = services.getCurrentUser();
      if (currentUser != null) {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await userCollection.doc(currentUser!.uid).get();
        user = UserModel.fromSnapshot(snapshot);
        notifyListeners();
      } else {
        showToast(message: 'Null User');
      }
    } catch (e) {
      showToast(message: 'Loading Error: $e');
    }
  }

  void updateUserName(String name) async {
    if (name.isNotEmpty) {
      user.username = name;
      try {
        await userCollection
            .doc(currentUser!.uid)
            .update({'username': user.username});
        _loadUserInfo();
        notifyListeners();
      } catch (e) {
        showToast(message: 'Error: $e');
      }
    }
  }
}
