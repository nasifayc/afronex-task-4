import 'package:afronex_shop_app/providers/user_controller.dart';
import 'package:afronex_shop_app/services/utils/image_slider.dart';
import 'package:afronex_shop_app/widgets/buttons.dart';
import 'package:afronex_shop_app/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  UserController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 30),
        child: AppBar(
          flexibleSpace: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              GetBuilder<UserController>(builder: (_) {
                final user = controller.user;
                return ListTile(
                    leading: CircleAvatar(
                      child: controller.user.imgUrl == null
                          ? Image.asset(user.defaultProfileURL)
                          : Image.network(user.imgUrl!),
                    ),
                    title: const Text('Hello!'),
                    subtitle: Text(user.username),
                    trailing: const Icon(Icons.shopping_cart));
              }),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              SearchBox(controller: searchController),
              const SizedBox(height: 20),
              CarouselSliderAnimation(),
              const SizedBox(height: 20),
              const Text(
                'Featured',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: Get.height * 0.2),
              const Text('Most Popular',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: Get.height * 0.2),
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
      ),
    );
  }
}
