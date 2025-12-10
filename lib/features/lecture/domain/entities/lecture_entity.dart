import 'package:equatable/equatable.dart';

class LectureEntity extends Equatable {
  final String id;
  final String courseId;
  final String lectureDate; // YYYY-MM-DD
  final String startTime; // HH:mm:ss
  final String endTime; // HH:mm:ss
  final String room;

  const LectureEntity({
    required this.id,
    required this.courseId,
    required this.lectureDate,
    required this.startTime,
    required this.endTime,
    required this.room,
  });

  @override
  List<Object?> get props => [
    id,
    courseId,
    lectureDate,
    startTime,
    endTime,
    room,
  ];
}
