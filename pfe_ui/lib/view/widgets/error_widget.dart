import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showError({String? errorTitle, required String errorText}) {
  Get.dialog(
    AlertDialog(
      title: Text(errorTitle ?? 'Erreur'),
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
