import 'package:afronex_shop_app/models/product/product_model.dart';
import 'package:afronex_shop_app/services/product/product_services.dart';
import 'package:afronex_shop_app/services/utils/toast_message.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final ProductService service = ProductService();

  final featuredProducts = <ProductModel>[].obs;
  final popularProducts = <ProductModel>[].obs;
  // var totalProducts =  <ProductModel>[].obs;
  final isLoading = true.obs;


  Future<void> loadProductInfo() async {
    try {
      isLoading(true);
      update();
      final List<ProductModel> fetchedFeaturedProducts =
          await service.fetchData(
              'https://api.escuelajs.co/api/v1/products?offset=20&limit=20');
      final List<ProductModel> fetchedPopularProducts = await service.fetchData(
          'https://api.escuelajs.co/api/v1/products?offset=30&limit=20');
      if (fetchedPopularProducts.isNotEmpty &&
          fetchedPopularProducts.isNotEmpty) {
        featuredProducts.assignAll(fetchedFeaturedProducts);
        popularProducts.assignAll(fetchedPopularProducts);
      } else {
        showToast(message: 'Can\'t Fetch Data');
      }

      //   totalProducts = RxList<ProductModel>()
      // ..addAll(featuredProducts.value)
      // ..addAll(popularProducts.value);
    } catch (e) {
      showToast(message: 'Loading Error: $e');
    } finally {
      isLoading(false);
      update();
    }
  }
}
