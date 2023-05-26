import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe_ui/core/services/django_helper.dart';
import 'package:pfe_ui/core/services/shared_preferences_services.dart';
import 'package:pfe_ui/src/models/user.dart';
import 'package:pfe_ui/src/services/auth/auth_services_impl.dart';
import 'package:pfe_ui/view/widgets/error_widget.dart';

class ConnexionController extends GetxController {
  late String email;
  late String password;

  Future<void> setEmail(String email) async {
    String emailRegex = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regex = RegExp(emailRegex);
    if (email.isEmpty) {
      showError('Veuillez remplir tous les champs');
    } else if (!regex.hasMatch(email)) {
      showError('Veuillez entrer un email valide');
    } else if (!(await DjangoHelper.isEmailExist(email))) {
      showError('Cet email n\'existe pas');
    } else {
      this.email = email;
    }
  }

  void setPassword(String password) {
    this.password = password;
  }

  Future<bool> setSignInInfo({
    required String email,
    required String password,
  }) async {
    String emailRegex = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regex = RegExp(emailRegex);
    if (email.isEmpty || password.isEmpty) {
      showError('Veuillez remplir tous les champs');
    } else if (!regex.hasMatch(email)) {
      showError('Veuillez entrer un email valide');
    } else if (!(await DjangoHelper.isEmailExist(email))) {
      showError('Cet email n\'existe pas');
    } else {
      final user = await DjangoHelper.getUserByEmail(email);
      if (user.password == password) {
        this.email = email;
        this.password = password;
        await signIn();
        return true;
      } else {
        showError('Mot de passe incorrect');
      }
    }
    return false;
  }

  Future<void> signIn() async {
    final User user =
        await AuthImpl().signInWithEmailAndPassword(email, password);

    SharedPreferencesService.setUserId(user.userId);
    SharedPreferencesService.setFirstName(user.firstName);
    SharedPreferencesService.setLastName(user.lastName);
    SharedPreferencesService.setDateOfBirth(user.dateOfBirth);
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
        user.dateOfContamination ?? '');
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
