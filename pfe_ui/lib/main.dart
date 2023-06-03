import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe_ui/controller/app_bindings.dart';
import 'package:pfe_ui/view/screens/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const EpidemicZone());
}

class EpidemicZone extends StatelessWidget {
  const EpidemicZone({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(),
      home: const HomePage(),
    );
  }
}
