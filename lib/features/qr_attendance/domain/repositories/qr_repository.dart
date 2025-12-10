import '../../domain/entities/qr_code_entity.dart';

abstract class QrRepository {
  Future<QrCodeEntity> generateQr(String lectureId, int durationSeconds);
  Future<Map<String, dynamic>> getStatistics(String lectureId);
}
