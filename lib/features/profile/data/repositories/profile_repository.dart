import 'package:dartz/dartz.dart';
import 'package:parky/features/profile/data/datasources/profile_remote_data_source.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/functions/kprint.dart';
import '../models/user_model.dart';

class ProfileRepository {
  final _profileRemoteDataSource = ProfileRemoteDataSource();

  Future<Either<Failure, List<AllUsersModel>>> getAllUsers() async {
    try {
      return Right(await _profileRemoteDataSource.getAllUsers());
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

  Future<Either<Failure, UserModel>> getProfile() async {
    try {
      return Right(await _profileRemoteDataSource.getProfile());
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
