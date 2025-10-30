import 'package:flutter/material.dart';

class Helpers {
  static void showSnackBar(BuildContext context, String message,
      {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.redAccent : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static String formatPrice(double price) {
    return "PKR ${price.toStringAsFixed(0)}";
  }

  static void dismissKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
