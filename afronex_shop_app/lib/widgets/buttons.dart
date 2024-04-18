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
        height: 50,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).primaryColor),
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
