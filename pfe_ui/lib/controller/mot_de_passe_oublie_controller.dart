import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe_ui/core/services/django_helper.dart';
import 'package:pfe_ui/view/widgets/error_widget.dart';

class MotDePasseOublieController extends GetxController {
  late final String email;
  late final String password;

  Future<void> setInfo({
    required email,
    required password,
    required passwordConfirm,
  }) async {
    String emailRegex = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regex = RegExp(emailRegex);
    if (email.isEmpty || password.isEmpty || passwordConfirm.isEmpty) {
      showError(errorText: 'Veuillez remplir tous les champs');
    } else if (!regex.hasMatch(email)) {
      showError(errorText: 'Veuillez entrer un email valide');
    } else if (!(await DjangoHelper.isEmailExist(email))) {
      showError(errorText: 'Le compte avec cet email n\'existe pas');
    } else if (password.length < 6) {
      showError(
          errorText: 'Le mot de passe doit contenir au moins 6 caractères');
    } else if (password != passwordConfirm) {
      showError(errorText: 'Les mots de passe ne correspondent pas');
    } else {
      if (await resetPassword(email, password)) {
        Get.back();
        Get.snackbar(
          'Succès',
          'Votre mot de passe a été rénitialisé avec succès',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        showError(errorText: 'Une erreur est survenue');
      }
    }
  }

  Future<bool> resetPassword(String email, String password) async {
    return await DjangoHelper.patchUpdateUserPassword(
      email: email,
      password: password,
    );
  }
}
