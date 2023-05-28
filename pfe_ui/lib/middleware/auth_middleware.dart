import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe_ui/main.dart';

class AuthMiddleWare extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (Get.currentRoute != route) {
      print('Redirect middleware executed for route: $route');

      if (prefs!.getInt('id') != null) {
        print('User ID found in SharedPreferences. Redirecting to /app');

        return const RouteSettings(name: '/app');
      } else {
        print('User ID not found in SharedPreferences. Redirecting to /');

        return const RouteSettings(name: '/');
      }
    }
    return null;
  }
}
