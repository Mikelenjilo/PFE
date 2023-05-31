import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe_ui/controller/user_controller.dart';
import 'package:pfe_ui/core/services/django_helper.dart';
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
      showError(errorText: 'Veuillez remplir tous les champs');
    } else if (!regex.hasMatch(email)) {
      showError(errorText: 'Veuillez entrer un email valide');
    } else if (!(await DjangoHelper.isEmailExist(email))) {
      showError(errorText: 'Cet email n\'existe pas');
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
      showError(errorText: 'Veuillez remplir tous les champs');
    } else if (!regex.hasMatch(email)) {
      showError(errorText: 'Veuillez entrer un email valide');
    } else if (!(await DjangoHelper.isEmailExist(email))) {
      showError(errorText: 'Cet email n\'existe pas');
    } else {
      try {
        final user = await DjangoHelper.getUserByEmail(email);
        if (user.password == password) {
          this.email = email;
          this.password = password;
          await signIn();
          return true;
        } else {
          showError(errorText: 'Mot de passe incorrect');
        }
      } on Exception catch (error) {
        showError(
          errorTitle: 'Erreur : $error',
          errorText: 'Une erreur est survenue',
        );
      }
    }
    return false;
  }

  Future<void> signIn() async {
    final User user =
        await AuthImpl().signInWithEmailAndPassword(email, password);

    Get.put<UserController>(UserController());
    Get.find<UserController>().setUser(user);
    // prefs!.setInt('id', user.userId);

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
