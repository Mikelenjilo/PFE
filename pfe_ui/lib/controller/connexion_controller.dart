import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe_ui/controller/user_info_controller.dart';
import 'package:pfe_ui/src/models/user.dart';
import 'package:pfe_ui/src/services/auth/auth_services_impl.dart';

class ConnexionController extends GetxController {
  late String email;
  late String password;

  void setEmail(String email) {
    this.email = email;
  }

  void setPassword(String password) {
    this.password = password;
  }

  Future<void> signIn() async {
    final User user =
        await AuthImpl().signInWithEmailAndPassword(email, password);

    final userInfoController = Get.find<UserInfoController>();

    userInfoController.userId = user.userId;
    userInfoController.firstName = user.firstName;
    userInfoController.lastName = user.lastName;
    userInfoController.dateOfBirth = user.dateOfBirth;
    userInfoController.email = user.email;
    userInfoController.password = user.password;
    userInfoController.cronicDisease1 = user.cronicDisease1;
    userInfoController.cronicDisease2 = user.cronicDisease2;
    userInfoController.cronicDisease3 = user.cronicDisease3;
    userInfoController.cronicDisease4 = user.cronicDisease4;
    userInfoController.cronicDisease5 = user.cronicDisease5;
    userInfoController.gender = user.gender;
    userInfoController.latitude = user.latitude;
    userInfoController.longitude = user.longitude;
    userInfoController.ifTransmit = user.ifTransmit;
    userInfoController.dateOfContamination = user.dateOfContamination;
    userInfoController.online = user.online;
    userInfoController.clusterId = user.clusterId;

    Get.snackbar(
      'Connexion réussie',
      'Bienvenue ${user.lastName} ${user.firstName}',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }
}
