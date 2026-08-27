import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/colors/app_colors.dart';
import '../../core/utils/formatters.dart';
import '../../core/widgets/stat_card_widget.dart';
import '../main_nav/main_nav_controller.dart';
import 'instructor_controller.dart';

class InstructorDashboardView extends GetView<InstructorController> {
  const InstructorDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: const Text('Instructor Studio', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () => MainNavController.handleBack(context),
        ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add_circle_outline, color: AppColors.primary),
              tooltip: 'Create New Masterclass',
              onPressed: () => Get.toNamed('/instructor/builder'),
            ),
          ],
        ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // KPI Financial Metrics
            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: StatCardWidget(
                      title: 'Total Revenue',
                      value: Formatters.currency(controller.totalEarnings.value),
                      subtitle: 'All-time 90% share',
                      icon: Icons.payments_outlined,
                      iconColor: AppColors.success,
                      iconBgColor: AppColors.successSubtle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: StatCardWidget(
                      title: 'Current Balance',
                      value: Formatters.currency(controller.currentBalance.value),
                      subtitle: 'Available to withdraw',
                      icon: Icons.account_balance_wallet_outlined,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Payout Action Bar
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: AppColors.heroGradient,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ready to Payout?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                      SizedBox(height: 2),
                      Text('Direct bank or mobile transfer', style: TextStyle(color: Colors.white70, fontSize: 11)),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () => Get.toNamed('/instructor/earnings'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.textDark,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Withdraw Funds', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Courses Management
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('My Masterclasses', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                TextButton(
                  onPressed: () => Get.toNamed('/instructor/builder'),
                  child: const Text('+ Create Course', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Obx(
              () => ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.instructorCourses.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final course = controller.instructorCourses[index];
                  return Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            course.thumbnail ?? 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=800',
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                course.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: course.status == 'published' ? AppColors.successSubtle : AppColors.warningSubtle,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      course.status.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                        color: course.status == 'published' ? AppColors.success : AppColors.warning,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '${course.studentsCount} students • ${Formatters.currency(course.effectivePrice)}',
                                    style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit_outlined, size: 20, color: AppColors.primary),
                          onPressed: () => Get.toNamed('/courses/details', arguments: course),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
