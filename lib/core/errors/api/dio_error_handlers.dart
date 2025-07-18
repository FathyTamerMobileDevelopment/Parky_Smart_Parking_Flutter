import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:parky/core/errors/api/api_response_codes.dart';
import 'package:parky/core/errors/api/api_response_message.dart';
import 'package:parky/core/errors/error_handler.dart';
import 'package:parky/core/errors/failures.dart';
import 'package:parky/config/themes/text_manager.dart';

class BadResponseErrorHandler implements ErrorHandler {
  @override
  Failure handle(Exception exception) {
    final response = (exception as DioException).response?.data;
    final code = response['code'];
    final data = response['data'];
    final message = response['message'];

    if (code == null) {
      return ServerFailure(
        message: APIResponseMessages.unknown,
        code: APIResponseCodes.unknown,
      );
    }

    switch (code) {
      // Client errors
      case APIResponseCodes.badRequest:
        return ServerFailure(
          code: APIResponseCodes.badRequest,
          message: message ?? APIResponseMessages.badRequest,
        );
      case APIResponseCodes.unprocessableEntity:
        // Handle different unauthorized cases
        String message = APIResponseMessages.unknown;

        // Register errors
        if (data['phone'] != null) {
          message = TextManager.phoneAlreadyExists.tr;
        }

        return ServerFailure(
          code: APIResponseCodes.unprocessableEntity,
          message: message,
        );
      case APIResponseCodes.conflict:
        return ServerFailure(
          code: APIResponseCodes.conflict,
          message: APIResponseMessages.conflict,
        );
      case APIResponseCodes.methodNotAllowed:
        return ServerFailure(
          code: APIResponseCodes.methodNotAllowed,
          message: APIResponseMessages.conflict,
        );
      case APIResponseCodes.unauthorized:
        return ServerFailure(
          code: APIResponseCodes.unauthorized,
          message: message ?? APIResponseMessages.unauthorized.tr,
        );
      case APIResponseCodes.forbidden:
        String message = APIResponseMessages.forbidden;

        return ServerFailure(
          code: APIResponseCodes.forbidden,
          message: message,
        );
      case APIResponseCodes.notFound:
        return ServerFailure(
          code: APIResponseCodes.notFound,
          message: APIResponseMessages.notFound,
        );

      // Server error
      case APIResponseCodes.internalServerError:
        return ServerFailure(
          code: APIResponseCodes.internalServerError,
          message: APIResponseMessages.internalServerError,
        );

      // Default case for unknown status codes
      default:
        return ServerFailure(
          code: APIResponseCodes.unknown,
          message: APIResponseMessages.unknown,
        );
    }
  }
}

class ConnectionTimeOutErrorHandler implements ErrorHandler {
  @override
  Failure handle(Exception exception) {
    return ServerFailure(
      code: APIResponseCodes.connectTimeout,
      message: APIResponseMessages.connectTimeout,
    );
  }
}

class SendTimeOutErrorHandler implements ErrorHandler {
  @override
  Failure handle(Exception exception) {
    return ServerFailure(
      code: APIResponseCodes.sendTimeout,
      message: APIResponseMessages.sendTimeout,
    );
  }
}

class ReceiveTimeOutErrorHandler implements ErrorHandler {
  @override
  Failure handle(Exception exception) {
    return ServerFailure(
      code: APIResponseCodes.receiveTimeout,
      message: APIResponseMessages.receiveTimeout,
    );
  }
}

class CancelErrorHandler implements ErrorHandler {
  @override
  Failure handle(Exception exception) {
    return ServerFailure(
      code: APIResponseCodes.cancel,
      message: APIResponseMessages.cancel,
    );
  }
}

class BadCertificateErrorHandler implements ErrorHandler {
  @override
  Failure handle(Exception exception) {
    return ServerFailure(
      code: APIResponseCodes.badRequest,
      message: APIResponseMessages.badRequest,
    );
  }
}

class ConnectionErrorHandler implements ErrorHandler {
  @override
  Failure handle(Exception exception) {
    return ServerFailure(
      code: APIResponseCodes.connectTimeout,
      message: APIResponseMessages.connectTimeout,
    );
  }
}

class UnknownErrorHandler implements ErrorHandler {
  @override
  Failure handle(Exception exception) {
    return ServerFailure(
      code: APIResponseCodes.unknown,
      message: APIResponseMessages.unknown,
    );
  }
}
