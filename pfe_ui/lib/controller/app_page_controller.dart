import 'package:get/get.dart';

class AppPageController extends GetxController {
  var currentIndex = 0;

  void changePage(int index) {
    currentIndex = index;
    update();
  }
}
