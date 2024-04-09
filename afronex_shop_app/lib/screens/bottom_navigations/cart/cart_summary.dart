import 'package:afronex_shop_app/models/cart/cart_model.dart';
import 'package:afronex_shop_app/providers/cart_controller.dart';
import 'package:afronex_shop_app/widgets/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartSummary extends StatelessWidget {
  CartSummary({super.key});

  final CartController _cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final cartItems = _cartController.cartItems;
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                          title: _cartController.totalPrice.toString(),
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
      );
    });
  }
}
