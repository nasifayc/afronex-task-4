import 'package:afronex_shop_app/controller/user/profile_controller.dart';
import 'package:afronex_shop_app/models/user/user_model.dart';
import 'package:afronex_shop_app/controller/product/cart_controller.dart';
import 'package:afronex_shop_app/controller/product/product_controller.dart';
import 'package:afronex_shop_app/screens/landing.dart';
import 'package:afronex_shop_app/screens/splash/splash_screen.dart';
import 'package:afronex_shop_app/screens/users/login.dart';
import 'package:afronex_shop_app/services/authentication/firebase_auth_services.dart';
import 'package:afronex_shop_app/services/utils/toast_message.dart';
import 'package:afronex_shop_app/widgets/buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final userCollection = FirebaseFirestore.instance.collection('users');
  AuthServices services = AuthServices();
  final cartController = Get.put(CartController());
  final productController = Get.put(ProductController());
  late ProfileController profileController;

  late UserModel _user;
  final _isSignOut = false.obs;
  final _isSignIn = false.obs;

  UserModel get user => _user;
  bool get isSignOut => _isSignOut.value;
  bool get isSignedIn => _isSignIn.value;

  @override
  void onInit() {
    super.onInit();
    _user = UserModel(
        fullName: 'Unset',
        username: 'default',
        email: 'default@gmail.com',
        password: 'defP',
        userId: 'defI');
  }

  Future<void> loadUserInfo() async {
    try {
      final currentUser = services.getCurrentUser();
      if (currentUser != null) {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await userCollection.doc(currentUser.uid).get();
        _user = UserModel.fromSnapshot(snapshot);
        update();
        profileController.loadUserinfo();
      } else {
        showToast(message: 'Null User');
      }
    } catch (e) {
      showToast(message: 'Loading Error: $e');
    }
  }

  Future<void> _loadProducts() async {
    try {
      await productController.loadProductInfo();
      await cartController.loadCartItems(userId: _user.userId);
    } catch (e) {
      showToast(message: 'Product Loading Error: $e');
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    profileController = Get.put(ProfileController());
    _isSignIn.value = true;
    update();

    User? user = await services.logIn(email, password);
    if (user != null) {
      loadUserInfo();
      _loadProducts();
      _isSignIn.value = false;
      Get.off(() => LandingPage());
    } else {
      _isSignIn.value = false;
      showToast(message: 'No User Found');
    }
    update();
  }

  Future<void> signUpWithEmailAndPassword(
      String fullName, String username, String email, String password) async {
    _isSignIn.value = true;
    update();

    User? user = await services.signUp(fullName, username, email, password);

    if (user != null) {
      _isSignIn.value = false;
      update();
      Get.offAll(() =>
          SplashScreen(page: 'Login To Your Account', child: LoginPage()));
      showToast(message: 'User Created Successfuly');
    } else {
      _isSignIn.value = false;
      update();
      showToast(message: 'Some error occurred');
    }
  }

  Future<void> updateUserData(UserModel updatedUserData) async {
    try {
      await userCollection.doc(_user.userId).update(updatedUserData.toJson());
      loadUserInfo();
    } catch (e) {
      showToast(message: 'Error: $e');
    }
  }

  Future<void> signOut() async {
    _isSignOut.value = true;
    update();
    try {
      await services.signOut();
      Get.offAll(() =>
          SplashScreen(page: 'Login To Your Account', child: LoginPage()));
      showToast(message: '${user.username} signed out');
    } catch (e) {
      showToast(message: '$e');
    }finally{
      _isSignOut.value = false;
      update();
    }
  }
}
