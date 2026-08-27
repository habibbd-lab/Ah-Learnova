import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/course_model.dart';
import '../../data/models/category_model.dart';
import '../../data/repositories/course_repository.dart';

class HomeController extends GetxController {
  final CourseRepository _courseRepo = CourseRepository();

  final RxList<CourseModel> featuredCourses = <CourseModel>[].obs;
  final RxList<CourseModel> bestsellerCourses = <CourseModel>[].obs;
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxBool isLoading = false.obs;

  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadHomeData();
  }

  void loadHomeData() {
    isLoading.value = true;
    featuredCourses.assignAll(_courseRepo.getFeaturedCourses());
    bestsellerCourses.assignAll(_courseRepo.getBestsellerCourses());
    categories.assignAll(_courseRepo.getCategories());
    isLoading.value = false;
  }

  void toggleWishlist(int courseId) {
    _courseRepo.toggleWishlist(courseId);
    loadHomeData();
  }
}
