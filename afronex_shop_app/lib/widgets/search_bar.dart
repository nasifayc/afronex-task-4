import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      backgroundColor: MaterialStatePropertyAll(Colors.grey[100]),
      controller: controller,
      elevation: const MaterialStatePropertyAll(0),
      hintText: 'Search here',
      leading: GestureDetector(onTap: () {}, child: const Icon(Icons.search)),
    );
  }
}
