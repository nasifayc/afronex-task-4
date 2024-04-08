import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  const StyledText({super.key, required this.title,required this.isBold, required this.fontSize, required this.color});
  final String title;
  final bool isBold;
  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: color,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        fontSize: fontSize,
      ),
    );
  }
}
