import 'package:afronex_shop_app/models/cart/cart_model.dart';
import 'package:afronex_shop_app/services/utils/toast_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final collection = FirebaseFirestore.instance.collection('cart');
  List<CartModel> cartItems = <CartModel>[].obs;

  Future<void> loadCartItems({required String userId}) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await collection.doc(userId).get();
    final Map<String, dynamic>? data = snapshot.data();
    if (data != null && data.containsKey('items')) {
      showToast(message: "$userId has cart items");
      final List<dynamic> itemsData = data['items'];
      final List<CartModel> fetchedCartItems =
          itemsData.map((json) => CartModel.fromSnapshot(json)).toList();
      cartItems.clear();
      cartItems.addAll(fetchedCartItems);
      showToast(message: "fetched items are empty");
      update();
    } else {
      cartItems.clear();
      update();
    }
  }

  Future<void> addItemsToCart(CartModel cartItem, String userId) async {
    cartItems.add(cartItem);
    update();
    createCart(userId: userId);
  }

  Future<void> saveData({required String userId}) async {
    try {
      await collection.doc(userId).update({
        'items': cartItems.map((item) => item.toJson()).toList(),
      });
    } catch (e) {
      print('Saving data Error: $e');
      showToast(message: 'Saving Error: $e');
    }
  }

  Future<void> createCart({required String userId}) async {
    try {
      await collection.doc(userId).set({
        'items': cartItems.map((item) => item.toJson()).toList(),
      });
    } catch (e) {
      print('Creating data Error: $e');
      showToast(message: 'Creating data Error: $e');
    }
  }
}
