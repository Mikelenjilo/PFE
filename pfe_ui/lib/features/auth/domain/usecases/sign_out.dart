import 'package:dartz/dartz.dart';
import 'package:pfe_ui/core/errors/failure.dart';
import 'package:pfe_ui/features/auth/domain/entities/user.dart';
import 'package:pfe_ui/features/auth/domain/repositories/auth_repository.dart';

class SignOut {
  final AuthRepository repository;

  SignOut(this.repository);

  Either<Failure, void> run(User user) {
    return repository.signOut(user);
  }
}
