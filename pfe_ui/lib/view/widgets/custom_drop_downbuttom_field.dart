import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe_ui/core/config/themes/constants.dart';
import 'package:pfe_ui/controller/inscription_controller.dart';

class CustomDropDownButtomField extends StatelessWidget {
  const CustomDropDownButtomField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Genre',
          style: kTextStyleLabel,
        ),
        const SizedBox(height: 9.0),
        SizedBox(
          height: 70.0,
          child: DropdownButtonFormField(
            decoration: kInputDecoration.copyWith(
              hintText: 'Entrez votre genre',
            ),
            items: const [
              DropdownMenuItem(
                value: 'Homme',
                child: Text(
                  'Homme',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
              DropdownMenuItem(
                value: 'Femme',
                child: Text(
                  'Femme',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
            ],
            onChanged: (value) {
              var controller = Get.find<InscriptionController>();
              var gender = value!;
              controller.gender = gender;
            },
          ),
        ),
      ],
    );
  }
}
