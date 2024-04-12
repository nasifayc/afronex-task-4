import 'package:afronex_shop_app/providers/payement_controller/payment_controller.dart';
import 'package:afronex_shop_app/screens/bottom_navigations/cart/cart_summary.dart';
import 'package:afronex_shop_app/screens/other/checkout/payment.dart';
import 'package:afronex_shop_app/widgets/buttons.dart';
import 'package:afronex_shop_app/widgets/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckOutPage extends StatelessWidget {
  CheckOutPage({super.key});
  final PaymentController _paymentController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check Out'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CartSummary(),
            const SizedBox(
              height: 20,
            ),
            const StyledText(
                title: 'Choose payment method',
                isBold: true,
                fontSize: 18,
                color: Colors.black),
            const SizedBox(
              height: 20,
            ),
            PaymentOptions(),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                _paymentController.paypal();
              },
              child: Button(
                  title: 'Check Out',
                  width: Get.width * 0.6,
                  color: Theme.of(context).primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
