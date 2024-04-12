import 'package:afronex_shop_app/controller/product/cart_controller.dart';
import 'package:afronex_shop_app/screens/bottom_navigations/cart/cart_summary.dart';
import 'package:afronex_shop_app/screens/other/checkout/checkout.dart';
import 'package:afronex_shop_app/widgets/buttons.dart';
import 'package:afronex_shop_app/widgets/cart_card.dart';
import 'package:afronex_shop_app/widgets/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});
  final CartController _cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * 0.45,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            CartCard(item: cartItems[index]),
                            const SizedBox(
                              height: 15,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CartSummary(),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => Get.to(() => CheckOutPage()),
                    child: Button(
                        title: 'Check Out',
                        width: double.infinity,
                        color: Theme.of(context).primaryColor),
                  ),
                ],
              ));
        }
      }),
    );
  }
}
