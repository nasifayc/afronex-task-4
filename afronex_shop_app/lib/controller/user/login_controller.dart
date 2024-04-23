import 'package:afronex_shop_app/services/authentication/firebase_auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  AuthServices services = AuthServices();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RxBool isLogging =  false.obs;

   void clear() {
    emailController.clear();
    passwordController.clear();
    update();
  }
}

