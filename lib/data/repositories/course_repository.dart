import '../models/course_model.dart';
import '../models/category_model.dart';
import '../static/static_data.dart';

class CourseRepository {
  List<CourseModel> getCourses() {
    return List.from(StaticData.courses);
  }

  List<CategoryModel> getCategories() {
    return List.from(StaticData.categories);
  }

  List<CourseModel> getFeaturedCourses() {
    return StaticData.courses.where((c) => c.isFeatured).toList();
  }

  List<CourseModel> getBestsellerCourses() {
    return StaticData.courses.where((c) => c.isBestseller).toList();
  }

  List<CourseModel> getWishlistedCourses() {
    return StaticData.courses.where((c) => c.isWishlisted).toList();
  }

  List<CourseModel> getEnrolledCourses() {
    return StaticData.courses.where((c) => c.isEnrolled).toList();
  }

  CourseModel? getCourseBySlug(String slug) {
    try {
      return StaticData.courses.firstWhere((c) => c.slug == slug);
    } catch (_) {
      return StaticData.courses.first;
    }
  }

  void toggleWishlist(int courseId) {
    final index = StaticData.courses.indexWhere((c) => c.id == courseId);
    if (index != -1) {
      StaticData.courses[index].isWishlisted = !StaticData.courses[index].isWishlisted;
    }
  }

  List<CourseModel> searchCourses(String query, {int? categoryId, String? level, String? priceType}) {
    return StaticData.courses.where((c) {
      final matchesQuery = query.isEmpty ||
          c.title.toLowerCase().contains(query.toLowerCase()) ||
          c.description.toLowerCase().contains(query.toLowerCase());
      final matchesCategory = categoryId == null || c.categoryId == categoryId;
      final matchesLevel = level == null || level == 'all' || c.level == level;
      final matchesPrice = priceType == null ||
          priceType == 'all' ||
          (priceType == 'free' ? c.isFree : !c.isFree);
      return matchesQuery && matchesCategory && matchesLevel && matchesPrice;
    }).toList();
  }
}
