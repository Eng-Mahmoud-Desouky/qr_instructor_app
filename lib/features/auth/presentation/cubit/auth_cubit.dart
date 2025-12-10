import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_state.dart';

@Singleton()
class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase _loginUseCase;
  final AuthRepository _authRepository;

  AuthCubit(this._loginUseCase, this._authRepository) : super(AuthInitial());

  Future<void> checkAuth() async {
    final isLoggedIn = await _authRepository.checkAuthStatus();
    if (isLoggedIn) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> login(String username, String password) async {
    debugPrint('AuthCubit (Hash: $hashCode): Login called for $username');
    if (isClosed) {
      debugPrint('AuthCubit (Hash: $hashCode): Cubit is closed!');
      return;
    }
    emit(AuthLoading());
    debugPrint('AuthCubit (Hash: $hashCode): Emitted AuthLoading');
    try {
      debugPrint('AuthCubit (Hash: $hashCode): Calling loginUseCase');
      await _loginUseCase(username, password);
      debugPrint(
        'AuthCubit (Hash: $hashCode): Login success, emitting Authenticated',
      );
      emit(AuthAuthenticated());
    } catch (e, stack) {
      debugPrint('AuthCubit (Hash: $hashCode): Login error: $e\n$stack');
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    emit(AuthUnauthenticated());
  }
}
