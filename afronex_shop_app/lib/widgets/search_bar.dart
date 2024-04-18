import 'package:afronex_shop_app/controller/product/product_controller.dart';
import 'package:afronex_shop_app/services/utils/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBox extends StatelessWidget {
  SearchBox({super.key});
  final ProductController _productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SearchBar(
          onChanged: (value) {
            value.isEmpty
                ? _productController.clearValue()
                : _productController.searchProduct();
          },
          backgroundColor: MaterialStatePropertyAll(Colors.grey[100]),
          controller: _productController.searchController,
          elevation: const MaterialStatePropertyAll(0),
          hintText: 'Search here',
          leading: GestureDetector(
              onTap: _productController.searchProduct,
              child: const Icon(Icons.search)),
        ),
        Positioned(
            right: 10,
            top: 10,
            child: GestureDetector(
              onTap: _productController.clearValue,
              child: CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: const Icon(Icons.clear),
              ),
            ))
      ],
    );
  }
}
