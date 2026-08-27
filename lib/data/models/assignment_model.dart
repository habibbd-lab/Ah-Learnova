class AssignmentModel {
  final int id;
  final int courseId;
  final String title;
  final String description;
  final int maxMarks;
  final String? deadline;
  final String? submissionStatus; // not_submitted, submitted, graded
  final int? obtainedMarks;
  final String? feedback;

  AssignmentModel({
    required this.id,
    required this.courseId,
    required this.title,
    required this.description,
    this.maxMarks = 100,
    this.deadline,
    this.submissionStatus = 'not_submitted',
    this.obtainedMarks,
    this.feedback,
  });

  factory AssignmentModel.fromJson(Map<String, dynamic> json) {
    return AssignmentModel(
      id: json['id'] as int,
      courseId: json['course_id'] as int? ?? 1,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      maxMarks: json['max_marks'] as int? ?? 100,
      deadline: json['deadline'] as String?,
      submissionStatus: json['submission_status'] as String? ?? 'not_submitted',
      obtainedMarks: json['obtained_marks'] as int?,
      feedback: json['feedback'] as String?,
    );
  }
}
