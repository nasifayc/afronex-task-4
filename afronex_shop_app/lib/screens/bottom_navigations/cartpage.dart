import 'package:afronex_shop_app/providers/cart_controller.dart';
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
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 246, 243, 243),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const StyledText(
                          title: 'Order Summary',
                          isBold: true,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const StyledText(
                                        title: 'Items: ',
                                        isBold: false,
                                        fontSize: 18,
                                        color: Colors.grey),
                                    const Spacer(),
                                    StyledText(
                                      title: cartItems.length.toString(),
                                      isBold: true,
                                      fontSize: 18,
                                      color: Colors.black,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const StyledText(
                                        title: 'Total: ',
                                        isBold: false,
                                        fontSize: 18,
                                        color: Colors.grey),
                                    const Spacer(),
                                    StyledText(
                                      title:
                                          _cartController.totalPrice.toString(),
                                      isBold: true,
                                      fontSize: 18,
                                      color: Colors.black,
                                    )
                                  ],
                                )
                              ],
                            ))
                      ],
                    ),
                  )
                ],
              ));
        }
      }),
    );
  }
}
