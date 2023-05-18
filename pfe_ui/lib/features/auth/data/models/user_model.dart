import 'package:pfe_ui/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.userId,
    required super.firstName,
    required super.lastName,
    required super.dateOfBirth,
    required super.email,
    required super.password,
    required super.cronicDisease1,
    required super.cronicDisease2,
    required super.cronicDisease3,
    required super.cronicDisease4,
    required super.cronicDisease5,
    required super.gender,
    required super.latitude,
    required super.longitude,
    required super.ifTransmit,
    required super.dateOfContamination,
    super.recommandation,
    super.clusterId,
    super.online,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'first_name': firstName,
      'last_name': lastName,
      'dateOfBirth': dateOfBirth,
      'email': email,
      'password': password,
      'cronic_disease_1': cronicDisease1.toStringValue(),
      'cronic_disease_2': cronicDisease2.toStringValue(),
      'cronic_disease_3': cronicDisease3.toStringValue(),
      'cronic_disease_4': cronicDisease4.toStringValue(),
      'cronic_disease_5': cronicDisease5.toStringValue(),
      'latitude': latitude,
      'longitude': longitude,
      'gender': gender,
      'date_of_contamination': dateOfContamination,
      'if_transmit': ifTransmit,
    };
  }

  @override
  String toString() {
    return 'User(user_id: $userId, first_name: $firstName, last_name: $lastName, dateOfBirth: $dateOfBirth, email: $email, password: $password, cronic_disease_1: $cronicDisease1, cronic_disease_2: $cronicDisease2, cronic_disease_3: $cronicDisease3, cronic_disease_4: $cronicDisease4, cronic_disease_5: $cronicDisease5, latitude: $latitude, longitude: $longitude, gender: $gender, date_of_contamination: $dateOfContamination, if_transmit: $ifTransmit, cluster_id: $clusterId)';
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final UserModel user = UserModel(
      userId: json['user_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      dateOfBirth: DateTime.parse(json['date_of_birth']),
      email: json['email'],
      password: json['password'],
      gender: EnumParsingGender.fromString(json['gender']),
      cronicDisease1: EnumParsingCronic.fromString(json['cronic_disease_1']),
      cronicDisease2: EnumParsingCronic.fromString(json['cronic_disease_2']),
      cronicDisease3: EnumParsingCronic.fromString(json['cronic_disease_3']),
      cronicDisease4: EnumParsingCronic.fromString(json['cronic_disease_4']),
      cronicDisease5: EnumParsingCronic.fromString(json['cronic_disease_5']),
      latitude: json['latitude'],
      longitude: json['longitude'],
      dateOfContamination: DateTime.parse(json['date_of_contamination']),
      ifTransmit: json['if_transmit'],
      clusterId: json['cluster_id'],
      recommandation: json['recommandation'],
      online: json['online'],
    );

    return user;
  }
}
