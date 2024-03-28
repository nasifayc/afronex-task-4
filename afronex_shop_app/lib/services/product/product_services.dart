import 'dart:convert';
import 'package:afronex_shop_app/models/product/product_model.dart';
import 'package:afronex_shop_app/services/utils/toast_message.dart';
import 'package:http/http.dart' as http;

class ProductService {
  Future<List<ProductModel>> fetchData(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        return data.map((json) => ProductModel.fromMap(json)).toList();
      } else {
        throw Exception('Some error occured while fetching data');
      }
    } catch (e) {
      showToast(message: 'Fetching Erroe Occured: $e');
    }
    return [];
  }
}
