import 'package:injectable/injectable.dart';
import '../../domain/entities/qr_code_entity.dart';
import '../repositories/qr_repository.dart';

@lazySingleton
class GenerateQrUseCase {
  final QrRepository _repository;
  GenerateQrUseCase(this._repository);
  Future<QrCodeEntity> call(String lectureId, int durationSeconds) {
    return _repository.generateQr(lectureId, durationSeconds);
  }
}

@lazySingleton
class GetAttendanceStatsUseCase {
  final QrRepository _repository;
  GetAttendanceStatsUseCase(this._repository);
  Future<Map<String, dynamic>> call(String lectureId) {
    return _repository.getStatistics(lectureId);
  }
}
