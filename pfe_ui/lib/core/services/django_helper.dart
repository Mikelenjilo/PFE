import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';
import 'package:pfe_ui/core/errors/exceptions.dart';
import 'package:pfe_ui/core/errors/failure.dart';
import 'package:pfe_ui/core/utils/database_constants.dart';
import 'package:pfe_ui/features/auth/data/models/cluster_model.dart';
import 'package:pfe_ui/features/auth/data/models/user_model.dart';
import 'package:pfe_ui/features/auth/domain/entities/user.dart';

class DjangoHelper {
  // Users GET
  static String getUsersUrl = '${DatabaseConstants.baseUrl}users/';
  static String getUserByEmailUrl =
      '${DatabaseConstants.baseUrl}get_user_by_email/}';

  static Future<List<UserModel>> getUsers() async {
    final Response response = await Dio().get(getUsersUrl);
    return response.data.map((json) => UserModel.fromJson(json)).toList();
  }

  static Future<UserModel> getUserByEmail(String email) async {
    final Response response = await Dio().get('$getUserByEmail?email=$email');
    return UserModel.fromJson(response.data);
  }

  static Future<UserModel> getUserById(int id) async {
    final Response response = await Dio().get('$getUsersUrl/$id');
    return UserModel.fromJson(response.data);
  }

  // Users POST
  static String postCreateUserUrl = '${DatabaseConstants.baseUrl}create_user/';

  static Future<bool> postRegisterUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    required Gender gender,
    required List<CronicDisease> cronicDiseases,
  }) async {
    Map<String, dynamic> data = {
      'first_name': firstName,
      'last_name': lastName,
      'date_of_birth': dateOfBirth,
      'email': email,
      'password': password,
      'gender': gender.toStringValue(),
      'cronic_disease_1': cronicDiseases[0].toStringValue(),
      'cronic_disease_2': cronicDiseases[1].toStringValue(),
      'cronic_disease_3': cronicDiseases[2].toStringValue(),
      'cronic_disease_4': cronicDiseases[3].toStringValue(),
      'cronic_disease_5': cronicDiseases[4].toStringValue(),
      'cluster_id_id': 0,
    };

    final Response response = await Dio().post(postCreateUserUrl, data: data);
    return response.statusCode == 200 ? true : false;
  }

  // Users PATCH
  static String patchLoginUserUrl = '${DatabaseConstants.baseUrl}login_user/';
  static String patchLogoutUserUrl = '${DatabaseConstants.baseUrl}logout_user/';
  static String patchUpdateUserPasswordUrl =
      '${DatabaseConstants.baseUrl}update_user_password/';
  static String patchUpdateUserLatitudeAndLongitudeUrl =
      '${DatabaseConstants.baseUrl}update_user_latitude_and_longitude/}';

  static Future<bool> patchLoginUser({required String email}) async {
    final Response response = await Dio().patch(patchLoginUserUrl);

    return response.statusCode == 200 ? true : false;
  }

  static Future<bool> patchLogoutUser({required String email}) async {
    final Response response = await Dio().patch(patchLoginUserUrl);

    return response.statusCode == 200 ? true : false;
  }

  static Future<bool> patchUpdateUserPassword(
      {required int userId, required String password}) async {
    final Map<String, dynamic> data = {'password': password};
    final Response response =
        await Dio().patch(patchUpdateUserPasswordUrl, data: data);

    return response.statusCode == 200 ? true : false;
  }

  static Future<bool> patchUpdateUserLatitudeAndLongitude(
      {required int userId, required LatLng position}) async {
    final Map<String, dynamic> data = {
      'latitude': position.latitude,
      'longitude': position.longitude,
    };
    final Response response =
        await Dio().patch(patchUpdateUserLatitudeAndLongitudeUrl, data: data);

    return response.statusCode == 200 ? true : false;
  }

  // Users DELETE
  static String deleteUserByIdUrl = '${DatabaseConstants.baseUrl}users/';

  static Future<bool> deleteUserById(int userId) async {
    final Response response = await Dio().delete('$deleteUserByIdUrl/$userId');

    return response.statusCode == 200 ? true : false;
  }

  // Clusters GET
  static String getClusterUrl = '${DatabaseConstants.baseUrl}clusters/';

  static Future<List<ClusterModel>> getClusters() async {
    final Response response = await Dio().get(getClusterUrl);
    return response.data.map((json) => ClusterModel.fromJson(json)).toList();
  }

  // Utils
  static Future<bool> isEmailExist(String email) async {
    try {
      await Dio().get('$getUserByEmailUrl?email=$email');

      return true;
    } on DjangoException catch (failure) {
      throw DjangoFailure(failure.message);
    }
  }
}
