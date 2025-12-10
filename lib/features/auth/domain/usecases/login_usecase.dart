import 'package:injectable/injectable.dart';
import '../../domain/repositories/auth_repository.dart';

@lazySingleton
class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<void> call(String username, String password) {
    return _repository.login(username, password);
  }
}
