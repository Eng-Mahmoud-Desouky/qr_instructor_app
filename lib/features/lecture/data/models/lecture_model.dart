import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/lecture_entity.dart';

part 'lecture_model.g.dart';

@JsonSerializable()
class LectureModel extends LectureEntity {
  @JsonKey(name: 'lectureId')
  final String id;
  final String courseId;
  final String lectureDate;

  // Custom parsing might be needed if backend returns object for Time
  // Spec says: "startTime":{"hour":10,"minute":0,"second":0,"nano":0}
  // We need a complex converter or simple manual check.
  // For now assuming the generated part works or I use a converter.
  // Actually, I'll use `fromJson` logic if needed.
  @JsonKey(fromJson: timeFromJson, toJson: timeToJson)
  final String startTime;

  @JsonKey(fromJson: timeFromJson, toJson: timeToJson)
  final String endTime;

  final String room;

  const LectureModel({
    required this.id,
    required this.courseId,
    required this.lectureDate,
    required this.startTime,
    required this.endTime,
    required this.room,
  }) : super(
         id: id,
         courseId: courseId,
         lectureDate: lectureDate,
         startTime: startTime,
         endTime: endTime,
         room: room,
       );

  factory LectureModel.fromJson(Map<String, dynamic> json) =>
      _$LectureModelFromJson(json);
  Map<String, dynamic> toJson() => _$LectureModelToJson(this);

  static String timeFromJson(Map<String, dynamic> json) {
    // Convert {hour: 10, minute: 30...} to "10:30"
    final h = json['hour'].toString().padLeft(2, '0');
    final m = json['minute'].toString().padLeft(2, '0');
    return '$h:$m';
  }

  static Map<String, dynamic> timeToJson(String time) {
    // Convert "10:30" to {hour: 10, minute: 30}
    final parts = time.split(':');
    return {
      'hour': int.parse(parts[0]),
      'minute': int.parse(parts[1]),
      'second': 0,
      'nano': 0,
    };
  }
}
