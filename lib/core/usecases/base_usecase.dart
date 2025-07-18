import 'package:dartz/dartz.dart';
import 'package:parky/core/errors/failures.dart';

abstract class BaseUsecase<In, Out> {
  Future<Either<Failure, Out>> execute(In parameters);
}
