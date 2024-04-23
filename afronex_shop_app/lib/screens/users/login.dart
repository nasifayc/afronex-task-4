import 'package:afronex_shop_app/controller/user/login_controller.dart';
import 'package:afronex_shop_app/controller/user/user_controller.dart';
import 'package:afronex_shop_app/screens/splash/splash_screen.dart';
import 'package:afronex_shop_app/screens/users/signup.dart';
import 'package:afronex_shop_app/services/utils/welcome_image.dart';
import 'package:afronex_shop_app/widgets/buttons.dart';
import 'package:afronex_shop_app/widgets/styled_text.dart';
import 'package:afronex_shop_app/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final LoginController _loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FormContainer(
          prefixIcon: const Icon(Icons.email),
          width: Get.width,
          controller: _loginController.emailController,
          labelText: 'Email',
          inputType: TextInputType.emailAddress,
          isPasswordField: false,
        ),
        const SizedBox(
          height: 10,
        ),
        FormContainer(
          prefixIcon: const Icon(Icons.password_rounded),
          width: Get.width,
          controller: _loginController.passwordController,
          labelText: 'Password',
          inputType: TextInputType.text,
          isPasswordField: true,
        ),
        SizedBox(
          height: Get.height * 0.1,
        ),
        GetBuilder<UserController>(
          builder: (_) {
            final UserController userController = Get.find();
            return userController.isSignedIn
                ? CircularProgressIndicator(
                    color: Theme.of(context).primaryColor)
                : GestureDetector(
                    onTap: () async {
                      final UserController userController = Get.find();
                      await userController.loginWithEmailAndPassword(
                          _loginController.emailController.text.trim(),
                          _loginController.passwordController.text.trim());
                      _loginController.clear();
                    },
                    child: Button(
                      title: 'Login',
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
            const Text('Don\'t have an account?'),
            const SizedBox(
              width: 15,
            ),
            GestureDetector(
              onTap: () {
                Get.offAll(() => SplashScreen(
                    page: 'Create New Account', child: SignUpPage()));
              },
              child: const Text(
                'Sign Up',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        const Center(
          child: Column(
            children: [
              StyledText(
                  title: 'Or sign up with',
                  fontSize: 16,
                  color: Color.fromARGB(255, 190, 190, 190),
                  isBold: false),
              SizedBox(height: 10),
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                    'https://th.bing.com/th/id/OIP.EhTMbGiYfYzQnWLgjZaoJAHaHa?w=199&h=199&c=7&r=0&o=5&dpr=1.5&pid=1.7'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
