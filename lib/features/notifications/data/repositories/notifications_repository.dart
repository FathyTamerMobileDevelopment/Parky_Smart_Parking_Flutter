import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:parky/core/errors/exception.dart';
import 'package:parky/core/errors/failures.dart';

import '../../../../core/api/dio_consumer.dart';
import '../../../../core/utils/functions/kprint.dart';
import '../models/notification_model.dart';

class NotificationsRepository {
  final DioConsumer _dioConsumer = DioConsumer(dio: Dio());
  Future<Either<Failure, List<NotificationModel>>> getNotifications() async {
    try {
      final response = await _dioConsumer.get(
        path: '/api/notifications/',
      );

      return Right(
        List<NotificationModel>.from(
          response.map(
            (x) => NotificationModel.fromJson(x),
          ),
        ),
      );
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: "There was an error",
        code: e.errorMessageModel.statusCode?.toInt() ?? 0,
      ));
    } on Exception catch (e) {
      kprint("Error: ${e.toString()}");
      return const Left(ServerFailure(message: "There was an error "));
    }
  }
}
