import 'package:dio/dio.dart';
import 'package:pfe_ui/core/errors/exceptions.dart';
import 'package:pfe_ui/core/services/django_helper.dart';
import 'package:pfe_ui/features/auth/data/models/user_model.dart';
import 'package:pfe_ui/features/auth/domain/entities/user.dart';

abstract class AuthLocalDataSource {
  Future<void> registerInWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    required Gender gender,
    required List<CronicDisease> cronicDiseases,
  });

  Future<void> signInWithEmailAndPassword(String email, String password);
  void signOut(User user);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final dio = Dio();
  @override
  Future<void> registerInWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    required Gender gender,
    required List<CronicDisease> cronicDiseases,
  }) async {
    DjangoHelper.postRegisterUser(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
      gender: gender,
      cronicDiseases: cronicDiseases,
    );
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    if (await DjangoHelper.isEmailExist(email)) {
      final UserModel user = await DjangoHelper.getUserByEmail(email);
      if (user.password == password) {
        return;
      } else {
        throw const DjangoException('Wrong password');
      }
    } else {
      throw const DjangoException('Email not found');
    }
  }

  @override
  Future<void> signOut(User user) async {
    user.online = false;
    await DjangoHelper.patchLoginUser(email: user.email);
  }
}
