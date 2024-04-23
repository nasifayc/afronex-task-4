import 'package:afronex_shop_app/screens/splash/splash_screen.dart';
import 'package:afronex_shop_app/screens/users/login.dart';
import 'package:afronex_shop_app/widgets/buttons.dart';
import 'package:afronex_shop_app/widgets/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage:
                    AssetImage('asset/images/afronex.jpg') as ImageProvider,
              ),
              SizedBox(width: 10),
              StyledText(
                  title: 'Afronex Shop',
                  isBold: true,
                  fontSize: 25,
                  color: Colors.teal),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Lottie.asset("asset/animations/welcome.json"),
          SizedBox(
            height: Get.height * 0.1,
          ),
          GestureDetector(
              onTap: () {
                Get.to(() =>
                    SplashScreen(page: 'Welcome Back!', child: LoginPage()));
              },
              child: Button(
                  title: 'Get Started',
                  color: Theme.of(context).primaryColor,
                  width: double.infinity)),
        ],
      ),
    ));
  }
}
