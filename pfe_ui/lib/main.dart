import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe_ui/features/auth/presentation/screens/inscription_page.dart';

void main() {
  runApp(EpidemicZone());
}

class EpidemicZone extends StatelessWidget {
  const EpidemicZone({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: InscriptionPage1(),
    );
  }
}
