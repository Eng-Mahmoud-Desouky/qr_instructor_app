import 'package:equatable/equatable.dart';

class QrCodeEntity extends Equatable {
  final String id;
  final String uuidTokenHash;
  final DateTime expiresAt;
  final bool activated;

  const QrCodeEntity({
    required this.id,
    required this.uuidTokenHash,
    required this.expiresAt,
    required this.activated,
  });

  @override
  List<Object?> get props => [id, uuidTokenHash, expiresAt, activated];
}
