import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  final int? code;

  /// This class is used to return failure
  /// when error occured with api (dio)
  const ServerFailure({
    required super.message,
    this.code,
  });

  @override
  List<Object?> get props => [message, code];
}

class FirebaseFailure extends Failure {
  const FirebaseFailure({
    required super.message,
  });
}

class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
  });
}
