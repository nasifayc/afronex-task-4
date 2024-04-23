import 'package:afronex_shop_app/controller/user/profile_controller.dart';
import 'package:afronex_shop_app/controller/user/user_controller.dart';
import 'package:afronex_shop_app/widgets/buttons.dart';
import 'package:afronex_shop_app/widgets/styled_text.dart';
import 'package:afronex_shop_app/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final ProfileController _profileController = Get.find();
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
                    radius: 70,
                    backgroundImage: user.imgUrl == null
                        ? AssetImage(user.defaultProfileURL) as ImageProvider
                        : NetworkImage(user.imgUrl!),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: () {
                        _profileController.pickImage(ImageSource.gallery);
                      },
                      icon: const Icon(Icons.add_a_photo,
                          size: 30, color: Colors.blue),
                    ),
                  ),
                ]),
                const SizedBox(height: 10),
                StyledText(
                    title: user.username,
                    isBold: true,
                    fontSize: 18,
                    color: Colors.black),
                const SizedBox(height: 10),
                StyledText(
                    title: user.email,
                    isBold: false,
                    fontSize: 16,
                    color: Colors.grey),
                const SizedBox(height: 10),
                FormContainer(
                    width: Get.width,
                    controller: _profileController.fullNameController,
                    labelText: 'Full Name',
                    isPasswordField: false,
                    inputType: TextInputType.text),
                const SizedBox(height: 10),
                FormContainer(
                    width: Get.width,
                    controller: _profileController.usernameController,
                    labelText: 'Username',
                    isPasswordField: false,
                    inputType: TextInputType.text),
                const SizedBox(height: 10),
                FormContainer(
                    width: Get.width,
                    controller: _profileController.passwordController,
                    labelText: 'Password',
                    isPasswordField: true,
                    inputType: TextInputType.text),
              ])),
            );
          }),
          const SizedBox(height: 20),
          Obx(() {
            return _profileController.isUpdating.value
                ? Center(
                    child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ))
                : GestureDetector(
                    onTap: () {
                      _profileController.updateUserData();
                      _userController.loadUserInfo();
                    },
                    child: Button(
                        title: 'Save',
                        width: Get.width * 0.4,
                        color: Theme.of(context).primaryColor),
                  );
          }),
          const SizedBox(height: 20),
          GetBuilder<UserController>(
            builder: (_) {
              return _userController.isSignOut
                  ? CircularProgressIndicator(
                      color: Theme.of(context).primaryColor)
                  : GestureDetector(
                      onTap: () {
                        _userController.signOut();
                      },
                      child: Button(
                          title: 'Sign out',
                          width: MediaQuery.of(context).size.width * 0.5,
                          color: const Color.fromARGB(255, 141, 10, 0)));
            },
          )
        ]),
      ),
    );
  }
}
