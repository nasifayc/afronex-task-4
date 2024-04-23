import 'package:afronex_shop_app/models/cart/cart_model.dart';
import 'package:afronex_shop_app/controller/product/cart_controller.dart';
import 'package:afronex_shop_app/controller/user/user_controller.dart';
import 'package:afronex_shop_app/screens/routes/product_detail.dart';
import 'package:afronex_shop_app/widgets/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartCard extends StatelessWidget {
  CartCard({super.key, required this.item});
  final CartModel item;

  final CartController _cartController = Get.find();
  final UserController _userController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetail(product: item.item));
      },
      child: Container(
        //height: Get.height * 0.2,
        width: Get.width,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                offset: Offset(0, 3),
                color: Color.fromARGB(255, 205, 205, 205),
              )
            ],
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              Row(
                children: [
                  Container(
                    height: Get.height * 0.15,
                    width: Get.width * 0.3,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                            image: NetworkImage(item.item.images[0]!),
                            fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    width: Get.width * 0.03,
                  ),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StyledText(
                          title: item.item.category!.name!,
                          isBold: true,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        StyledText(
                          title: item.item.category!.name!,
                          isBold: false,
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        StyledText(
                          title: '\$${item.item.price!}',
                          isBold: true,
                          fontSize: 16,
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () async {
                      final user = _userController.user;
                      item.item.isAdded.value = false;
                      item.item.saveIsAddedState();
                      _cartController.deleteItem(
                          userId: user.userId, item: item);
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  )),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          final user = _userController.user;
                          _cartController.decreaseQuantity(item, user.userId);
                        },
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: const Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      StyledText(
                          title: item.quantity.toString(),
                          isBold: true,
                          fontSize: 20,
                          color: Colors.black),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          final user = _userController.user;
                          _cartController.increaseQuantity(item, user.userId);
                        },
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: 15,
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
