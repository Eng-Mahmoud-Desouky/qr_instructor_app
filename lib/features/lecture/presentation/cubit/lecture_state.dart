part of 'lecture_cubit.dart';

abstract class LectureState extends Equatable {
  const LectureState();
  @override
  List<Object> get props => [];
}

class LectureInitial extends LectureState {}

class LectureLoading extends LectureState {}

class LectureLoaded extends LectureState {
  final List<LectureEntity> lectures;
  const LectureLoaded(this.lectures);
  @override
  List<Object> get props => [lectures];
}

class LectureError extends LectureState {
  final String message;
  const LectureError(this.message);
  @override
  List<Object> get props => [message];
}
