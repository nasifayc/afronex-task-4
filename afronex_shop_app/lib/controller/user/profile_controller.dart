import 'dart:io';
import 'dart:typed_data';

import 'package:afronex_shop_app/controller/user/user_controller.dart';
import 'package:afronex_shop_app/services/utils/toast_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final userCollection = FirebaseFirestore.instance.collection('users');
  Reference reference = FirebaseStorage.instance.ref();
  final UserController _userController = Get.find();
  final ImagePicker _imagePicker = ImagePicker();
  late Uint8List? _image;

  RxBool isUpdating = false.obs;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void loadUserinfo() {
    usernameController.text = _userController.user.username;
    passwordController.text = _userController.user.password;
  }

  pickImage(ImageSource source) async {
    XFile? pickedFile = await _imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      _image = await pickedFile.readAsBytes();
      update();
      await uploadImageToFirebase(pickedFile.path);
    } else {
      showToast(message: 'No image selected');
    }
  }

  Future<void> uploadImageToFirebase(String imagePath) async {
    if (_image != null) {
      final String fileName = '${_userController.user.userId}.jpg';
      try {
        final Reference oldImageReference =
            reference.child('profile_images').child(fileName);
        try {
          await oldImageReference.delete();
        } catch (e) {
          showToast(message: 'Url doesn\'t exists before: $e');
        } finally {
          Reference ref =
              FirebaseStorage.instance.ref().child('profile_images/$fileName');
          UploadTask uploadTask = ref.putFile(File(imagePath));
          TaskSnapshot storageTaskSnapshot =
              await uploadTask.whenComplete(() {});
          String imageUrl = await storageTaskSnapshot.ref.getDownloadURL();
          _userController.user.imgUrl = imageUrl;
          update();
          await userCollection
              .doc(_userController.user.userId)
              .update({'imgUrl': imageUrl});
        }
      } catch (e) {
        showToast(message: '$e');
      }
    }
  }

  Future<void> updateUserData() async {
    isUpdating.value = true;
    update();
    if (passwordController.text.trim().length >= 6) {
      await userCollection.doc(_userController.user.userId).update({
        'username': usernameController.text.trim(),
        'password': passwordController.text.trim()
      });
    } else {
      showToast(message: 'Invalid Password');
    }
    isUpdating.value = false;
    update();
  }
}
