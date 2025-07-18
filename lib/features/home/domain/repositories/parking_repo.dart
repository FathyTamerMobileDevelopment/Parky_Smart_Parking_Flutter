import 'package:dartz/dartz.dart';
import 'package:parky/features/home/domain/entities/lat_long_entity.dart';

import '../../../../core/errors/failures.dart';

abstract class ParkingRepo {
  Future<Either<Failure, List<LatLongEntity>>> getParking(
      {required double lat, required double long});
}
