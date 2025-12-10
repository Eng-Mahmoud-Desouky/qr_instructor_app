import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api/api_endpoints.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<String> login(String username, String password);
  Future<UserModel> getProfile();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<String> login(String username, String password) async {
    final response = await _dio.post(
      ApiEndpoints.login,
      data: {'username': username, 'password': password},
    );
    debugPrint('AuthRemoteDataSource: Response status: ${response.statusCode}');
    debugPrint(
      'AuthRemoteDataSource: Response data runtimeType: ${response.data.runtimeType}',
    );

    // Direct dynamic access to avoid type checking pitfalls
    final dynamic data = response.data;

    try {
      if (data is Map) {
        if (data.containsKey('access_token')) {
          debugPrint('AuthRemoteDataSource: Found access_token in Map.');
          return data['access_token'].toString();
        }
        if (data.containsKey('token')) {
          debugPrint('AuthRemoteDataSource: Found token in Map.');
          return data['token'].toString();
        }
      }

      // Fallback
      debugPrint(
        'AuthRemoteDataSource: Returning distinct string representation.',
      );
      return data.toString();
    } catch (e, s) {
      debugPrint('AuthRemoteDataSource: Error parsing token: $e\n$s');
      rethrow;
    }
  }

  @override
  Future<UserModel> getProfile() async {
    final response = await _dio.get(ApiEndpoints.myProfile);
    return UserModel.fromJson(response.data);
  }
}
