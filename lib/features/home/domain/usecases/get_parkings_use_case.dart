import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/lat_long_entity.dart';
import '../repositories/parking_repo.dart';

class GetParkingsUseCase {
  final ParkingRepo _parkingRepo;

  GetParkingsUseCase(this._parkingRepo);

  Future<Either<Failure, List<LatLongEntity>>> execute(
      {required double lat, required double long}) async {
    return _parkingRepo.getParking(lat: lat, long: long);
  }
}
