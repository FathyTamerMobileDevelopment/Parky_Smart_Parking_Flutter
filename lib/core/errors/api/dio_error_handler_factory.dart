import 'package:dio/dio.dart';
import 'package:parky/core/errors/api/dio_error_handlers.dart';
import 'package:parky/core/errors/error_handler.dart';

/// This class is responsible for returning instance
/// for the correct dio exception handler based on the type
class DioErrorHandlerFactory implements ErrorHandlerFactoryInterface {
  @override
  ErrorHandler getInstance(Exception exception) {
    switch ((exception as DioException).type) {
      case DioExceptionType.connectionTimeout:
        return ConnectionTimeOutErrorHandler();
      case DioExceptionType.sendTimeout:
        return SendTimeOutErrorHandler();
      case DioExceptionType.receiveTimeout:
        return ReceiveTimeOutErrorHandler();
      case DioExceptionType.badResponse:
        return BadResponseErrorHandler();
      case DioExceptionType.cancel:
        return CancelErrorHandler();
      case DioExceptionType.badCertificate:
        return BadCertificateErrorHandler();
      case DioExceptionType.connectionError:
        return ConnectionErrorHandler();
      case DioExceptionType.unknown:
        return UnknownErrorHandler();
    }
  }
}
