import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/course_model.dart';
import '../../data/models/earnings_model.dart';
import '../../data/static/static_data.dart';

class InstructorController extends GetxController {
  final RxList<CourseModel> instructorCourses = <CourseModel>[].obs;
  final RxList<EarningsRecordModel> earningsRecords = <EarningsRecordModel>[].obs;
  final RxDouble totalEarnings = 14850.00.obs;
  final RxDouble currentBalance = 3420.50.obs;
  final withdrawAmountController = TextEditingController();

  final newCourseTitleController = TextEditingController();
  final newCourseSubtitleController = TextEditingController();
  final newCoursePriceController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadInstructorData();
  }

  void loadInstructorData() {
    instructorCourses.assignAll(StaticData.courses.where((c) => c.instructorId == 2 || c.instructorId == 3).toList());
    earningsRecords.assignAll(StaticData.earnings);
  }

  void requestWithdrawal() {
    final amount = double.tryParse(withdrawAmountController.text) ?? 0.0;
    if (amount <= 0 || amount > currentBalance.value) {
      Get.snackbar('Error', 'Please enter an amount up to ${currentBalance.value}');
      return;
    }
    currentBalance.value -= amount;
    withdrawAmountController.clear();
    Get.back();
    Get.snackbar('Withdrawal Submitted! 🚀', 'Payout request of \$$amount sent to administrative queue.',
        backgroundColor: Colors.green.shade100, colorText: Colors.green.shade900);
  }

  void createNewCourse() {
    if (newCourseTitleController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter a course title.');
      return;
    }

    final newCourse = CourseModel(
      id: StaticData.courses.length + 1,
      title: newCourseTitleController.text,
      slug: newCourseTitleController.text.toLowerCase().replaceAll(' ', '-'),
      subtitle: newCourseSubtitleController.text,
      description: 'Newly created instructor masterclass.',
      categoryId: 1,
      instructorId: 2,
      instructor: StaticData.instructorAlex,
      price: double.tryParse(newCoursePriceController.text) ?? 49.99,
      status: 'pending',
    );

    StaticData.courses.insert(0, newCourse);
    instructorCourses.insert(0, newCourse);
    newCourseTitleController.clear();
    newCourseSubtitleController.clear();
    newCoursePriceController.clear();
    Get.back();
    Get.snackbar('Course Submitted for Review! 🚀', 'Admin moderation will review and publish your course.',
        backgroundColor: Colors.green.shade100, colorText: Colors.green.shade900);
  }
}
