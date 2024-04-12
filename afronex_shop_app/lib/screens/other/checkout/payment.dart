import 'package:afronex_shop_app/providers/payement_controller/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentOptions extends StatelessWidget {
  PaymentOptions({super.key});
  final PaymentController _paymentController = Get.put(PaymentController());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: Get.height * 0.3,
        child: ListView.builder(
          itemCount: _paymentController.cards.length,
          itemBuilder: (context, index) {
            return GetBuilder<PaymentController>(
              builder: (_) {
                final card = _paymentController.cards[index];
                return CheckboxListTile(
                  title: Row(
                    children: [
                      card.icon,
                      const SizedBox(
                        width: 5,
                      ),
                      Text(card.name),
                    ],
                  ),
                  value: card.isSelected,
                  onChanged: (value) {
                    _paymentController.selectCard(index);
                  },
                );
              },
            );
          },
        ));
  }
}
