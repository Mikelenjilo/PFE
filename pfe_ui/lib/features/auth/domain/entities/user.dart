enum Gender { homme, femme }

extension EnumParsingGender on Gender {
  toStringValue() {
    return toString().split('.').last;
  }

  static Gender fromString(String value) {
    return Gender.values
        .firstWhere((element) => element.toStringValue() == value);
  }
}

enum CronicDisease {
  maladieRespiratoire,
  maladieCardiaque,
  diabete,
  cancer,
  maladieRenale,
  none,
}

extension EnumParsingCronic on CronicDisease {
  toStringValue() {
    return toString().split('.').last;
  }

  static CronicDisease fromString(String value) {
    return CronicDisease.values
        .firstWhere((element) => element.toStringValue() == value);
  }
}

class User {
  int userId;

  String firstName;
  String lastName;
  DateTime dateOfBirth;
  String email;
  String password;
  CronicDisease cronicDisease1;
  CronicDisease cronicDisease2;
  CronicDisease cronicDisease3;
  CronicDisease cronicDisease4;
  CronicDisease cronicDisease5;
  Gender gender;
  double latitude;
  double longitude;
  bool ifTransmit;
  DateTime dateOfContamination;
  double recommandation;
  int clusterId;
  bool online;

  User({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.email,
    required this.password,
    this.cronicDisease1 = CronicDisease.none,
    this.cronicDisease2 = CronicDisease.none,
    this.cronicDisease3 = CronicDisease.none,
    this.cronicDisease4 = CronicDisease.none,
    this.cronicDisease5 = CronicDisease.none,
    required this.gender,
    required this.latitude,
    required this.longitude,
    this.ifTransmit = false,
    required this.dateOfContamination,
    this.recommandation = 0.0,
    this.clusterId = 0,
    this.online = false,
  });
}
