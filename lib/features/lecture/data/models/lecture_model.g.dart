// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecture_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LectureModel _$LectureModelFromJson(Map<String, dynamic> json) => LectureModel(
  id: json['lectureId'] as String,
  courseId: json['courseId'] as String,
  lectureDate: json['lectureDate'] as String,
  startTime: LectureModel.timeFromJson(json['startTime']),
  endTime: LectureModel.timeFromJson(json['endTime']),
  room: json['room'] as String,
);

Map<String, dynamic> _$LectureModelToJson(LectureModel instance) =>
    <String, dynamic>{
      'lectureId': instance.id,
      'courseId': instance.courseId,
      'lectureDate': instance.lectureDate,
      'startTime': LectureModel.timeToJson(instance.startTime),
      'endTime': LectureModel.timeToJson(instance.endTime),
      'room': instance.room,
    };
