import 'package:pfe_ui/core/services/django_helper.dart';
import 'package:pfe_ui/src/models/user.dart';
import 'package:pfe_ui/src/services/auth/auth_services.dart';

class AuthImpl implements IAuth {
  @override
  Future<bool> registerInWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    required String gender,
    DateTime? dateOfContamination,
  }) async {
    try {
      final bool registerUser = await DjangoHelper.postRegisterUser(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        dateOfBirth: dateOfBirth,
        gender: gender,
      );
      return registerUser;
    } on Exception catch (failure) {
      throw Exception('Error : $failure');
    }
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      if (await DjangoHelper.isEmailExist(email)) {
        final User user = await DjangoHelper.getUserByEmail(email);

        if (user.password == password) {
          await DjangoHelper.patchLoginUser(email: email);
          user.online = true;
          return user;
        } else {
          throw Exception('Password is incorrect');
        }
      } else {
        throw Exception('Email does not exist');
      }
    } on Exception catch (exception) {
      throw Exception('Error : $exception');
    }
  }

  @override
  Future<bool> signOut(User user) async {
    try {
      var signOut = await DjangoHelper.patchLogoutUser(email: user.email);
      return signOut;
    } on Exception catch (exception) {
      throw Exception('Error : $exception');
    }
  }
}
