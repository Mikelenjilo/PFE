import 'package:get/get.dart';
import 'package:pfe_ui/core/services/django_helper.dart';
import 'package:pfe_ui/features/auth/domain/entities/user.dart';

class InscriptionController extends GetxController {
  String firstName = '';
  String lastName = '';
  late DateTime dateOfBirth;
  late String email;
  late String password;
  late Gender gender;
  DateTime? dateOfContamination;
  late bool ifTransmit;

  Future<void> inscription() async {
    if (await DjangoHelper.postRegisterUser(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
      gender: gender,
      cronicDiseases: [
        CronicDisease.none,
        CronicDisease.none,
        CronicDisease.none,
        CronicDisease.none,
        CronicDisease.none,
      ],
    )) {
      print('User created successfully');
    } else {
      print('User creation failed');
    }
  }
}
