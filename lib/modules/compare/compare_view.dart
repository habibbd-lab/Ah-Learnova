import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/colors/app_colors.dart';
import '../../core/utils/formatters.dart';
import '../../core/widgets/rating_stars_widget.dart';
import '../main_nav/main_nav_controller.dart';
import 'compare_controller.dart';

class CompareView extends GetView<CompareController> {
  const CompareView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: const Text('Compare Masterclasses', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () => MainNavController.handleBack(context),
        ),
      ),
      body: Obx(() {
        if (controller.selectedCourses.isEmpty) {
          return const Center(child: Text('Select courses to compare.'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header description
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primarySubtle,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primaryLight.withOpacity(0.3)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info_outline, color: AppColors.primary),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Compare curriculum depth, level, pricing, and certificate inclusion side-by-side.',
                        style: TextStyle(color: AppColors.primaryDark, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Comparison Table / Cards
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: controller.selectedCourses.map((c) {
                    return Container(
                      width: 220,
                      margin: const EdgeInsets.only(right: 14),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.borderLight),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image & Title
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              c.thumbnail ?? 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=800',
                              height: 100,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            c.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          const SizedBox(height: 8),

                          // Price
                          Text(
                            Formatters.currency(c.effectivePrice),
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primary),
                          ),
                          const Divider(height: 20),

                          // Comparison Metrics
                          _buildMetricRow('Instructor', c.instructor?.name ?? 'Learnova Expert'),
                          _buildMetricRow('Category', c.category?.name ?? 'Tech'),
                          _buildMetricRow('Skill Level', c.level.toUpperCase()),
                          _buildMetricRow('Duration', Formatters.duration(c.totalDurationMinutes)),
                          _buildMetricRow('Lessons', '${c.totalLessonsCount} Lessons'),
                          _buildMetricRow('Certificate', 'Included (100%)', isPositive: true),
                          _buildMetricRow('Quizzes', '${c.quizzes.length} Timed Quizzes'),
                          const SizedBox(height: 8),
                          RatingStarsWidget(rating: c.averageRating, starSize: 11, reviewsCount: c.reviewsCount),
                          const SizedBox(height: 16),

                          ElevatedButton(
                            onPressed: () => Get.toNamed('/courses/details', arguments: c),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              minimumSize: const Size(double.infinity, 38),
                              padding: EdgeInsets.zero,
                            ),
                            child: const Text('View Details', style: TextStyle(fontSize: 12, color: Colors.white)),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildMetricRow(String label, String value, {bool isPositive = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textMuted, fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isPositive ? AppColors.success : AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }
}
