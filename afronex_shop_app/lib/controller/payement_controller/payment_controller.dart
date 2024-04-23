import 'package:afronex_shop_app/controller/product/cart_controller.dart';
import 'package:afronex_shop_app/screens/routes/checkout/checkout.dart';
import 'package:afronex_shop_app/screens/routes/checkout/payment_card.dart';
import 'package:afronex_shop_app/services/utils/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:get/get.dart';



class PaymentController extends GetxController {
  final CartController _cartController = Get.find();

  final List<PaymentCard> cards = [
    PaymentCard(icon: const Icon(Icons.payment), name: 'Paypal'),
    PaymentCard(icon: const Icon(Icons.credit_card), name: 'Google Pay'),
    PaymentCard(icon: const Icon(Icons.money), name: 'Cash'),
  ].obs;

  // var googlePayButton = GooglePayButton(
  //   paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
  //   paymentItems: const [
  //     PaymentItem(
  //       label: 'Total',
  //       amount: '0.01',
  //       status: PaymentItemStatus.final_price,
  //     )
  //   ],
  //   width: Get.width,
  //   type: GooglePayButtonType.buy,
  //   margin: const EdgeInsets.only(top: 15),
  //   onPaymentResult: (result) => showToast(message: result.toString()),
  //   loadingIndicator: const Center(child: CircularProgressIndicator()),
  // );
  void selectCard(int index) {
    for (int i = 0; i < cards.length; i++) {
      if (i == index) {
        cards[i].toggleSelected();
      } else {
        cards[i].isSelected = false;
      }
    }
    update();
  }

  void paypal() async {
    await Get.to(() => PaypalCheckoutView(
          sandboxMode: true,
          clientId:
              "AWZvsxu3RpPa09QmaDGQESzokzS-XktU4Dk7nLMkjsea488GSTknltiwGQ7KGL9ykXGnGkMhh6gc5DU1",
          secretKey:
              "EGcIdWU0TRYOi2Hmla4CocPHmPJEW-fUJLeig9xpnD3prRYmaoD-sJBc3okvnXGSAlYkCno2UloElifZ",
          transactions: [
            {
              "amount": {
                "total": _cartController.totalPrice.value.toString(),
                "currency": "USD",
                "details": {
                  "subtotal": _cartController.subTotalPrice.value.toString(),
                  "shipping": '10',
                  "shipping_discount": 0
                }
              },
              "description": "The payment transaction description.",
              // "payment_options": {
              //   "allowed_payment_method":
              //       "INSTANT_FUNDING_SOURCE"
              // },
              "item_list": {
                "items": _cartController.cartItems
                    .map((cartModel) => {
                          "name": cartModel.item.category!.name!,
                          "quantity": cartModel.quantity,
                          "price": cartModel.item.price.toString(),
                          "currency": "USD"
                        })
                    .toList(),
              }
            }
          ],
          note: "Contact us for any questions on your order.",
          onSuccess: (Map params) async {
            showToast(message: "onSuccess: $params");
            Get.off(() => CheckOutPage());
          },
          onError: (error) {
            debugPrint("onError: $error");
            showToast(message: "onError: $error");
            Get.off(() => CheckOutPage());
          },
          onCancel: () {
            showToast(message: "cancelled");
            Get.off(() => CheckOutPage());
          },
        ));
  }
}
