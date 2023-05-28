import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe_ui/controller/app_bindings.dart';
import 'package:pfe_ui/middleware/auth_middleware.dart';
import 'package:pfe_ui/view/screens/app_page.dart';
import 'package:pfe_ui/view/screens/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(const EpidemicZone());
}

class EpidemicZone extends StatelessWidget {
  const EpidemicZone({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(),
      getPages: [
        GetPage(
          name: '/',
          page: () => const HomePage(),
          middlewares: [AuthMiddleWare()],
          binding: AppBindings(),
        ),
        GetPage(
          name: '/app',
          page: () => const AppPage(),
          middlewares: [AuthMiddleWare()],
          binding: AppBindings(),
        ),
      ],
    );
  }
}
