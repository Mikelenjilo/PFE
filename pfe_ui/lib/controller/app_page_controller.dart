import 'package:get/get.dart';
import 'package:pfe_ui/controller/recommandation_controller.dart';
import 'package:pfe_ui/controller/user_controller.dart';

final UserController userController = Get.find<UserController>();

class AppPageController extends GetxController {
  var currentIndex = 0;

  @override
  Future<void> onInit() async {
    await userController.createUserUsingId();
    super.onInit();
  }

  void changePage(int index) {
    currentIndex = index;
    if (currentIndex == 1) {
      final RecommandationController recommandationController =
          Get.find<RecommandationController>();

      recommandationController.getRecommandations();
    }
    update();
  }
}
