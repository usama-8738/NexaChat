abstract class Failure {
  const Failure(this.message, {this.cause});

  final String message;
  final Object? cause;
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message, {super.cause});
}

class ServerFailure extends Failure {
  const ServerFailure(super.message, {this.statusCode, super.cause});

  final int? statusCode;
}

class CacheFailure extends Failure {
  const CacheFailure(super.message, {super.cause});
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure(super.message, {super.cause});
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message, {super.cause});
}
