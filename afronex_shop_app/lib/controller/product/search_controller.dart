import 'package:afronex_shop_app/controller/product/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBarController extends GetxController {
  TextEditingController searchController = TextEditingController();
  RxBool isSearching = false.obs;
  final ProductController _productController = Get.find();

  void clearValue() {
    isSearching.value = true;
    searchController.clear();
    update();
  }

  void searchProduct() {
    isSearching.value = true;
    update();
    if (searchController.text.isNotEmpty) {
      _productController.searchProduct(parameter: searchController.text.trim());
    } else {
      isSearching.value = true;
      update();
    }
    isSearching.value = false;
    update();
  }
}
