import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:pfe_ui/core/services/django_helper.dart';
import 'package:pfe_ui/core/utils/database_constants.dart';
import 'package:pfe_ui/src/models/user.dart';
import 'package:pfe_ui/src/services/auth/auth_services.dart';

class AuthImpl implements IAuth {
  @override
  Future<User?> registerInWithEmailAndPassword({
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
        final User user = User.fromJson(jsonDecode(response.body));
        return user;
      } else {
        return null;
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
}
