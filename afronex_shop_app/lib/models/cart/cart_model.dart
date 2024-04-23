import 'package:afronex_shop_app/models/product/product_model.dart';

class CartModel {
  final ProductModel item;
  int quantity;

  CartModel({required this.item, required this.quantity});

  factory CartModel.fromSnapshot(Map<String, dynamic> snapshot) {
    return CartModel(
      item: ProductModel.fromMap(snapshot['item']),
      quantity: snapshot['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'item': item.toJson(), 'quantity': quantity};
  }
}
