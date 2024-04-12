import 'package:afronex_shop_app/controller/product/search_controller.dart';
import 'package:afronex_shop_app/services/utils/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBox extends StatelessWidget {
  SearchBox({super.key});
  final SearchBarController _searchController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SearchBar(
          onChanged: (value) {
            value.isEmpty
                ? showToast(message: 'value is empty')
                : _searchController.searchProduct();
          },
          backgroundColor: MaterialStatePropertyAll(Colors.grey[100]),
          controller: _searchController.searchController,
          elevation: const MaterialStatePropertyAll(0),
          hintText: 'Search here',
          leading: GestureDetector(
              onTap: () {
                _searchController.searchProduct();
              },
              child: const Icon(Icons.search)),
        ),
        Positioned(
            right: 10,
            top: 10,
            child: GestureDetector(
              onTap: _searchController.clearValue,
              child: CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: const Icon(Icons.clear),
              ),
            ))
      ],
    );
  }
}

