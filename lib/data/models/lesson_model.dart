class LessonMaterialModel {
  final int id;
  final String title;
  final String fileType;
  final String? fileSize;
  final String downloadUrl;

  LessonMaterialModel({
    required this.id,
    required this.title,
    required this.fileType,
    this.fileSize,
    required this.downloadUrl,
  });

  factory LessonMaterialModel.fromJson(Map<String, dynamic> json) {
    return LessonMaterialModel(
      id: json['id'] as int,
      title: json['title'] as String,
      fileType: json['file_type'] as String? ?? 'pdf',
      fileSize: json['file_size'] as String? ?? '1.2 MB',
      downloadUrl: json['download_url'] as String? ?? '',
    );
  }
}

class LessonModel {
  final int id;
  final int sectionId;
  final String title;
  final String? videoUrl;
  final int durationMinutes;
  final bool isPreview;
  final String? description;
  final List<LessonMaterialModel> materials;
  bool isCompleted;
  int videoPositionSeconds;

  LessonModel({
    required this.id,
    required this.sectionId,
    required this.title,
    this.videoUrl,
    this.durationMinutes = 10,
    this.isPreview = false,
    this.description,
    this.materials = const [],
    this.isCompleted = false,
    this.videoPositionSeconds = 0,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'] as int,
      sectionId: json['section_id'] as int? ?? 1,
      title: json['title'] as String,
      videoUrl: json['video_url'] as String?,
      durationMinutes: json['duration_minutes'] as int? ?? 10,
      isPreview: json['is_preview'] as bool? ?? false,
      description: json['description'] as String?,
      materials: (json['materials'] as List<dynamic>?)
              ?.map((m) => LessonMaterialModel.fromJson(m as Map<String, dynamic>))
              .toList() ??
          [],
      isCompleted: json['is_completed'] as bool? ?? false,
      videoPositionSeconds: json['video_position_seconds'] as int? ?? 0,
    );
  }
}
