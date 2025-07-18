// register parking singleton
import 'package:dio/dio.dart';
import 'package:parky/core/api/dio_consumer.dart';
import 'package:parky/core/utils/widgets/di/di.dart';
import 'package:parky/features/home/data/datasources/remote/get_parking_remote_data_source.dart';
import 'package:parky/features/home/data/repositories/parking_repo_imp.dart';

import '../../../../features/home/domain/usecases/get_parkings_use_case.dart';

void registerParking() {
  sl.registerLazySingleton<GetParkingsUseCase>(
    () => GetParkingsUseCase(
      ParkingRepoImp(
        GetParkingRemoteDataSource(
          DioConsumer(
            dio: Dio(),
          ),
        ),
      ),
    ),
  );
}
