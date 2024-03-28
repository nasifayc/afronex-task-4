import 'package:afronex_shop_app/models/user/user_model.dart';
import 'package:afronex_shop_app/screens/landing.dart';
import 'package:afronex_shop_app/screens/users/login.dart';
import 'package:afronex_shop_app/services/authentication/firebase_auth_services.dart';
import 'package:afronex_shop_app/services/utils/toast_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final userCollection = FirebaseFirestore.instance.collection('users');
  AuthServices services = AuthServices();

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
        username: 'default',
        email: 'default@gmail.com',
        password: 'defP',
        userId: 'defI');
  }

  Future<void> _loadUserInfo() async {
    try {
      final currentUser = services.getCurrentUser();
      if (currentUser != null) {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await userCollection.doc(currentUser.uid).get();
        _user = UserModel.fromSnapshot(snapshot);
        update();
      } else {
        showToast(message: 'Null User');
      }
    } catch (e) {
      showToast(message: 'Loading Error: $e');
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    _isSignIn.value = true;
    update();

    User? user = await services.logIn(email, password);
    if (user != null) {
      _loadUserInfo();
      _isSignIn.value = false;
      Get.off(LandingPage());
    } else {
      _isSignIn.value = false;
      showToast(message: 'No User Found');
    }
    update();
  }

  Future<void> signUpWithEmailAndPassword(
      String username, String email, String password) async {
    _isSignIn.value = true;
    update();

    User? user = await services.signUp(username, email, password);

    if (user != null) {
      _isSignIn.value = false;
      update();
      Get.to(const LoginPage());
      showToast(message: 'User Created Successfuly');
    } else {
      _isSignIn.value = false;
      update();
      showToast(message: 'Some error occurred');
    }
  }

  void updateUserName(String name) async {
    if (name.isNotEmpty) {
      _user.username = name;
      try {
        await userCollection
            .doc(_user.userId)
            .update({'username': _user.username});
        _loadUserInfo();
      } catch (e) {
        showToast(message: 'Error: $e');
      }
    }
  }

  Future<void> signOut() async {
    try {
      await services.signOut();
      Get.offAll(const LoginPage());
      showToast(message: '${user.username} signed out');
    } catch (e) {
      showToast(message: '$e');
    }
  }
}
