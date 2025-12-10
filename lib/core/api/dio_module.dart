import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_endpoints.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio dio(SharedPreferences sharedPreferences) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: ApiEndpoints.connectTimeout,
        receiveTimeout: ApiEndpoints.receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = sharedPreferences.getString('auth_token');
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          // Add global error handling here if needed (e.g., logout on 401)
          if (e.response?.statusCode == 401) {
            // Handle unauthorized (maybe clear token)
          }
          return handler.next(e);
        },
      ),
    );

    return dio;
  }
}
