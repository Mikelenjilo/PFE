import 'package:get/get.dart';

class Covid19QuestionController extends GetxController {
  var isSick = false.obs;

  void submitAnswer(bool answer) {
    isSick.value = answer;
  }
}
