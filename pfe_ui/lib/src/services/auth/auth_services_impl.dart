import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import 'package:pfe_ui/core/services/django_helper.dart';
import 'package:pfe_ui/core/services/shared_preferences_services.dart';
import 'package:pfe_ui/core/utils/database_constants.dart';
import 'package:pfe_ui/src/models/cluster.dart';
import 'package:pfe_ui/src/models/user.dart';
import 'package:pfe_ui/src/services/auth/auth_services.dart';

class AuthImpl implements IAuth {
  @override
  Future<User> registerInWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String dateOfBirth,
    required String gender,
    String? dateOfContamination,
  }) async {
    try {
      Map<String, dynamic> data = {
        'first_name': firstName,
        'last_name': lastName,
        'date_of_birth': dateOfBirth,
        'email': email,
        'password': password,
        'gender': gender,
        'date_of_contamination': dateOfContamination,
        'cluster_id': 0,
      };
      final String encodedData = json.encode(data);

      final Uri url = Uri.parse(DjangoConstants.postCreateUserUrl);
      final http.Response response = await http.post(
        url,
        body: encodedData,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        final User user = await DjangoHelper.getUserByEmail(email);
        user.online = true;
        return user;
      } else {
        throw Exception('Error : ${response.statusCode}');
      }
    } on Exception catch (failure) {
      throw Exception('Error : $failure');
    }
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      final User user = await DjangoHelper.getUserByEmail(email);

      user.online = true;
      return user;
    } on Exception catch (exception) {
      throw Exception('Error : $exception');
    }
  }

  @override
  Future<bool> signOut(User user) async {
    try {
      final Uri url = Uri.parse(DjangoConstants.patchLogoutUserUrl);
      final http.Response response = await http.patch(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        user.online = false;
        return true;
      } else {
        throw Exception('Error : ${response.statusCode}');
      }
    } on Exception catch (exception) {
      throw Exception('Error : $exception');
    }
  }

  @override
  Future<void> updateCronicDiseases({
    required User user,
    required List<String> diseases,
  }) async {
    user.cronicDiseases = diseases;
    await DjangoHelper.patchUpdateUserCronicDiseases(
      userId: user.userId,
      cronicDiseases: diseases,
    );
  }

  @override
  Future<void> assignUserToClosestCluster(User user) async {
    LatLng userLocation =
        LatLng(user.location!.latitude, user.location!.longitude);
    List<Cluster> clusters = await DjangoHelper.getClusters();

    double distance1 = 1000000000.0;
    for (var cluster in clusters) {
      LatLng clusterCentroidLocation = LatLng(cluster.centroidPosition.latitude,
          cluster.centroidPosition.longitude);

      double distance2 = const Distance()
          .as(LengthUnit.Meter, userLocation, clusterCentroidLocation);

      if (distance2 < distance1) {
        distance1 = distance2;
        user.clusterId = cluster.clusterId;
      }
    }
  }
}
