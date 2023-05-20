import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';
import 'package:pfe_ui/core/utils/database_constants.dart';
import 'package:pfe_ui/src/models/cluster.dart';
import 'package:pfe_ui/src/models/user.dart';
import 'package:http/http.dart' as http;

class DjangoHelper {
  // Users GET
  static String getUsersUrl = '${DjangoConstants.baseUrl}users/';
  static String getUserByEmailUrl =
      '${DjangoConstants.baseUrl}get_user_by_email/';

  static Future<List<User>> getUsers() async {
    final response = await Dio().get(getUsersUrl);
    return response.data.map((json) => User.fromJson(json)).toList();
  }

  static Future<User> getUserByEmail(String email) async {
    final url = Uri.parse('$getUserByEmailUrl?email=$email');
    final response = await http.get(url);
    final userData = jsonDecode(response.body);
    return User.fromJson(userData);
  }

  static Future<User> getUserById(int id) async {
    final response = await Dio().get('$getUsersUrl/$id');
    return User.fromJson(response.data);
  }

  // Users POST
  static String postCreateUserUrl = '${DjangoConstants.baseUrl}create_user/';

  // Users PATCH
  static String patchLoginUserUrl = '${DjangoConstants.baseUrl}login_user/';
  static String patchLogoutUserUrl = '${DjangoConstants.baseUrl}logout_user/';
  static String patchUpdateUserPasswordUrl =
      '${DjangoConstants.baseUrl}update_user_password/';
  static String patchUpdateUserLatitudeAndLongitudeUrl =
      '${DjangoConstants.baseUrl}update_user_latitude_and_longitude/}';

  static Future<bool> patchUpdateUserPassword(
      {required int userId, required String password}) async {
    final Map<String, dynamic> data = {'password': password};
    final response = await Dio().patch(patchUpdateUserPasswordUrl, data: data);

    return response.statusCode == 200 ? true : false;
  }

  static Future<bool> patchUpdateUserLatitudeAndLongitude(
      {required int userId, required LatLng position}) async {
    final Map<String, dynamic> data = {
      'latitude': position.latitude,
      'longitude': position.longitude,
    };
    final response =
        await Dio().patch(patchUpdateUserLatitudeAndLongitudeUrl, data: data);

    return response.statusCode == 200 ? true : false;
  }

  // Users DELETE
  static String deleteUserByIdUrl = '${DjangoConstants.baseUrl}users/';

  static Future<bool> deleteUserById(int userId) async {
    final response = await Dio().delete('$deleteUserByIdUrl/$userId');

    return response.statusCode == 200 ? true : false;
  }

  // Clusters GET
  static String getClusterUrl = '${DjangoConstants.baseUrl}clusters/';

  static Future<List<Cluster>> getClusters() async {
    final url = Uri.parse(getClusterUrl);
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
      final url = Uri.parse('$getUserByEmailUrl?email=$email');
      final response = await http.get(url);

      return response.statusCode == 200 ? true : false;
    } on Exception catch (exception) {
      throw Exception('Error: $exception');
    }
  }
}
