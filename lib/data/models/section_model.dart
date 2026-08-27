import 'lesson_model.dart';

class SectionModel {
  final int id;
  final int courseId;
  final String title;
  final int sortOrder;
  final List<LessonModel> lessons;

  SectionModel({
    required this.id,
    required this.courseId,
    required this.title,
    this.sortOrder = 1,
    this.lessons = const [],
  });

  int get totalMinutes => lessons.fold(0, (sum, l) => sum + l.durationMinutes);

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      id: json['id'] as int,
      courseId: json['course_id'] as int? ?? 1,
      title: json['title'] as String,
      sortOrder: json['sort_order'] as int? ?? 1,
      lessons: (json['lessons'] as List<dynamic>?)
              ?.map((l) => LessonModel.fromJson(l as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
