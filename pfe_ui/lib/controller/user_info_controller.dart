import 'package:get/get.dart';

class UserInfoController extends GetxController {
  late int userId;
  String? firstName;
  String? lastName;
  DateTime? dateOfBirth;
  String? email;
  String? password;
  String? cronicDisease1;
  String? cronicDisease2;
  String? cronicDisease3;
  String? cronicDisease4;
  String? cronicDisease5;
  String? gender;
  double? latitude;
  double? longitude;
  bool? ifTransmit;
  DateTime? dateOfContamination;
  List<Map<String, num>>? recommandation;
  bool? online;
  int clusterId = 0;
}
