import 'package:flutter/material.dart';
import 'package:pfe_ui/core/config/themes/constants.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final String hintText;
  final TextEditingController controller;
  CustomTextField(
      {super.key,
      required this.text,
      required this.hintText,
      required this.controller});

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
          style: kTextStyleTextField,
          decoration: kInputDecoration.copyWith(
            hintText: hintText,
          ),
          controller: controller,
        ),
      ],
    );
  }
}
