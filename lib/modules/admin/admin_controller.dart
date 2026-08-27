import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/course_model.dart';
import '../../data/models/user_model.dart';
import '../../data/static/static_data.dart';

class AdminController extends GetxController {
  final RxList<CourseModel> pendingCourses = <CourseModel>[].obs;
  final RxList<UserModel> users = <UserModel>[].obs;
  final RxDouble grossRevenue = 48500.00.obs;
  final RxDouble platformNetProfit = 4850.00.obs;

  @override
  void onInit() {
    super.onInit();
    loadAdminData();
  }

  void loadAdminData() {
    pendingCourses.assignAll(StaticData.courses.where((c) => c.status == 'pending').toList());
    users.assignAll([StaticData.adminUser, StaticData.instructorAlex, StaticData.instructorSarah, StaticData.studentJohn]);
  }

  void approveCourse(CourseModel course) {
    pendingCourses.remove(course);
    Get.snackbar('Course Approved! 🚀', "'${course.title}' is now live on marketplace.",
        backgroundColor: Colors.green.shade100, colorText: Colors.green.shade900);
  }

  void rejectCourse(CourseModel course) {
    pendingCourses.remove(course);
    Get.snackbar('Course Rejected', "Feedback sent to instructor for modifications.",
        backgroundColor: Colors.red.shade100, colorText: Colors.red.shade900);
  }
}
