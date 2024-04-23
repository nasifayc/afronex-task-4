import 'package:afronex_shop_app/models/product/product_model.dart';
import 'package:afronex_shop_app/services/product/product_services.dart';
import 'package:afronex_shop_app/services/utils/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductController extends GetxController {
  final ProductService service = ProductService();
  RxBool isAdded = false.obs;

  final featuredProducts = <ProductModel>[].obs;
  final popularProducts = <ProductModel>[].obs;
  final searchedProducts = <ProductModel>[].obs;
  final allProducts = <ProductModel>[].obs;

  final isLoading = true.obs;

  TextEditingController searchController = TextEditingController();
  RxString searchResult = ''.obs;
  RxBool isSearching = false.obs;
  RxBool isEmpty = true.obs;

  void clearValue() {
    searchController.clear();
    isEmpty.value = true;
    update();
  }

  Future<void> loadProductInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    try {
      isLoading(true);
      update();
      final List<ProductModel> fetchedFeaturedProducts =
          await service.fetchData(
              'https://api.escuelajs.co/api/v1/products?offset=0&limit=10');
      final List<ProductModel> fetchedPopularProducts = await service.fetchData(
          'https://api.escuelajs.co/api/v1/products?offset=10&limit=10');
      if (fetchedPopularProducts.isNotEmpty &&
          fetchedPopularProducts.isNotEmpty) {
        for (ProductModel product in fetchedFeaturedProducts) {
          await product.loadIsAddedState();
        }
        for (ProductModel product in fetchedPopularProducts) {
          await product.loadIsAddedState();
        }
        featuredProducts.assignAll(fetchedFeaturedProducts);
        popularProducts.assignAll(fetchedPopularProducts);
      } else {
        showToast(message: 'Can\'t Fetch Data');
      }
    } catch (e) {
      showToast(message: 'Loading Error: $e');
    } finally {
      isLoading(false);
      update();
    }
  }

  Future<void> searchProduct() async {
    isSearching.value = true;
    update();
    if (searchController.text.isNotEmpty) {
      searchResult.value = searchController.text.trim();
      isEmpty.value = false;
      update();
      try {
        final List<ProductModel> fetchedSearchProducts = await service.fetchData(
            'https://api.escuelajs.co/api/v1/products/?title=${searchController.text.trim()}');
        isSearching.value = false;
        update();
        if (fetchedSearchProducts.isNotEmpty) {
          for (ProductModel product in fetchedSearchProducts) {
            await product.loadIsAddedState();
            searchedProducts.assignAll(fetchedSearchProducts);
          }
        } else {
          searchedProducts.clear();
        }
      } catch (e) {
        showToast(message: 'Loading Error: $e');
      }
    }
  }

  Future<void> loadAllProducts() async {
    isLoading(true);
    update();
    try {
      final List<ProductModel> feachedAllProducts =
          await service.fetchData('https://api.escuelajs.co/api/v1/products');
      if (feachedAllProducts.isNotEmpty) {
        allProducts.assignAll(feachedAllProducts);
      }
    } catch (e) {
      showToast(message: 'Loading Error: $e');
    } finally {
      isLoading(false);
      update();
    }
  }
}
