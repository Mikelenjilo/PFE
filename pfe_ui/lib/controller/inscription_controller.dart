import 'package:get/get.dart';
import 'package:pfe_ui/controller/user_controller.dart';
import 'package:pfe_ui/core/services/django_helper.dart';
import 'package:pfe_ui/src/models/user.dart';
import 'package:pfe_ui/src/services/auth/auth_services_impl.dart';
import 'package:pfe_ui/view/widgets/error_widget.dart';

class InscriptionController extends GetxController {
  String firstName = '';
  String lastName = '';
  late String dateOfBirth;
  late String email;
  late String password;
  late String gender;
  String? dateOfContamination;
  RxString selectedValue = ''.obs;
  RxList diseases = [].obs;
  RxBool diabete = false.obs;
  RxBool maladieCardiaque = false.obs;
  RxBool maladieRespiratoire = false.obs;
  RxBool cancer = false.obs;
  RxBool maladieRenale = false.obs;
  bool isInscriptionDone = false;

  Future<bool> setInfoPage1({
    required String email,
    required String password,
    required String passwordConfrimation,
  }) async {
    String emailRegex = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regex = RegExp(emailRegex);
    if (email.isEmpty || password.isEmpty || passwordConfrimation.isEmpty) {
      showError(errorText: 'Veuillez remplir tous les champs');
    } else if (!regex.hasMatch(email)) {
      showError(errorText: 'Veuillez entrer un email valide');
    } else if (await DjangoHelper.isEmailExist(email)) {
      showError(errorText: 'Cet email existe déjà');
    } else if (password.length < 6) {
      showError(
          errorText: 'Le mot de passe doit contenir au moins 6 caractères');
    } else if (password != passwordConfrimation) {
      showError(errorText: 'Les mots de passe ne correspondent pas');
    } else {
      this.email = email;
      this.password = password;
      return true;
    }
    return false;
  }

  bool setInfoPage2({
    required String firstName,
    required String lastName,
    required String dateOfBirth,
    required String gender,
  }) {
    String dateRegex = r'^\d{4}-\d{2}-\d{2}$';
    RegExp regex = RegExp(dateRegex);
    if (firstName.isEmpty || lastName.isEmpty || dateOfBirth.isEmpty) {
      showError(errorText: 'Veuillez remplir tous les champs');
    } else if (DateTime.now().year - DateTime.parse(dateOfBirth).year >= 120) {
      showError(
          errorText:
              'Veuillez entre une date de naissance valide, vous devez avoir moins de 120 ans');
    } else if (DateTime.now().year - DateTime.parse(dateOfBirth).year <= 2) {
      showError(
          errorText:
              'Veuillez entre une date de naissance valide, vous devez avoir plus de 2 ans');
    } else if (!regex.hasMatch(dateOfBirth)) {
      showError(
          errorText:
              'Veuillez entrer une date de naissance valide (yyyy-mm-dd)');
    } else if (gender.isEmpty) {
      showError(errorText: 'Veuillez entrer votre genre');
    } else {
      this.firstName = firstName;
      this.lastName = lastName;
      this.dateOfBirth = dateOfBirth;
      this.gender = gender;
      return true;
    }
    return false;
  }

  Future<void> inscription() async {
    final User user = await AuthImpl().registerInWithEmailAndPassword(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
      gender: gender,
    );

    if (diseases.length != 5) {
      List<String?> cronicDiseasesWithNullValues = List.generate(
        5,
        (index) => index < diseases.length ? diseases[index] : null,
      );
      await AuthImpl().updateCronicDiseases(
        user: user,
        diseases: cronicDiseasesWithNullValues,
      );

      Get.find<UserController>().clear();
      Get.find<UserController>().setUser(user);

      return;
    }

    await AuthImpl().updateCronicDiseases(
      user: user,
      diseases: diseases.toList().cast<String>(),
    );

    Get.find<UserController>().clear();
    Get.find<UserController>().setUser(user);
    isInscriptionDone = true;
  }
}
