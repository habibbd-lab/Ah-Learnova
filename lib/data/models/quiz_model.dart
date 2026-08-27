class QuizOptionModel {
  final int id;
  final String optionText;
  final bool isCorrect;

  QuizOptionModel({
    required this.id,
    required this.optionText,
    required this.isCorrect,
  });

  factory QuizOptionModel.fromJson(Map<String, dynamic> json) {
    return QuizOptionModel(
      id: json['id'] as int,
      optionText: json['option_text'] as String,
      isCorrect: json['is_correct'] as bool? ?? false,
    );
  }
}

class QuizQuestionModel {
  final int id;
  final String questionText;
  final String type; // multiple_choice, true_false
  final int points;
  final String? explanation;
  final List<QuizOptionModel> options;

  QuizQuestionModel({
    required this.id,
    required this.questionText,
    this.type = 'multiple_choice',
    this.points = 10,
    this.explanation,
    required this.options,
  });

  factory QuizQuestionModel.fromJson(Map<String, dynamic> json) {
    return QuizQuestionModel(
      id: json['id'] as int,
      questionText: json['question_text'] as String,
      type: json['type'] as String? ?? 'multiple_choice',
      points: json['points'] as int? ?? 10,
      explanation: json['explanation'] as String?,
      options: (json['options'] as List<dynamic>?)
              ?.map((o) => QuizOptionModel.fromJson(o as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class QuizModel {
  final int id;
  final int courseId;
  final String title;
  final String? description;
  final int durationMinutes;
  final int passPercentage;
  final List<QuizQuestionModel> questions;

  QuizModel({
    required this.id,
    required this.courseId,
    required this.title,
    this.description,
    this.durationMinutes = 15,
    this.passPercentage = 70,
    this.questions = const [],
  });

  int get totalQuestions => questions.length;
  int get totalPoints => questions.fold(0, (sum, q) => sum + q.points);

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'] as int,
      courseId: json['course_id'] as int? ?? 1,
      title: json['title'] as String,
      description: json['description'] as String?,
      durationMinutes: json['duration_minutes'] as int? ?? 15,
      passPercentage: json['pass_percentage'] as int? ?? 70,
      questions: (json['questions'] as List<dynamic>?)
              ?.map((q) => QuizQuestionModel.fromJson(q as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
