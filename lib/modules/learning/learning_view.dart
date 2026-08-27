import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/colors/app_colors.dart';
import '../../core/widgets/empty_state.dart';
import '../main_nav/main_nav_controller.dart';
import 'learning_controller.dart';

class LearningView extends GetView<LearningController> {
  const LearningView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: const Text('My Learning Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () => MainNavController.handleBack(context),
        ),
      ),
      body: Obx(() {
        if (controller.enrolledCourses.isEmpty) {
          return EmptyState(
            icon: Icons.school_outlined,
            title: 'No Enrolled Masterclasses',
            description: 'Browse our catalog and start acquiring in-demand software skills today.',
            actionText: 'Explore Courses',
            onActionPressed: () => Get.toNamed('/courses'),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.enrolledCourses.length,
          separatorBuilder: (_, __) => const SizedBox(height: 14),
          itemBuilder: (context, index) {
            final course = controller.enrolledCourses[index];
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderLight),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          course.thumbnail ?? 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=800',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              course.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Instructor: ${course.instructor?.name ?? "Lead Expert"}',
                              style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '${course.sections.length} Sections • ${course.totalLessonsCount} Lessons',
                              style: const TextStyle(fontSize: 11, color: AppColors.primary, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Progress Bar & Percentage
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Progress', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                      Text('${course.progressPercentage.toInt()}%', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  LinearProgressIndicator(
                    value: course.progressPercentage / 100,
                    backgroundColor: AppColors.primarySubtle,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                    borderRadius: BorderRadius.circular(4),
                    minHeight: 6,
                  ),
                  const SizedBox(height: 14),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            controller.setActiveCourse(course);
                            Get.toNamed('/learning/player', arguments: course);
                          },
                          icon: const Icon(Icons.play_arrow_rounded, size: 18, color: Colors.white),
                          label: const Text('Continue Learning', style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                        ),
                      ),
                      if (course.quizzes.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        IconButton.filledTonal(
                          onPressed: () => Get.toNamed('/quiz/take', arguments: course.quizzes.first),
                          icon: const Icon(Icons.quiz_outlined, color: AppColors.primary),
                          tooltip: 'Take Quiz',
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
