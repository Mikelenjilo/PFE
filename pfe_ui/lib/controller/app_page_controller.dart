import 'package:get/get.dart';
import 'package:pfe_ui/controller/recommandation_controller.dart';

class AppPageController extends GetxController {
  var currentIndex = 0;

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
