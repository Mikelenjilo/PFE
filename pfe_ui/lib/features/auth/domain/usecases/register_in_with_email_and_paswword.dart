import 'package:dartz/dartz.dart';
import 'package:pfe_ui/core/errors/failure.dart';
import 'package:pfe_ui/features/auth/domain/entities/user.dart';
import 'package:pfe_ui/features/auth/domain/repositories/auth_repository.dart';

class RegisterInWithEmailAndPassword {
  final AuthRepository repository;

  RegisterInWithEmailAndPassword(this.repository);

  Future<Either<Failure, void>> run(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required DateTime dateOfBirth,
      required Gender gender,
      required List<CronicDisease> cronicDiseases}) async {
    return await repository.registerInWithEmailAndPassword(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        dateOfBirth: dateOfBirth,
        gender: gender,
        cronicDiseases: cronicDiseases);
  }
}
