// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_code_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QrCodeModel _$QrCodeModelFromJson(Map<String, dynamic> json) => QrCodeModel(
  id: json['qrCodeId'] as String,
  uuidTokenHash: json['uuidTokenHash'] as String,
  expiresAt: DateTime.parse(json['expiresAt'] as String),
  activated: json['activated'] as bool,
);

Map<String, dynamic> _$QrCodeModelToJson(QrCodeModel instance) =>
    <String, dynamic>{
      'qrCodeId': instance.id,
      'uuidTokenHash': instance.uuidTokenHash,
      'expiresAt': instance.expiresAt.toIso8601String(),
      'activated': instance.activated,
    };
