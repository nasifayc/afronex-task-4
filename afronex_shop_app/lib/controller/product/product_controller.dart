import 'package:afronex_shop_app/models/product/product_model.dart';
import 'package:afronex_shop_app/services/product/product_services.dart';
import 'package:afronex_shop_app/services/utils/toast_message.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final ProductService service = ProductService();
  RxBool isAdded = false.obs;

  final featuredProducts = <ProductModel>[].obs;
  final popularProducts = <ProductModel>[].obs;
  final searchedProducts = <ProductModel>[].obs;
  final isLoading = true.obs;

  Future<void> loadProductInfo() async {
    try {
      isLoading(true);
      update();
      final List<ProductModel> fetchedFeaturedProducts =
          await service.fetchData(
              'https://api.escuelajs.co/api/v1/products?offset=0&limit=10');
      final List<ProductModel> fetchedPopularProducts = await service.fetchData(
          'https://api.escuelajs.co/api/v1/products?offset=0&limit=20');
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

  Future<void> searchProduct({required String parameter}) async {
    try {
      final List<ProductModel> fetchedSearchProducts = await service.fetchData(
          'https://api.escuelajs.co/api/v1/products/?title=$parameter');
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
