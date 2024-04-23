import 'package:afronex_shop_app/controller/user/user_controller.dart';
import 'package:afronex_shop_app/widgets/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomeAppBar extends StatelessWidget {
  final UserController _userController = Get.find();
  CustomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        height: 80,
        padding: const EdgeInsets.only(top: 10, bottom: 10, right: 20),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(255, 220, 220, 220),
                  offset: Offset(0, 4),
                  blurRadius: 4,
                  spreadRadius: 0)
            ]),
        child: GetBuilder<UserController>(builder: (_) {
          final user = _userController.user;
          return Row(children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: user.imgUrl == null
                  ? AssetImage(user.defaultProfileURL) as ImageProvider
                  : NetworkImage(user.imgUrl!),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6))),
                    child: StyledText(
                        title: user.username,
                        color: Colors.white,
                        fontSize: 16,
                        isBold: true),
                  ),
                  const SizedBox(height: 5),
                  StyledText(
                      title: user.fullName,
                      color: Colors.grey,
                      fontSize: 16,
                      isBold: true),
                ]),
            const Spacer(),
            const CircleAvatar(child: Icon(Icons.notifications))
          ]);
        }),
      ),
    );
  }
}
