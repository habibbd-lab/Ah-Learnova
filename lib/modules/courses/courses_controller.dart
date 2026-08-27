import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/course_model.dart';
import '../../data/models/category_model.dart';
import '../../data/repositories/course_repository.dart';

class CoursesController extends GetxController {
  final CourseRepository _courseRepo = CourseRepository();

  final RxList<CourseModel> filteredCourses = <CourseModel>[].obs;
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;

  final searchController = TextEditingController();
  final RxInt selectedCategoryId = 0.obs;
  final RxString selectedLevel = 'all'.obs;
  final RxString selectedPriceType = 'all'.obs;
  final RxString selectedSortBy = 'popular'.obs;

  @override
  void onInit() {
    super.onInit();
    categories.assignAll(_courseRepo.getCategories());

    if (Get.arguments != null && Get.arguments is Map) {
      final args = Get.arguments as Map;
      if (args['category_id'] != null) {
        selectedCategoryId.value = args['category_id'] as int;
      }
    }

    applyFilters();
  }

  void onSearchChanged(String query) {
    applyFilters();
  }

  void selectCategory(int id) {
    selectedCategoryId.value = id;
    applyFilters();
  }

  void selectLevel(String level) {
    selectedLevel.value = level;
    applyFilters();
  }

  void selectPriceType(String type) {
    selectedPriceType.value = type;
    applyFilters();
  }

  void selectSortBy(String sort) {
    selectedSortBy.value = sort;
    applyFilters();
  }

  void resetFilters() {
    selectedCategoryId.value = 0;
    selectedLevel.value = 'all';
    selectedPriceType.value = 'all';
    selectedSortBy.value = 'popular';
    searchController.clear();
    applyFilters();
  }

  void applyFilters() {
    var result = _courseRepo.searchCourses(
      searchController.text,
      categoryId: selectedCategoryId.value == 0 ? null : selectedCategoryId.value,
      level: selectedLevel.value,
      priceType: selectedPriceType.value,
    );

    // Sorting
    if (selectedSortBy.value == 'price_low') {
      result.sort((a, b) => a.effectivePrice.compareTo(b.effectivePrice));
    } else if (selectedSortBy.value == 'price_high') {
      result.sort((a, b) => b.effectivePrice.compareTo(a.effectivePrice));
    } else if (selectedSortBy.value == 'rating') {
      result.sort((a, b) => b.averageRating.compareTo(a.averageRating));
    } else {
      result.sort((a, b) => b.studentsCount.compareTo(a.studentsCount));
    }

    filteredCourses.assignAll(result);
  }

  void toggleWishlist(int courseId) {
    _courseRepo.toggleWishlist(courseId);
    applyFilters();
  }
}
