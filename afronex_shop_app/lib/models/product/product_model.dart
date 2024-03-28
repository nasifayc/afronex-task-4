import 'package:afronex_shop_app/models/product/category_model.dart';

class ProductModel {
  int? id;
  String? title;
  int? price;
  String? description;
  Category? category;
  List<String?> images;

  ProductModel(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      required this.images});

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
      'images': images
    };
  }
}
