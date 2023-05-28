import 'package:get/get.dart';
import 'package:pfe_ui/controller/app_page_controller.dart';
import 'package:pfe_ui/controller/connexion_controller.dart';
import 'package:pfe_ui/controller/map_controller.dart';
import 'package:pfe_ui/controller/mot_de_passe_oublie_controller.dart';
import 'package:pfe_ui/controller/recommandation_controller.dart';
import 'package:pfe_ui/controller/update_info_controller.dart';
import 'package:pfe_ui/controller/user_controller.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppPageController());
    Get.lazyPut(() => MapAppController());
    Get.lazyPut(() => ConnexionController());
    Get.lazyPut(() => RecommandationController());
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => MotDePasseOublieController());
    Get.lazyPut(() => UpdateInfoController());
  }
}
