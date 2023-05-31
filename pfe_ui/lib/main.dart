import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe_ui/controller/app_bindings.dart';
import 'package:pfe_ui/controller/user_controller.dart';
import 'package:pfe_ui/view/screens/welcome_page.dart';

// SharedPreferences? prefs;
UserController userController = Get.find<UserController>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // prefs = await SharedPreferencesService.init(prefs);
  // await SharedPreferencesService.createUserUsingId(prefs);
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
