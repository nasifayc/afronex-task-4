import 'package:afronex_shop_app/controller/user/signup_controller.dart';
import 'package:afronex_shop_app/controller/user/user_controller.dart';
import 'package:afronex_shop_app/screens/splash/splash_screen.dart';
import 'package:afronex_shop_app/screens/users/login.dart';
import 'package:afronex_shop_app/widgets/buttons.dart';
import 'package:afronex_shop_app/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final SignUpController _signUpController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FormContainer(
          prefixIcon: const Icon(Icons.people),
          width: Get.width,
          controller: _signUpController.fullNameController,
          labelText: 'Full Name',
          inputType: TextInputType.text,
          isPasswordField: false,
        ),
        const SizedBox(
          height: 10,
        ),
        FormContainer(
          prefixIcon: const Icon(Icons.email),
          width: Get.width,
          controller: _signUpController.emailController,
          labelText: 'Email',
          inputType: TextInputType.emailAddress,
          isPasswordField: false,
        ),
        const SizedBox(
          height: 10,
        ),
        FormContainer(
          prefixIcon: const Icon(Icons.person),
          width: Get.width,
          controller: _signUpController.usernameController,
          labelText: 'Username',
          inputType: TextInputType.text,
          isPasswordField: false,
        ),
        const SizedBox(
          height: 10,
        ),
        FormContainer(
          prefixIcon: const Icon(Icons.password_rounded),
          width: Get.width,
          controller: _signUpController.passwordController,
          labelText: 'Password',
          inputType: TextInputType.text,
          isPasswordField: true,
        ),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          height: 20,
        ),
        GetBuilder<UserController>(
          builder: (_) {
            final UserController userController = Get.find();
            return userController.isSignedIn
                ? CircularProgressIndicator(
                    color: Theme.of(context).primaryColor)
                : GestureDetector(
                    onTap: () async {
                      await userController.signUpWithEmailAndPassword(
                          _signUpController.fullNameController.text.trim(),
                          _signUpController.usernameController.text.trim(),
                          _signUpController.emailController.text.trim(),
                          _signUpController.passwordController.text.trim());

                      _signUpController.clear();
                    },
                    child: Button(
                      title: 'Sign Up',
                      width: Get.width,
                      color: Theme.of(context).primaryColor,
                    ),
                  );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Already have an account?'),
            const SizedBox(
              width: 15,
            ),
            GestureDetector(
              onTap: () {
                Get.offAll(() =>
                    SplashScreen(page: 'Welcome Back!', child: LoginPage()));
              },
              child: const Text(
                'Login',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ],
    );
  }
}
