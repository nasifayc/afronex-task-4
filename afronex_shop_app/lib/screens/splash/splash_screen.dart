import 'package:afronex_shop_app/widgets/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key, required this.page, required this.child});
  final String page;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,
          width: Get.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.teal,
                Color.fromARGB(255, 0, 104, 94),
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: Get.width * 0.08,
                  top: Get.height * 0.15,
                  bottom: Get.height * 0.05,
                ),
                child: StyledText(
                  title: page,
                  isBold: true,
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.07,
                    vertical: Get.height * 0.06,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
