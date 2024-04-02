import 'package:afronex_shop_app/providers/product_controller.dart';
import 'package:afronex_shop_app/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllProductsPage extends StatelessWidget {
  AllProductsPage({super.key});

  final TextEditingController searchController = TextEditingController();
  final ProductController _productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(Get.width * 0.025),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: Get.width * 0.045,
            mainAxisSpacing: Get.height * 0.045,
            childAspectRatio: Get.width / 700,
          ),
          itemCount: _productController.featuredProducts.length,
          itemBuilder: (context, index) {
            final product = _productController.featuredProducts[index];
            return ProductCard(product: product);
          },
        ),
      ),
    );
  }
}
