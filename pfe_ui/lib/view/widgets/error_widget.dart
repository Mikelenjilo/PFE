import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showError(String errorText) {
  Get.dialog(
    AlertDialog(
      title: const Text('Error'),
      content: Text(errorText),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
