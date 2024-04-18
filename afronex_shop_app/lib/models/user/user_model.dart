import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String defaultProfileURL = 'asset/images/default.jpg';
  String username;
  final String email;
  String password;
  final String userId;
  String? imgUrl;

  UserModel(
      {required this.username,
      required this.email,
      required this.password,
      required this.userId,
      this.imgUrl});

  static UserModel fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserModel(
        username: snapshot['username'],
        email: snapshot['email'],
        password: snapshot['password'],
        imgUrl: snapshot['imgUrl'],
        userId: snapshot['userId']);
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'imgUrl': imgUrl,
      'userId': userId
    };
  }
}
