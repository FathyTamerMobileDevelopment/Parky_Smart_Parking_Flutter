import 'package:parky/core/errors/api/dio_error_handler_factory.dart';
import 'package:parky/core/errors/failures.dart';

class ErrorHandler {
  Failure handle(Exception exception) {
    // Get either dio error handler factory or firebase error handler factory
    final factory = ErrorHandlerFactory.getFactory(exception);

    // Get the instance of the error handler
    final handler = factory.getInstance(exception);

    // Handle the exception
    final failure = handler.handle(exception);

    // Return the failure
    return failure;
  }
}

// This class is used as abstract factory
abstract class ErrorHandlerFactoryInterface {
  ErrorHandler getInstance(Exception exception);
}

/// This class is responsible for returning instance
/// from the right error handler factory (abstract factory)
class ErrorHandlerFactory {
  static ErrorHandlerFactoryInterface getFactory(Exception exception) {
    // if (exception is DioException) {
    return DioErrorHandlerFactory();
    // }
    // return FirebaseErrorHandlerFactory();
  }
}
