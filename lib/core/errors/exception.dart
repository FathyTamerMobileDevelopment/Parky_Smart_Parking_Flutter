import 'error_message_model.dart';

class ServerException implements Exception {
  final ErrorMessageModel errorMessageModel;

  const ServerException({required this.errorMessageModel});
}

class FetchDataException extends ServerException {
  FetchDataException()
      : super(
          errorMessageModel: const ErrorMessageModel(
            message: "Error During Communication",
          ),
        );
}

class BadRequestException extends ServerException {
  BadRequestException({required super.errorMessageModel});
}

class UnauthorizedException extends ServerException {
  UnauthorizedException({required super.errorMessageModel});
}

class NotFoundException extends ServerException {
  NotFoundException({required super.errorMessageModel});
}

class ConflictException extends ServerException {
  ConflictException({required super.errorMessageModel});
}

class InternalServerErrorException extends ServerException {
  InternalServerErrorException({required super.errorMessageModel});
}

class NoInternetConnectionException extends ServerException {
  NoInternetConnectionException()
      : super(
          errorMessageModel: const ErrorMessageModel(
            message: "No Internet Connection",
          ),
        );
}

class CasheException implements Exception {}
