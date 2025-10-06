import '../repositories/auth_repository.dart';

class VerifyCode {
  const VerifyCode(this._repository);

  final AuthRepository _repository;

  Future<void> call({required String code, required bool isPhoneFlow}) {
    return _repository.verifyCode(code: code, isPhoneFlow: isPhoneFlow);
  }
}
