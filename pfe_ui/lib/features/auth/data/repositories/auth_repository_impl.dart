import 'package:dartz/dartz.dart';
import 'package:pfe_ui/core/errors/exceptions.dart';
import 'package:pfe_ui/core/errors/failure.dart';
import 'package:pfe_ui/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:pfe_ui/features/auth/domain/entities/user.dart';
import 'package:pfe_ui/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, void>> registerInWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    required Gender gender,
    required List<CronicDisease> cronicDiseases,
  }) async {
    try {
      return Right(await localDataSource.registerInWithEmailAndPassword(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        dateOfBirth: dateOfBirth,
        gender: gender,
        cronicDiseases: cronicDiseases,
      ));
    } on DjangoException catch (failure) {
      return Left(DjangoFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, void>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      return Right(
          await localDataSource.signInWithEmailAndPassword(email, password));
    } on DjangoException catch (failure) {
      return Left(DjangoFailure(failure.message));
    }
  }

  @override
  Either<Failure, void> signOut(User user) {
    try {
      return Right(localDataSource.signOut(user));
    } on DjangoException catch (failure) {
      return Left(DjangoFailure(failure.message));
    }
  }
}
