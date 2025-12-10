import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final SharedPreferences _sharedPreferences;

  AuthRepositoryImpl(this._remoteDataSource, this._sharedPreferences);

  @override
  Future<void> login(String username, String password) async {
    debugPrint('AuthRepositoryImpl: Calling remote login');
    try {
      final token = await _remoteDataSource.login(username, password);
      debugPrint(
        'AuthRepositoryImpl: Token received (len: ${token.length}). Saving to SharedPreferences...',
      );
      await _sharedPreferences.setString('auth_token', token);
      debugPrint('AuthRepositoryImpl: Token saved successfully.');
    } catch (e, s) {
      debugPrint('AuthRepositoryImpl: Error in login: $e\n$s');
      rethrow;
    }
  }

  @override
  Future<UserEntity> getProfile() async {
    return await _remoteDataSource.getProfile();
  }

  @override
  Future<void> logout() async {
    await _sharedPreferences.remove('auth_token');
  }

  @override
  Future<bool> checkAuthStatus() async {
    final token = _sharedPreferences.getString('auth_token');
    if (token == null || token.isEmpty) return false;
    // Optionally verify token validity with API
    try {
      await _remoteDataSource.getProfile();
      return true;
    } catch (_) {
      return false;
    }
  }
}
