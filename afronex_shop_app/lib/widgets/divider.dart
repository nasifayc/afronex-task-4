import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 3,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 184, 184, 184),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}
