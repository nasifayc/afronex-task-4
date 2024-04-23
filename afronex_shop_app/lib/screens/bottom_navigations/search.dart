import 'package:afronex_shop_app/controller/product/product_controller.dart';
import 'package:afronex_shop_app/widgets/product_card.dart';
import 'package:afronex_shop_app/widgets/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../widgets/search_bar.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  //final SearchBarController _searchController = Get.find();
  final ProductController _productController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(children: [
              SearchBox(),
              const SizedBox(
                height: 10,
              ),
              Obx(() {
                if (_productController.isSearching.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  );
                }
                if (_productController.isEmpty.value) {
                  return Center(
                    child: Column(
                      children: [
                        Lottie.asset(
                          "asset/animations/Animation - 1713401698592.json",
                          height: Get.height * 0.4,
                        ),
                        const SizedBox(height: 20),
                        const StyledText(
                            title: 'Results will Appear here',
                            fontSize: 16,
                            isBold: false,
                            color: Colors.grey)
                      ],
                    ),
                  );
                }
                if (_productController.searchedProducts.isEmpty) {
                  return const Center(
                    child: StyledText(
                      title: 'No Result found',
                      fontSize: 18,
                      isBold: true,
                      color: Colors.grey,
                    ),
                  );
                } else {
                  return SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StyledText(
                            title:
                                'Results For "${_productController.searchResult}"',
                            isBold: true,
                            color: Colors.black,
                            fontSize: 16),
                        SizedBox(height: Get.height * 0.09),
                        Container(
                          padding: EdgeInsets.only(bottom: Get.width * 0.57),
                          height: Get.height,
                          child: ListView.builder(
                            itemCount:
                                _productController.searchedProducts.length,
                            itemBuilder: (context, index) {
                              final product =
                                  _productController.searchedProducts[index];
                              return Column(
                                children: [
                                  ProductCard(
                                      product: product, width: Get.width),
                                  SizedBox(height: Get.height * 0.03)
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              })
            ]),
          ),
        ));
  }
}
