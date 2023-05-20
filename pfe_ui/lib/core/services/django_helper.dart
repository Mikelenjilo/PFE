import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';
import 'package:pfe_ui/core/utils/database_constants.dart';
import 'package:pfe_ui/src/models/cluster.dart';
import 'package:pfe_ui/src/models/user.dart';
import 'package:http/http.dart' as http;

class DjangoHelper {
  // Users GET
  static Future<List<User>> getUsers() async {
    final Uri uri = Uri.parse(DjangoConstants.getUsersUrl);
    final http.Response response = await http.get(uri);
    final decodedData = jsonDecode(response.body);
    return decodedData.map((json) => User.fromJson(json)).toList();
  }

  static Future<User> getUserByEmail(String email) async {
    final Uri url =
        Uri.parse('${DjangoConstants.getUserByEmailUrl}?email=$email');
    final http.Response response = await http.get(url);
    final userData = jsonDecode(response.body);
    return User.fromJson(userData);
  }

  static Future<User> getUserById(int id) async {
    final response = await Dio().get('${DjangoConstants.getUsersUrl}/$id');
    return User.fromJson(response.data);
  }

  static Future<bool> patchUpdateUserPassword(
      {required int userId, required String password}) async {
    final Map<String, dynamic> data = {'password': password};
    final String encodedData = jsonEncode(data);
    final Uri uri = Uri.parse('${DjangoConstants.getUsersUrl}/$userId');
    final http.Response response = await http.patch(uri, body: encodedData);

    return response.statusCode == 200 ? true : false;
  }

  static Future<bool> patchUpdateUserLatitudeAndLongitude(
      {required int userId, required LatLng position}) async {
    final Map<String, dynamic> data = {
      'latitude': position.latitude,
      'longitude': position.longitude,
    };
    final encodedData = jsonEncode(data);

    final Uri uri =
        Uri.parse(DjangoConstants.patchUpdateUserLatitudeAndLongitudeUrl);

    final http.Response response = await http.patch(uri, body: encodedData);

    return response.statusCode == 200 ? true : false;
  }

  // Users DELETE

  static Future<bool> deleteUserById(int userId) async {
    final Uri uri = Uri.parse('${DjangoConstants.deleteUserUrl}/$userId');

    final http.Response response = await http.delete(uri);

    return response.statusCode == 200 ? true : false;
  }

  // Clusters GET

  static Future<List<Cluster>> getClusters() async {
    final url = Uri.parse(DjangoConstants.getClustersUrl);
    final response = await http.get(url);

    final decodedData = jsonDecode(response.body);

    final clusters = decodedData
        .map((json) => Cluster.fromJson(json))
        .where((cluster) => cluster.clusterId != 0)
        .toList();

    return List<Cluster>.from(clusters);
  }

  static Future<Map<String, Map<String, dynamic>>>
      getClusterCentroidWithRadius() async {
    final List<Cluster> clusters = await DjangoHelper.getClusters();
    Map<String, Map<String, dynamic>> clustersData = {};

    for (var cluster in clusters) {
      clustersData[cluster.clusterId.toString()] = {
        'centroid': LatLng(
          cluster.centroidPosition.latitude,
          cluster.centroidPosition.longitude,
        ),
        'radius': cluster.radius,
      };
    }

    return clustersData;
  }

  // Utils
  static Future<bool> isEmailExist(String email) async {
    try {
      final url =
          Uri.parse('${DjangoConstants.getUserByEmailUrl}?email=$email');
      final response = await http.get(url);

      return response.statusCode == 200 ? true : false;
    } on Exception catch (exception) {
      throw Exception('Error: $exception');
    }
  }
}
