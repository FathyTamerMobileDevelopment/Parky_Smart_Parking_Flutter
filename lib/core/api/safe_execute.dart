import 'package:dartz/dartz.dart';
import '../errors/exception.dart';
import '../errors/failures.dart';
import '../utils/functions/kprint.dart';

/// This function is used to handle the exceptions that may occur
/// during the execution of a request.
///
/// It takes a request function as a parameter
/// and returns a Future of Either of Failure and T.
Future<Either<Failure, T>> safeExecute<T>({
  required Future<T> Function() request,
}) async {
  try {
    final response = await request();
    return Right(response);
  } on ServerException catch (e) {
    return Left(ServerFailure(
      message: e.errorMessageModel.message,
      code: e.errorMessageModel.statusCode?.toInt() ?? 0,
    ));
  } on Exception catch (e) {
    kprint("Error: ${e.toString()}");
    return Left(ServerFailure(message: e.toString()));
  }
}
