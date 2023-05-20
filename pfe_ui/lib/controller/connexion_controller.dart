import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe_ui/core/services/shared_preferences_services.dart';
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

    // final userInfoController = Get.find<UserInfoController>();

    SharedPreferencesService.setUserId(user.userId);
    SharedPreferencesService.setFirstName(user.firstName);
    SharedPreferencesService.setLastName(user.lastName);
    SharedPreferencesService.setDateOfBirth(
        user.dateOfBirth.toString().split(' ')[0]);
    SharedPreferencesService.setEmail(user.email);
    SharedPreferencesService.setPassword(user.password);
    SharedPreferencesService.setCronicDisease1(user.cronicDisease1 ?? '');
    SharedPreferencesService.setCronicDisease2(user.cronicDisease2 ?? '');
    SharedPreferencesService.setCronicDisease3(user.cronicDisease3 ?? '');
    SharedPreferencesService.setCronicDisease4(user.cronicDisease4 ?? '');
    SharedPreferencesService.setCronicDisease5(user.cronicDisease5 ?? '');
    SharedPreferencesService.setGender(user.gender);
    SharedPreferencesService.setLatitude(user.latitude ?? 0.0);
    SharedPreferencesService.setLongitude(user.longitude ?? 0.0);
    SharedPreferencesService.setIfTransmit(user.ifTransmit ?? false);
    SharedPreferencesService.setDateOfContamination(
        user.dateOfContamination.toString().split(' ')[0]);
    SharedPreferencesService.setOnline(user.online ?? false);
    SharedPreferencesService.setClusterId(user.clusterId);

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
