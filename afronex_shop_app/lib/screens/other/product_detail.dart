import 'package:afronex_shop_app/models/product/product_model.dart';
import 'package:afronex_shop_app/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: const [CircleAvatar(child: Icon(Icons.favorite))],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: Get.height * 0.4,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              image: DecorationImage(
                  image: NetworkImage(product.category!.image!),
                  fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(Get.width * 0.045),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        product.title!,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow
                            .ellipsis, // Display ellipsis (...) when the text overflows
                        maxLines: 3, // Limit the text to 2 lines
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '\$${product.price}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Description',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  product.description!,
                  style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey),
                ),
                SizedBox(height: Get.height * 0.1),
                Center(
                  child: Button(
                      title: 'Add to Cart',
                      width: Get.width * 0.4,
                      color: Theme.of(context).primaryColor),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
