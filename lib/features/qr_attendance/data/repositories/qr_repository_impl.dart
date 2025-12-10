import 'package:injectable/injectable.dart';
import '../../domain/entities/qr_code_entity.dart';
import '../../domain/repositories/qr_repository.dart';
import '../datasources/qr_remote_data_source.dart';

@LazySingleton(as: QrRepository)
class QrRepositoryImpl implements QrRepository {
  final QrRemoteDataSource _remoteDataSource;

  QrRepositoryImpl(this._remoteDataSource);

  @override
  Future<QrCodeEntity> generateQr(String lectureId, int durationSeconds) async {
    return await _remoteDataSource.generateQr(lectureId, durationSeconds);
  }

  @override
  Future<Map<String, dynamic>> getStatistics(String lectureId) async {
    return await _remoteDataSource.getAttendanceStats(lectureId);
  }
}
