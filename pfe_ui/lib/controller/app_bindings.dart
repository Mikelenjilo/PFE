import 'package:get/get.dart';
import 'package:pfe_ui/controller/app_page_controller.dart';
import 'package:pfe_ui/controller/connexion_controller.dart';
import 'package:pfe_ui/controller/map_controller.dart';
import 'package:pfe_ui/controller/user_info_controller.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserInfoController());
    Get.lazyPut(() => AppPageController());
    Get.lazyPut(() => MapAppController());
    Get.lazyPut(() => ConnexionController());
  }
}
