import 'package:afronex_shop_app/providers/user_controller.dart';
import 'package:afronex_shop_app/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GetBuilder<UserController>(
              builder: (_) {
                final user = controller.user;
                return Text(
                  'Welcome ${user.username} Your Email: ${user.email}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                );
              },
            ),
            const SizedBox(height: 20),
            GetBuilder<UserController>(
              builder: (controller) {
                return controller.isSignOut
                    ? CircularProgressIndicator(
                        color: Theme.of(context).primaryColor)
                    : GestureDetector(
                        onTap: () {
                          controller.signOut();
                        },
                        child: Button(
                            title: 'Sign out',
                            width: MediaQuery.of(context).size.width * 0.5,
                            color: Theme.of(context).primaryColor));
              },
            )
          ],
        ),
      ),
    );
  }
}
