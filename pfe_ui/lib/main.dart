import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe_ui/controller/app_bindings.dart';
import 'package:pfe_ui/controller/user_controller.dart';
import 'package:pfe_ui/core/services/shared_preferences_services.dart';
import 'package:pfe_ui/view/screens/app_page.dart';
import 'package:pfe_ui/view/screens/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;
UserController userController = Get.find<UserController>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferencesService.init(prefs);
  await SharedPreferencesService.createUserUsingId(prefs);
  runApp(const EpidemicZone());
}

class EpidemicZone extends StatelessWidget {
  const EpidemicZone({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(),
      home: prefs!.getInt('id') != null ? const AppPage() : const HomePage(),
    );
  }
}
