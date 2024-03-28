import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  final String? imgUrl;
  final String? title;
  final int? price;
  const ProductCard(
      {super.key,
      required this.imgUrl,
      required this.title,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.4,
      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: Get.height * 0.2,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(imgUrl!), fit: BoxFit.cover),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
          ),
          const SizedBox(
            height: 10,
          ),
          Flexible(
            child: Text(
              title!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow
                  .ellipsis, // Display ellipsis (...) when the text overflows
              maxLines: 2, // Limit the text to 2 lines
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '\$$price',
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
