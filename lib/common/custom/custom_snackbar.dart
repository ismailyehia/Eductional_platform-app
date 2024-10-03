import 'package:flutter/material.dart';
SnackBar customSnackBar(String message) {
  return SnackBar(
    backgroundColor: Colors.green, // Change to your preferred color
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.check_circle, color: Colors.white),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            message,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 10),
        const Icon(Icons.close, color: Colors.white),
      ],
    ),
    duration: const Duration(seconds: 7),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  );
}
