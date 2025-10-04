import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../core/result/result.dart';

abstract class BaseRepository {
  Future<Result<T>> guard<T>(Future<T> Function() task) async {
    try {
      final data = await task();
      return Success<T>(data);
    } on AppException catch (error) {
      return FailureResult<T>(_mapAppException(error));
    } catch (error) {
      return FailureResult<T>(UnknownFailure(error.toString(), cause: error));
    }
  }

  Failure _mapAppException(AppException exception) {
    if (exception is NetworkException) {
      return NetworkFailure(exception.message, cause: exception);
    }
    if (exception is ServerException) {
      return ServerFailure(
        exception.message,
        statusCode: exception.statusCode,
        cause: exception,
      );
    }
    if (exception is CacheException) {
      return CacheFailure(exception.message, cause: exception);
    }
    if (exception is AuthenticationException) {
      return AuthenticationFailure(exception.message, cause: exception);
    }
    if (exception is ValidationException) {
      return ValidationFailure(exception.message, cause: exception);
    }
    return UnknownFailure(exception.message, cause: exception);
  }
}
