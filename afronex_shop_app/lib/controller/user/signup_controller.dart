import 'package:afronex_shop_app/services/authentication/firebase_auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  AuthServices services = AuthServices();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RxBool isSigningUp = false.obs;

  void clear() {
    fullNameController.clear();
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
    update();
  }
}
