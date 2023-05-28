import 'package:latlong2/latlong.dart';

class User {
  int userId;

  String firstName;
  String lastName;
  String dateOfBirth;
  String email;
  String password;
  List<String?>? cronicDiseases;
  String gender;
  LatLng? location;
  bool? ifTransmit;
  String? dateOfContamination;
  List<Map<String, num>>? recommandation;
  int clusterId = 0;
  bool online;

  User({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.email,
    required this.password,
    this.cronicDiseases,
    required this.gender,
    this.location,
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
      'cronic_disease_1': cronicDiseases?[0],
      'cronic_disease_2': cronicDiseases?[1],
      'cronic_disease_3': cronicDiseases?[2],
      'cronic_disease_4': cronicDiseases?[3],
      'cronic_disease_5': cronicDiseases?[4],
      'latitude': location?.latitude,
      'longitude': location?.longitude,
      'gender': gender,
      'date_of_contamination': dateOfContamination,
      'if_transmit': ifTransmit,
    };
  }

  @override
  String toString() {
    return 'User(user_id: $userId, first_name: $firstName, last_name: $lastName, dateOfBirth: $dateOfBirth, email: $email, password: $password, cronic_disease_1: ${cronicDiseases?[0]}, cronic_disease_2: ${cronicDiseases?[1]}, cronic_disease_3: ${cronicDiseases?[2]}, cronic_disease_4: ${cronicDiseases?[3]}, cronic_disease_5: ${cronicDiseases?[4]}, latitude: ${location?.latitude}, longitude: ${location?.longitude}, gender: $gender, date_of_contamination: $dateOfContamination, if_transmit: $ifTransmit, cluster_id: $clusterId)';
  }

  factory User.fromJson(Map<String, dynamic> json) {
    final User user = User(
      userId: json['user_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      dateOfBirth: json['date_of_birth'],
      email: json['email'],
      password: json['password'],
      gender: json['gender'],
      cronicDiseases: [
        json['cronic_disease_1'],
        json['cronic_disease_2'],
        json['cronic_disease_3'],
        json['cronic_disease_4'],
        json['cronic_disease_5'],
      ],
      location: LatLng(
        json['latitude'] ?? 0,
        json['longitude'] ?? 0,
      ),
      dateOfContamination: json['date_of_contamination'],
      ifTransmit: json['if_transmit'],
      clusterId: json['cluster_id'],
    );

    // maassi@gmail.com

    return user;
  }
}
