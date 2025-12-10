import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection_container.dart';
import '../../domain/entities/course_entity.dart';
import '../cubit/course_cubit.dart';

class CourseListScreen extends StatelessWidget {
  const CourseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CourseCubit>()..loadCourses(),
      child: Scaffold(
        appBar: AppBar(title: const Text('My Courses')),
        body: BlocBuilder<CourseCubit, CourseState>(
          builder: (context, state) {
            if (state is CourseLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CourseError) {
              return Center(child: Text(state.message));
            } else if (state is CourseLoaded) {
              if (state.courses.isEmpty) {
                return const Center(child: Text('No courses found.'));
              }
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: state.courses.length,
                itemBuilder: (context, index) {
                  return _CourseCard(course: state.courses[index]);
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  final CourseEntity course;

  const _CourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {
          // Navigate to Lecture Management for this course
          context.go('/dashboard/courses/${course.id}/lectures');
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course.code,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                course.name,
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              const Divider(),
              Text(
                'View Lectures',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
