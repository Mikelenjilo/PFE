import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe_ui/controller/user_controller.dart';
import 'package:pfe_ui/core/services/django_helper.dart';
import 'package:pfe_ui/src/models/user.dart';
import 'package:pfe_ui/view/widgets/error_widget.dart';

final UserController userController = Get.find<UserController>();
final User? user = Get.find<UserController>().user;

class UpdateInfoController extends GetxController {
  late final String nom;
  late final String prenom;
  late final String dateNaissance;
  late final String ancienMotDePasse;
  late final String nouveauMotDePasse;

  Future<void> setInfo({
    required String nom,
    required String prenom,
    required String dateNaissance,
    required String ancienMotDePasse,
    required String nouveauMotDePasse,
    required String confirmationNouveauMotDePasse,
  }) async {
    String dateRegex = r'^\d{4}-\d{2}-\d{2}$';
    RegExp regex = RegExp(dateRegex);
    if (nom.isEmpty ||
        prenom.isEmpty ||
        dateNaissance.isEmpty ||
        ancienMotDePasse.isEmpty ||
        nouveauMotDePasse.isEmpty ||
        confirmationNouveauMotDePasse.isEmpty) {
      showError(errorText: 'Veuillez remplir tous les champs');
      return;
    } else if (!regex.hasMatch(dateNaissance)) {
      showError(errorText: 'Veuillez entre une date de naissance valide');
    } else if (DateTime.now().year - DateTime.parse(dateNaissance).year >=
        120) {
      showError(
          errorText:
              'Veuillez entre une date de naissance valide, vous devez avoir moins de 120 ans');
    } else if (DateTime.now().year - DateTime.parse(dateNaissance).year <= 2) {
      showError(
          errorText:
              'Veuillez entre une date de naissance valide, vous devez avoir plus de 2 ans');
    } else if (ancienMotDePasse != user?.password) {
      showError(errorText: 'Ancien mot de passe incorrect');
    } else if (ancienMotDePasse == nouveauMotDePasse) {
      showError(
          errorText:
              'Le nouveau mot de passe doit être différent de l\'ancien');
    } else if (nouveauMotDePasse != confirmationNouveauMotDePasse) {
      showError(errorText: 'Les mots de passe ne correspondent pas');
    } else {
      if (await updateInfo(
        nom: nom,
        prenom: prenom,
        dateNaissance: dateNaissance,
        nouveauMotDePasse: nouveauMotDePasse,
      )) {
        userController.update();
        Get.back();
        Get.snackbar(
          'Succès',
          'Vos informations ont été mises à jour',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        showError(errorText: 'Une erreur est survenue');
      }
    }
  }

  Future<bool> updateInfo({
    required String nom,
    required String prenom,
    required String dateNaissance,
    required String nouveauMotDePasse,
  }) async {
    final bool isSet = await DjangoHelper.patchUpdateUserInfos(
      userId: user!.userId,
      lastName: nom,
      firstName: prenom,
      dateOfBirth: dateNaissance,
      password: nouveauMotDePasse,
    );
    user!.lastName = nom;
    user!.firstName = prenom;
    user!.dateOfBirth = dateNaissance;
    user!.password = nouveauMotDePasse;

    return isSet;
  }
}
