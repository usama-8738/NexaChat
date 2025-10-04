sealed class AppException implements Exception {
  const AppException(this.message, {this.stackTrace});

  final String message;
  final StackTrace? stackTrace;

  @override
  String toString() => '$runtimeType: $message';
}

class NetworkException extends AppException {
  const NetworkException(super.message, {super.stackTrace});
}

class ServerException extends AppException {
  const ServerException(super.message, {super.stackTrace, this.statusCode});

  final int? statusCode;
}

class CacheException extends AppException {
  const CacheException(super.message, {super.stackTrace});
}

class AuthenticationException extends AppException {
  const AuthenticationException(super.message, {super.stackTrace});
}

class ValidationException extends AppException {
  const ValidationException(super.message, {super.stackTrace});
}
