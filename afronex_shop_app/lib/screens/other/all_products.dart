import 'package:afronex_shop_app/providers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllProductsPage extends StatelessWidget {
  AllProductsPage({super.key});

  final TextEditingController searchController = TextEditingController();
  final ProductController _productController = Get.find();
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}