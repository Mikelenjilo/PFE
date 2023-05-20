class User {
  int userId;

  String firstName;
  String lastName;
  DateTime dateOfBirth;
  String email;
  String password;
  String? cronicDisease1;
  String? cronicDisease2;
  String? cronicDisease3;
  String? cronicDisease4;
  String? cronicDisease5;
  String gender;
  double? latitude;
  double? longitude;
  bool? ifTransmit;
  DateTime? dateOfContamination;
  List<Map<String, num>>? recommandation;
  int clusterId = 0;
  bool? online;

  User({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.email,
    required this.password,
    this.cronicDisease1,
    this.cronicDisease2,
    this.cronicDisease3,
    this.cronicDisease4,
    this.cronicDisease5,
    required this.gender,
    this.latitude,
    this.longitude,
    this.ifTransmit = false,
    this.dateOfContamination,
    this.recommandation,
    this.clusterId = 0,
    this.online = false,
  });
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'first_name': firstName,
      'last_name': lastName,
      'dateOfBirth': dateOfBirth,
      'email': email,
      'password': password,
      'cronic_disease_1': cronicDisease1,
      'cronic_disease_2': cronicDisease2,
      'cronic_disease_3': cronicDisease3,
      'cronic_disease_4': cronicDisease4,
      'cronic_disease_5': cronicDisease5,
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

  factory User.fromJson(Map<String, dynamic> json) {
    final User user = User(
      userId: json['user_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      dateOfBirth: DateTime.parse(json['date_of_birth']),
      email: json['email'],
      password: json['password'],
      gender: json['gender'],
      cronicDisease1: json['cronic_disease_1'],
      cronicDisease2: json['cronic_disease_2'],
      cronicDisease3: json['cronic_disease_3'],
      cronicDisease4: json['cronic_disease_4'],
      cronicDisease5: json['cronic_disease_5'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      dateOfContamination: DateTime.parse(json['date_of_contamination']),
      ifTransmit: json['if_transmit'],
      clusterId: json['cluster_id'],
      online: json['online'],
    );

    return user;
  }
}
