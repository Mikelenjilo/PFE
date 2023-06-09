import 'package:flutter/material.dart';
import 'package:pfe_ui/core/utils/ui_constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomDropDownButtomField extends StatelessWidget {
  final Function(String?)? genderLogic;
  const CustomDropDownButtomField({super.key, required this.genderLogic});

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
              prefixIcon: const Icon(
                FontAwesomeIcons.venusMars,
                color: Colors.grey,
                size: 20,
              ),
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
            onChanged: genderLogic,
          ),
        ),
      ],
    );
  }
}
