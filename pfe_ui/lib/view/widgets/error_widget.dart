import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showError(String errorText) {
  Get.defaultDialog(
    title: '',
    content: Column(
      children: [
        const Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 60,
        ),
        const SizedBox(height: 20),
        const Text(
          'Erreur',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          errorText,
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ],
    ),
    actions: [
      ElevatedButton(
        onPressed: () => Get.back(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'OK',
          style: TextStyle(fontSize: 16),
        ),
      ),
    ],
    barrierDismissible: false,
  );
}
