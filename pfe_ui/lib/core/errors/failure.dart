import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class DjangoFailure extends Failure {
  const DjangoFailure(super.message);

  @override
  String toString() => 'LocalDatabaseFailure(message: $message)';
}
