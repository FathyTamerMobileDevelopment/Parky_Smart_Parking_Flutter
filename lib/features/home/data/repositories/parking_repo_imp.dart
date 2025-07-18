import 'package:dartz/dartz.dart';
import 'package:parky/core/errors/failures.dart';
import 'package:parky/features/home/domain/entities/lat_long_entity.dart';

import '../../../../core/errors/error_handler.dart';
import '../../domain/repositories/parking_repo.dart';
import '../datasources/remote/get_parking_remote_data_source.dart';

class ParkingRepoImp extends ParkingRepo {
  final GetParkingRemoteDataSource parkingDataSource;

  ParkingRepoImp(this.parkingDataSource);

  @override
  Future<Either<Failure, List<LatLongEntity>>> getParking(
      {required double lat, required long}) async {
    try {
      final parkingList =
          await parkingDataSource.getParking(lat: lat, long: long);
      return Right(parkingList);
    } on Exception catch (e) {
      return Left(ErrorHandler().handle(e));
    }
  }
}
