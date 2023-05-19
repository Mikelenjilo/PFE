import 'package:get/get.dart';
import 'package:pfe_ui/controller/user_info_controller.dart';
import 'package:pfe_ui/src/services/auth/auth_services_impl.dart';

class InscriptionController extends GetxController {
  String firstName = '';
  String lastName = '';
  late DateTime dateOfBirth;
  late String email;
  late String password;
  late String gender;
  DateTime? dateOfContamination;

  void setFirstName(String value) {
    firstName = value;
  }

  void setLastName(String value) {
    lastName = value;
  }

  void setDateOfBirth(DateTime value) {
    dateOfBirth = value;
  }

  void setEmail(String value) {
    email = value;
  }

  void setPassword(String value) {
    password = value;
  }

  void setGender(String value) {
    gender = value;
  }

  void setDateOfContamination(DateTime value) {
    dateOfContamination = value;
  }

  Future<void> inscription() async {
    final userInfoController = Get.find<UserInfoController>();
    AuthImpl().registerInWithEmailAndPassword(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
      gender: gender,
      dateOfContamination: dateOfContamination,
    );

    userInfoController.firstName = firstName;
    userInfoController.lastName = lastName;
    userInfoController.dateOfBirth = dateOfBirth;
    userInfoController.email = email;
    userInfoController.password = password;
    userInfoController.gender = gender;
    userInfoController.dateOfContamination = dateOfContamination;
  }
}
