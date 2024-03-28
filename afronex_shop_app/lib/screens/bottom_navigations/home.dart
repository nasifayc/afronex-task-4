import 'package:afronex_shop_app/providers/product_controller.dart';
import 'package:afronex_shop_app/providers/user_controller.dart';
import 'package:afronex_shop_app/widgets/buttons.dart';
import 'package:afronex_shop_app/widgets/product_card.dart';
import 'package:afronex_shop_app/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final TextEditingController searchController = TextEditingController();

  final UserController _userController = Get.find();

  final _productController = Get.put(ProductController());

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
                final user = _userController.user;
                return ListTile(
                    leading: CircleAvatar(
                      child: _userController.user.imgUrl == null
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
      body: RefreshIndicator(
        onRefresh: () async {
          await _productController.loadProductInfo();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                SearchBox(controller: searchController),
                // const SizedBox(height: 20),
                // CarouselSliderAnimation(),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Featured',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'See All',
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: Get.height * 0.38,
                  child: GetBuilder<ProductController>(
                    builder: (_) {
                      if (_productController.isLoading.value) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        );
                      } else {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _productController.featuredProducts.length,
                          itemBuilder: (context, index) {
                            final featuredProduct =
                                _productController.featuredProducts[index];
                            return SizedBox(
                              child: Row(
                                children: [
                                  ProductCard(
                                      imgUrl: featuredProduct.images[0],
                                      title: featuredProduct.title,
                                      price: featuredProduct.price),
                                  const SizedBox(
                                    width: 10,
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Most Popular',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'See All',
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.38,
                  child: GetBuilder<ProductController>(
                    builder: (_) {
                      if (_productController.isLoading.value) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        );
                      } else {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _productController.popularProducts.length,
                          itemBuilder: (context, index) {
                            final popularProduct =
                                _productController.popularProducts[index];
                            return SizedBox(
                              child: Row(
                                children: [
                                  ProductCard(
                                      imgUrl: popularProduct.images[0],
                                      title: popularProduct.title,
                                      price: popularProduct.price),
                                  const SizedBox(
                                    width: 10,
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
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
        ),
      ),
    );
  }
}
