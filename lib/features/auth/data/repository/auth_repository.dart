import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:parky/core/errors/failures.dart';

import '../../../../core/api/dio_consumer.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/utils/functions/kprint.dart';
import '../models/login_model.dart';
import '../models/register_model.dart';
import '../models/token_model.dart';

class AuthRepository {
  final DioConsumer _dioConsumer = DioConsumer(dio: Dio());

  // login
  Future<Either<Failure, TokenModel>> login(LoginModel loginModel) async {
    try {
      final response = await _dioConsumer.post(
        path: '/api/login/',
        body: loginModel.toJson(),
      );

      return Right(TokenModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: "There was an error",
        code: e.errorMessageModel.statusCode?.toInt() ?? 0,
      ));
    } on Exception catch (e) {
      kprint("Error: ${e.toString()}");
      return const Left(ServerFailure(message: "There was an error"));
    }
  }

  // register
  Future<Either<Failure, void>> register() async {
    try {
      await _dioConsumer.post(
        path: '/api/register/',
        body: RegisterModel().toJson(),
        isFormData: true,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: "There was an error",
        code: e.errorMessageModel.statusCode?.toInt() ?? 0,
      ));
    } on Exception catch (e) {
      kprint("Error: ${e.toString()}");
      return const Left(ServerFailure(message: "There was an error"));
    }
  }
}
