import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.4,
      width: Get.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        image: DecorationImage(
            image: NetworkImage(
                'https://media.istockphoto.com/id/1438530470/photo/happy-business-owner-talking-to-some-employees-at-a-supermarket.webp?b=1&s=170667a&w=0&k=20&c=cPk03J1F7gF16QLc2NhcwW52kcxwY2t9TlRQLwEBNFg='),
            fit: BoxFit.cover),
      ),
    );
  }
}
