import 'category_model.dart';
import 'section_model.dart';
import 'quiz_model.dart';
import 'assignment_model.dart';
import 'review_model.dart';
import 'user_model.dart';

class CourseModel {
  final int id;
  final String title;
  final String slug;
  final String? subtitle;
  final String description;
  final int categoryId;
  final CategoryModel? category;
  final int instructorId;
  final UserModel? instructor;
  final double price;
  final double? discountPrice;
  final String level; // beginner, intermediate, advanced, all_levels
  final String language;
  final String? thumbnail;
  final String? previewVideoUrl;
  final String status; // draft, pending, published, rejected
  final bool isFeatured;
  final bool isBestseller;
  final double averageRating;
  final int reviewsCount;
  final int studentsCount;
  final int totalDurationMinutes;
  final List<String> whatWillLearn;
  final List<String> requirements;
  final List<SectionModel> sections;
  final List<QuizModel> quizzes;
  final List<AssignmentModel> assignments;
  final List<ReviewModel> reviews;
  bool isWishlisted;
  bool isEnrolled;
  double progressPercentage;

  CourseModel({
    required this.id,
    required this.title,
    required this.slug,
    this.subtitle,
    required this.description,
    required this.categoryId,
    this.category,
    required this.instructorId,
    this.instructor,
    required this.price,
    this.discountPrice,
    this.level = 'all_levels',
    this.language = 'English',
    this.thumbnail,
    this.previewVideoUrl,
    this.status = 'published',
    this.isFeatured = false,
    this.isBestseller = false,
    this.averageRating = 5.0,
    this.reviewsCount = 0,
    this.studentsCount = 0,
    this.totalDurationMinutes = 120,
    this.whatWillLearn = const [],
    this.requirements = const [],
    this.sections = const [],
    this.quizzes = const [],
    this.assignments = const [],
    this.reviews = const [],
    this.isWishlisted = false,
    this.isEnrolled = false,
    this.progressPercentage = 0.0,
  });

  double get effectivePrice => (discountPrice != null && discountPrice! > 0 && discountPrice! < price)
      ? discountPrice!
      : price;

  bool get isFree => price == 0.0 || effectivePrice == 0.0;

  int get totalLessonsCount => sections.fold(0, (sum, sec) => sum + sec.lessons.length);

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] as int,
      title: json['title'] as String,
      slug: json['slug'] as String,
      subtitle: json['subtitle'] as String?,
      description: json['description'] as String? ?? '',
      categoryId: json['category_id'] as int? ?? 1,
      category: json['category'] != null ? CategoryModel.fromJson(json['category'] as Map<String, dynamic>) : null,
      instructorId: json['instructor_id'] as int? ?? 1,
      instructor: json['instructor'] != null ? UserModel.fromJson(json['instructor'] as Map<String, dynamic>) : null,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discountPrice: (json['discount_price'] as num?)?.toDouble(),
      level: json['level'] as String? ?? 'all_levels',
      language: json['language'] as String? ?? 'English',
      thumbnail: json['thumbnail'] as String?,
      previewVideoUrl: json['preview_video_url'] as String?,
      status: json['status'] as String? ?? 'published',
      isFeatured: json['is_featured'] as bool? ?? false,
      isBestseller: json['is_bestseller'] as bool? ?? false,
      averageRating: (json['average_rating'] as num?)?.toDouble() ?? 5.0,
      reviewsCount: json['reviews_count'] as int? ?? 0,
      studentsCount: json['students_count'] as int? ?? 0,
      totalDurationMinutes: json['total_duration_minutes'] as int? ?? 120,
      whatWillLearn: (json['what_will_learn'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      requirements: (json['requirements'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      sections: (json['sections'] as List<dynamic>?)?.map((s) => SectionModel.fromJson(s as Map<String, dynamic>)).toList() ?? [],
      quizzes: (json['quizzes'] as List<dynamic>?)?.map((q) => QuizModel.fromJson(q as Map<String, dynamic>)).toList() ?? [],
      assignments: (json['assignments'] as List<dynamic>?)?.map((a) => AssignmentModel.fromJson(a as Map<String, dynamic>)).toList() ?? [],
      reviews: (json['reviews'] as List<dynamic>?)?.map((r) => ReviewModel.fromJson(r as Map<String, dynamic>)).toList() ?? [],
      isWishlisted: json['is_wishlisted'] as bool? ?? false,
      isEnrolled: json['is_enrolled'] as bool? ?? false,
      progressPercentage: (json['progress_percentage'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
