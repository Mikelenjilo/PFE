import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe_ui/controller/app_bindings.dart';
import 'package:pfe_ui/view/screens/connexion_page.dart';

void main() {
  runApp(EpidemicZone());
}

class EpidemicZone extends StatelessWidget {
  const EpidemicZone({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const Connexion(),
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(),
    );
  }
}
