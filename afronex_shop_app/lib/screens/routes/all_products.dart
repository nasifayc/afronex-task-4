import 'package:afronex_shop_app/controller/product/product_controller.dart';
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
      body: GetBuilder<ProductController>(builder: (_) {
        return _productController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor))
            : Padding(
                padding: EdgeInsets.all(Get.width * 0.025),
                child: ListView.builder(
                  itemCount: _productController.allProducts.length,
                  itemBuilder: (context, index) {
                    final product = _productController.allProducts[index];
                    return Column(
                      children: [
                        ProductCard(product: product, width: Get.width * 0.85),
                        SizedBox(height: Get.height * 0.07)
                      ],
                    );
                  },
                ),
              );
      }),
    );
  }
}
