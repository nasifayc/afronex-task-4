import 'package:afronex_shop_app/controller/product/product_controller.dart';
import 'package:afronex_shop_app/screens/routes/all_products.dart';
import 'package:afronex_shop_app/services/utils/image_slider.dart';
import 'package:afronex_shop_app/widgets/app_bar.dart';
import 'package:afronex_shop_app/widgets/product_card.dart';
import 'package:afronex_shop_app/widgets/search_bar.dart';
import 'package:afronex_shop_app/widgets/styled_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ProductController _productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 50),
        child: CustomeAppBar(),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _productController.loadProductInfo();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchBox(),
                const SizedBox(height: 20),
                CarouselSliderAnimation(),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Expanded(
                      child: StyledText(
                          title: 'Featured',
                          fontSize: 20,
                          isBold: true,
                          color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        _productController.loadAllProducts();
                        Get.to(() => AllProductsPage());
                      },
                      child: StyledText(
                          title: 'See All',
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                          isBold: false),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: Get.height * 0.37,
                  child: GetBuilder<ProductController>(
                    builder: (_) {
                      if (_productController.isLoading.value) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        );
                      } else {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _productController.featuredProducts.length,
                          itemBuilder: (context, index) {
                            final featuredProduct =
                                _productController.featuredProducts[index];
                            return SizedBox(
                              child: Row(
                                children: [
                                  ProductCard(
                                      product: featuredProduct,
                                      width: Get.width * 0.48),
                                  const SizedBox(
                                    width: 25,
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: Get.height * 0.07),
                Row(
                  children: [
                    const Expanded(
                      child: StyledText(
                          title: 'Trending',
                          fontSize: 20,
                          isBold: true,
                          color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        _productController.loadAllProducts();
                        Get.to(() => AllProductsPage());
                      },
                      child: StyledText(
                          title: 'See All',
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                          isBold: false),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: Get.height * 0.37,
                  child: GetBuilder<ProductController>(
                    builder: (_) {
                      if (_productController.isLoading.value) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        );
                      } else {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _productController.popularProducts.length,
                          itemBuilder: (context, index) {
                            final popularProduct =
                                _productController.popularProducts[index];
                            return SizedBox(
                              child: Row(
                                children: [
                                  ProductCard(
                                      product: popularProduct,
                                      width: Get.width * 0.48),
                                  const SizedBox(
                                    width: 25,
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
