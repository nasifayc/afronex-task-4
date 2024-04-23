import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Button extends StatelessWidget {
  final String title;
  final double width;
  final Color color;
  const Button(
      {super.key,
      required this.title,
      required this.width,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: Get.width * 0.7,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20), color: color),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
