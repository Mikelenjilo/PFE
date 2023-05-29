import 'package:get/get.dart';
import 'package:pfe_ui/controller/user_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

UserController userController = Get.find<UserController>();

class SharedPreferencesService {
  SharedPreferences? prefs;

  static Future<SharedPreferences?> init(prefs) async {
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  static Future<void> createUserUsingId(prefs) async {
    if (prefs!.getInt('id') != null) {
      await userController.createUserUsingId();
    }
  }
}
