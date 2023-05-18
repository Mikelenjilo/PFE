import 'package:dartz/dartz.dart';
import 'package:pfe_ui/core/errors/failure.dart';
import 'package:pfe_ui/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> registerInWithEmailAndPassword(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required DateTime dateOfBirth,
      required Gender gender,
      required List<CronicDisease> cronicDiseases});
  Future<Either<Failure, void>> signInWithEmailAndPassword(
      String email, String password);
  Either<Failure, void> signOut(User user);
}
