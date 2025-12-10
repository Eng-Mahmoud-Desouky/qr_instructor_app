part of 'qr_cubit.dart';

abstract class QrState extends Equatable {
  const QrState();
  @override
  List<Object> get props => [];
}

class QrInitial extends QrState {}

class QrLoading extends QrState {}

class QrGenerated extends QrState {
  final QrCodeEntity qrCode;
  final Map<String, dynamic>? stats;
  const QrGenerated(this.qrCode, {this.stats});
  @override
  List<Object> get props => [qrCode, if (stats != null) stats!];
}

class QrStatsLoaded extends QrState {
  final Map<String, dynamic> stats;
  const QrStatsLoaded(this.stats);
  @override
  List<Object> get props => [stats];
}

class QrError extends QrState {
  final String message;
  const QrError(this.message);
  @override
  List<Object> get props => [message];
}
