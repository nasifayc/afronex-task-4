import 'package:afronex_shop_app/models/product/product_model.dart';
import 'package:afronex_shop_app/services/product/product_services.dart';
import 'package:afronex_shop_app/services/utils/toast_message.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final ProductService service = ProductService();
  late List<ProductModel>? _products;

  List<ProductModel>? get products => _products;
  
  @override
  void onInit() {
    super.onInit();
    loadProductInfo();
  }

  Future<void> loadProductInfo() async {
    try {
      _products =
          await service.fetchData('https://api.escuelajs.co/api/v1/products');
      if (_products != null) {
        update();
      }
    } catch (e) {
      showToast(message: 'Loading Error: $e');
    }
  }
}
