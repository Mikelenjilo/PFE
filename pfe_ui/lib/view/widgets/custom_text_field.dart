import 'package:flutter/material.dart';
import 'package:pfe_ui/core/utils/ui_constants.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.text,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: kTextStyleLabel,
        ),
        const SizedBox(height: 9.0),
        TextField(
          keyboardType: keyboardType,
          style: kTextStyleTextField,
          decoration: kInputDecoration.copyWith(
            hintText: hintText,
          ),
          controller: controller,
          obscureText: obscureText,
        ),
      ],
    );
  }
}
