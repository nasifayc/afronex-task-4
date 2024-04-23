import 'package:afronex_shop_app/models/cart/cart_model.dart';
import 'package:afronex_shop_app/models/product/product_model.dart';
import 'package:afronex_shop_app/controller/product/cart_controller.dart';
import 'package:afronex_shop_app/controller/user/user_controller.dart';
import 'package:afronex_shop_app/screens/routes/product_detail.dart';
import 'package:afronex_shop_app/services/utils/toast_message.dart';
import 'package:afronex_shop_app/widgets/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final double width;
  final CartController _cartController = Get.find();
  final UserController _userController = Get.find();
  ProductCard({super.key, required this.product, required this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetail(
              product: product,
            ));
      },
      child: Stack(
        children: [
          Container(
            width: width,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 215, 215, 215),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 2,
                  )
                ],
                color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: Get.height * 0.2,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(product.images[0]!),
                          fit: BoxFit.cover),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 10.0),
                  child: StyledText(
                      title: '\$${product.price}',
                      fontSize: 18,
                      color: Theme.of(context).primaryColor,
                      isBold: true),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 10.0, bottom: 5),
                  child: Flexible(
                    child: Text(
                      product.title!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Obx(() => Visibility(
                  visible: !product.isAdded.value,
                  child: GestureDetector(
                    onTap: () async {
                      CartModel newCartModel =
                          CartModel(item: product, quantity: 1);
                      _cartController.addItemsToCart(
                          newCartModel, _userController.user.userId);
                      showToast(message: 'Item Add!');
                      product.isAdded.value = true;
                      product.saveIsAddedState();
                      // Set isAdded to true
                    },
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
