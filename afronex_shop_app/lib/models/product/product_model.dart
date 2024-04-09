import 'package:afronex_shop_app/models/product/category_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductModel {
  int? id;
  String? title;
  int? price;
  String? description;
  Category? category;
  List<String?> images;
  bool? isAddedToCart;
  RxBool isAdded = false.obs;

  ProductModel(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      required this.images});

  void saveIsAddedState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAdded_$id', isAdded.value);
  }

  Future<void> loadIsAddedState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? storedValue = prefs.getBool('isAdded_$id');
    if (storedValue != null) {
      isAdded.value = storedValue;
    }
  }

  factory ProductModel.fromMap(Map<String, dynamic> json) {
    List<String?> listOfimages = (json['images'] as List<dynamic>)
        .map((image) => image.toString())
        .toList();

    return ProductModel(
        id: json['id'],
        title: json['title'],
        price: json['price'],
        description: json['description'],
        category: Category.fromMap(json['category']),
        images: listOfimages);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category!.toJson(),
      'images': images,
      'isAddedToCart': isAddedToCart
    };
  }
}
