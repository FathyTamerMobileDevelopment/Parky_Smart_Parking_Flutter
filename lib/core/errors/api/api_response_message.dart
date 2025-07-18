import 'package:get/get.dart';
import 'package:parky/config/themes/text_manager.dart';

/// A class containing static constants for common API response messages.
abstract class APIResponseMessages {
  /// Success messages
  // success with data
  static String success = TextManager.success.tr;

  // success with no data
  static String noContent = TextManager.noContent.tr;

  /// Failure messages
  // failure, API rejected request
  static String badRequest = TextManager.badRequest.tr;

  // failure, user is not authorized
  static String unauthorized = TextManager.unauthorized.tr;

  // failure, API rejected request
  static String forbidden = TextManager.forbidden.tr;

  // failure, API rejected request
  static String notFound = TextManager.notFound.tr;
  static String conflict = TextManager.conflict.tr;
  static String methodNotAllowed = TextManager.methodNotAllowed.tr;

  // failure, crash in server side
  static String internalServerError = TextManager.internalServerError.tr;

  // Local status code messages
  static String connectTimeout = TextManager.connectTimeout.tr;
  static String cancel = TextManager.cancelMessage.tr;
  static String receiveTimeout = TextManager.receiveTimeout.tr;
  static String sendTimeout = TextManager.sendTimeout.tr;
  static String cashError = TextManager.cashError.tr;
  static String noInternetConnection = TextManager.noInternetConnection.tr;
  static String unknown = TextManager.unknown.tr;
}
