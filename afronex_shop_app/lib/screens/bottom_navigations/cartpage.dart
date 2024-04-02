import 'package:afronex_shop_app/providers/cart_controller.dart';
import 'package:afronex_shop_app/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});
  final CartController _cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Cart'),
            centerTitle: true,
          ),
          body: GetBuilder<CartController>(builder: (_) {
            final cartItems = _cartController.cartItems;
            if (cartItems.isEmpty) {
              return const Center(
                child: Text('No Items Add'),
              );
            } else {
              return Padding(
                padding: EdgeInsets.all(Get.width * 0.025),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: Get.width * 0.045,
                    mainAxisSpacing: Get.height * 0.045,
                    childAspectRatio: Get.width / 700,
                  ),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final product = cartItems[index];
                    return Stack(children: [
                      ProductCard(product: product.item),
                      Positioned(
                          child: CircleAvatar(
                        child: Text(product.quantity.toString()),
                      ))
                    ]);
                  },
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}
