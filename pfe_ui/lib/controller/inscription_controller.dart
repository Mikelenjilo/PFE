import 'package:get/get.dart';
import 'package:pfe_ui/core/services/django_helper.dart';
import 'package:pfe_ui/core/services/shared_preferences_services.dart';
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
  RxBool diabete = false.obs;
  RxBool cancer = false.obs;
  RxBool maladiesCardiaques = false.obs;
  RxBool maladiesRenales = false.obs;
  RxBool maladieRespiratoire = false.obs;

  setFirstName(String value) {
    firstName = value;
  }

  void setLastName(String value) {
    lastName = value;
  }

  void setDateOfBirth(String value) {
    dateOfBirth = value;
  }

  Future<bool> setEmail(String email) async {
    if (await DjangoHelper.isEmailExist(email)) {
      showError('Cet email existe déjà');
      return false;
    } else {
      this.email = email;
      return true;
    }
  }

  void setPassword(String password, String passwordConfirmation) {
    this.password = password;
  }

  void setGender(String gender) {
    this.gender = gender;
  }

  void setDateOfContamination(String dateOfContamination) {
    this.dateOfContamination = dateOfContamination;
  }

  Future<bool> setInfoPage1({
    required String email,
    required String password,
    required String passwordConfrimation,
  }) async {
    String emailRegex = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regex = RegExp(emailRegex);
    if (email.isEmpty || password.isEmpty || passwordConfrimation.isEmpty) {
      showError('Veuillez remplir tous les champs');
    } else if (!regex.hasMatch(email)) {
      showError('Veuillez entrer un email valide');
    } else if (await DjangoHelper.isEmailExist(email)) {
      showError('Cet email existe déjà');
    } else if (password.length < 6) {
      showError('Le mot de passe doit contenir au moins 6 caractères');
    } else if (password != passwordConfrimation) {
      showError('Les mots de passe ne correspondent pas');
    } else {
      await setEmail(email);
      setPassword(password, passwordConfrimation);
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
      showError('Veuillez remplir tous les champs');
    } else if (DateTime.now().year - DateTime.parse(dateOfBirth).year >= 120) {
      showError(
          'Veuillez entre une date de naissance valide, vous devez avoir moins de 120 ans');
    } else if (DateTime.now().year - DateTime.parse(dateOfBirth).year <= 2) {
      showError(
          'Veuillez entre une date de naissance valide, vous devez avoir plus de 2 ans');
    } else if (!regex.hasMatch(dateOfBirth)) {
      showError('Veuillez entrer une date de naissance valide (yyyy-mm-dd)');
    } else if (gender.isEmpty) {
      showError('Veuillez entrer votre genre');
    } else {
      setFirstName(firstName);
      setLastName(lastName);
      setDateOfBirth(dateOfBirth);
      setGender(gender);
      return true;
    }
    return false;
  }

  Future<void> setInfoPage3({
    String? dateOfContamination,
  }) async {
    if (selectedValue.value == 'Oui') {
      setDateOfContamination(DateTime.now().toString().split(' ')[0]);
      await inscription();
    } else if (selectedValue.value == 'Non') {
      await inscription();
    } else {
      showError('Veuillez choisir une réponse');
    }
  }

  Future<void> inscription() async {
    final User? user = await AuthImpl().registerInWithEmailAndPassword(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
      gender: gender,
      dateOfContamination: dateOfContamination,
    );

    if (user == null) {
      showError('Une erreur est survenue');
      return;
    } else {
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
    }
  }
}
