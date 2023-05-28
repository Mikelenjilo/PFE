import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe_ui/controller/user_controller.dart';
import 'package:pfe_ui/core/services/django_helper.dart';
import 'package:pfe_ui/main.dart';
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
    print(Get.find<UserController>().user);
    Get.find<UserController>().setUser(user);
    print(user);
    print(Get.find<UserController>().user);

    prefs!.setInt('id', user.userId);
    print(prefs!.getInt('id'));

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
