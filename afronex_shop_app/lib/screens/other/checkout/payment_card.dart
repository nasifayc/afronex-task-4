import 'package:flutter/material.dart';

class PaymentCard {
  PaymentCard(
      {required this.icon, required this.name, this.isSelected = false});
  final Icon icon;
  final String name;
  bool isSelected;

  void toggleSelected() {
    isSelected = !isSelected;
  }
}
