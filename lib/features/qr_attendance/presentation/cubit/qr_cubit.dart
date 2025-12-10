import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/qr_code_entity.dart';
import '../../domain/usecases/qr_usecases.dart';

part 'qr_state.dart';

@injectable
class QrCubit extends Cubit<QrState> {
  final GenerateQrUseCase _generateQrUseCase;
  final GetAttendanceStatsUseCase _getAttendanceStatsUseCase;

  QrCubit(this._generateQrUseCase, this._getAttendanceStatsUseCase)
    : super(QrInitial());

  Future<void> generateQr(String lectureId, int duration) async {
    emit(QrLoading());
    try {
      final qrEntity = await _generateQrUseCase(lectureId, duration);
      emit(QrGenerated(qrEntity));
      // Start polling stats?
      // For now, simpler: UI triggers polling or refresh.
    } catch (e) {
      emit(QrError(e.toString()));
    }
  }

  Future<void> fetchStats(String lectureId) async {
    if (state is QrGenerated) {
      final currentQr = (state as QrGenerated).qrCode;
      try {
        final stats = await _getAttendanceStatsUseCase(lectureId);
        emit(QrGenerated(currentQr, stats: stats));
      } catch (e) {
        // Keep current state but maybe show error?
        // For now, just logging or ignoring to not disrupt UI
        debugPrint('QrCubit: Error fetching stats: $e');
      }
    }
  }
}
