import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/colors/app_colors.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';
import '../main_nav/main_nav_controller.dart';
import 'instructor_controller.dart';

class InstructorCourseBuilderView extends GetView<InstructorController> {
  const InstructorCourseBuilderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: const Text('Course Curriculum Builder', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () => MainNavController.handleBack(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Course Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'Masterclass Title',
                    hintText: 'e.g. Advanced Reactive Systems in Flutter',
                    controller: controller.newCourseTitleController,
                  ),
                  const SizedBox(height: 14),
                  CustomTextField(
                    label: 'Subtitle / Headline',
                    hintText: 'Short description of the outcomes...',
                    controller: controller.newCourseSubtitleController,
                  ),
                  const SizedBox(height: 14),
                  CustomTextField(
                    label: 'Price (\$ USD)',
                    hintText: '49.99',
                    controller: controller.newCoursePriceController,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Curriculum Sections Builder
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Curriculum Sections', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      TextButton.icon(
                        onPressed: () => Get.snackbar('Section', 'New section added to builder draft.'),
                        icon: const Icon(Icons.add, size: 16),
                        label: const Text('Add Section', style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    tileColor: AppColors.bgLight,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    leading: const Icon(Icons.drag_handle, color: AppColors.textMuted),
                    title: const Text('Section 1: Architecture Overview & Setup', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                    subtitle: const Text('3 Lessons • 45m', style: TextStyle(fontSize: 11)),
                    trailing: IconButton(
                      icon: const Icon(Icons.add_circle_outline, size: 20, color: AppColors.primary),
                      onPressed: () => Get.snackbar('Lesson', 'New lesson modal opened.'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            CustomButton(
              text: 'Submit Course For Review',
              onPressed: controller.createNewCourse,
            ),
          ],
        ),
      ),
    );
  }
}
