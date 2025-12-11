import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_instructor_app/core/di/injection_container.dart';
import '../../domain/entities/lecture_entity.dart';
import '../cubit/lecture_cubit.dart';

class LectureListScreen extends StatelessWidget {
  final String courseId;

  const LectureListScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LectureCubit>()..loadLectures(courseId),
      child: Scaffold(
        appBar: AppBar(title: const Text('Lectures')),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              onPressed: () => _showAddLectureDialog(context, courseId),
              child: const Icon(Icons.add),
            );
          },
        ),
        body: BlocBuilder<LectureCubit, LectureState>(
          builder: (context, state) {
            if (state is LectureLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LectureError) {
              return Center(child: Text(state.message));
            } else if (state is LectureLoaded) {
              if (state.lectures.isEmpty) {
                return const Center(child: Text('No lectures found.'));
              }
              return ListView.builder(
                itemCount: state.lectures.length,
                itemBuilder: (context, index) {
                  final lecture = state.lectures[index];
                  return ListTile(
                    title: Text('Room: ${lecture.room}'),
                    subtitle: Text(
                      '${lecture.lectureDate} | ${lecture.startTime} - ${lecture.endTime}',
                    ),
                    trailing: Icon(Icons.qr_code),
                    onTap: () {
                      // Navigate to QR Generation for this lecture
                      context.go('/dashboard/lectures/${lecture.id}/qr');
                    },
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  void _showAddLectureDialog(BuildContext context, String courseId) {
    final formKey = GlobalKey<FormState>();
    final roomController = TextEditingController();
    DateTime? selectedDate;
    TimeOfDay? startTime;
    TimeOfDay? endTime;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (sbContext, setState) {
            return AlertDialog(
              title: const Text('Add Lecture'),
              content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: roomController,
                      decoration: const InputDecoration(labelText: 'Room'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a room';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      title: Text(
                        selectedDate == null
                            ? 'Select Date'
                            : 'Date: ${selectedDate!.toString().split(' ')[0]}',
                      ),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: sbContext,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          setState(() => selectedDate = picked);
                        }
                      },
                    ),
                    ListTile(
                      title: Text(
                        startTime == null
                            ? 'Select Start Time'
                            : 'Start: ${startTime!.format(sbContext)}',
                      ),
                      trailing: const Icon(Icons.access_time),
                      onTap: () async {
                        final picked = await showTimePicker(
                          context: sbContext,
                          initialTime: TimeOfDay.now(),
                        );
                        if (picked != null) {
                          setState(() => startTime = picked);
                        }
                      },
                    ),
                    ListTile(
                      title: Text(
                        endTime == null
                            ? 'Select End Time'
                            : 'End: ${endTime!.format(sbContext)}',
                      ),
                      trailing: const Icon(Icons.access_time),
                      onTap: () async {
                        final picked = await showTimePicker(
                          context: sbContext,
                          initialTime: TimeOfDay.now(),
                        );
                        if (picked != null) {
                          setState(() => endTime = picked);
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(sbContext),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate() &&
                        selectedDate != null &&
                        startTime != null &&
                        endTime != null) {
                      // Format date and times as strings for API/Entity
                      // Entity expects String for times "HH:mm" usually?
                      // Let's verify LectureEntity types.
                      // Assuming String for now based on previous knowledge or simple mapping.

                      final dateStr = selectedDate!.toIso8601String().split(
                        'T',
                      )[0];

                      // Helper to format TimeOfDay
                      String formatTime(TimeOfDay t) {
                        final hour = t.hour.toString().padLeft(2, '0');
                        final minute = t.minute.toString().padLeft(2, '0');
                        return '$hour:$minute';
                      }

                      final newLecture = LectureEntity(
                        id: '', // Will be assigned by backend
                        courseId: courseId,
                        lectureDate: dateStr,
                        startTime: formatTime(startTime!),
                        endTime: formatTime(endTime!),
                        room: roomController.text,
                      );

                      // Use the context from the outer scope (LectureListScreen) via the closure
                      // BUT we are in a dialog which has its own context.
                      // We need to access the Provider from the PARENT context.
                      // 'context' here is StatefulBuilder context.
                      // 'dialogContext' is the headers context.
                      // 'context' passed to _showAddLectureDialog is the one with Provider.

                      // Ensure we are using the context that contains the BlocProvider
                      // calling logic might need to be outside or use the captured 'context' arg.

                      context.read<LectureCubit>().createLecture(newLecture);
                      Navigator.pop(sbContext);
                    } else {
                      ScaffoldMessenger.of(sbContext).showSnackBar(
                        const SnackBar(content: Text('Please fill all fields')),
                      );
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
