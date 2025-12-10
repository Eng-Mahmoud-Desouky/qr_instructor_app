import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/qr_code_entity.dart';

part 'qr_code_model.g.dart';

@JsonSerializable()
class QrCodeModel extends QrCodeEntity {
  @JsonKey(name: 'qrCodeId')
  final String id;
  final String uuidTokenHash;
  final DateTime expiresAt;
  final bool activated;

  const QrCodeModel({
    required this.id,
    required this.uuidTokenHash,
    required this.expiresAt,
    required this.activated,
  }) : super(
         id: id,
         uuidTokenHash: uuidTokenHash,
         expiresAt: expiresAt,
         activated: activated,
       );

  factory QrCodeModel.fromJson(Map<String, dynamic> json) =>
      _$QrCodeModelFromJson(json);
  Map<String, dynamic> toJson() => _$QrCodeModelToJson(this);
}
