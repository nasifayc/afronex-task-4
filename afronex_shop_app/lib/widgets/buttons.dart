import 'package:flutter/material.dart';

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
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
              colors: [Theme.of(context).primaryColor, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
      child: Center(
        child: Text(
          title,style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
