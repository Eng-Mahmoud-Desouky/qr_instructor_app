import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api/api_endpoints.dart';
import '../models/qr_code_model.dart';

abstract class QrRemoteDataSource {
  Future<QrCodeModel> generateQr(String lectureId, int durationSeconds);
  Future<Map<String, dynamic>> getAttendanceStats(String lectureId);
}

@LazySingleton(as: QrRemoteDataSource)
class QrRemoteDataSourceImpl implements QrRemoteDataSource {
  final Dio _dio;

  QrRemoteDataSourceImpl(this._dio);

  @override
  Future<QrCodeModel> generateQr(String lectureId, int durationSeconds) async {
    // Need network info (IP/SSID), but for web we might send placeholder or IP if available
    // Spec requires networkInfo.
    final response = await _dio.post(
      ApiEndpoints.generateQr,
      data: {
        'lectureId': lectureId,
        'durationSeconds': durationSeconds,
        'networkInfo': 'WEB_DASHBOARD',
      },
    );
    return QrCodeModel.fromJson(response.data);
  }

  @override
  Future<Map<String, dynamic>> getAttendanceStats(String lectureId) async {
    final response = await _dio.get(
      ApiEndpoints.getStatistics,
      queryParameters: {'lectureId': lectureId},
    );
    return response.data;
  }
}
