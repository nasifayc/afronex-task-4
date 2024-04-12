import 'package:afronex_shop_app/controller/user/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final UserController _userController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          GetBuilder<UserController>(builder: (_) {
            final user = _userController.user;
            return Center(
              child: SizedBox(
                  child: Column(children: [
                Stack(children: [
                  CircleAvatar(
                    radius: 50,
                    child: user.imgUrl == null
                        ? Image.asset(user.defaultProfileURL)
                        : Image.network(user.imgUrl!),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 40,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ),
                ]),
              ])),
            );
          }),
        ]),
      ),
    );
  }
}
