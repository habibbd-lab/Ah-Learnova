import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/colors/app_colors.dart';
import '../../core/utils/formatters.dart';
import '../../core/widgets/stat_card_widget.dart';
import '../main_nav/main_nav_controller.dart';
import 'admin_controller.dart';

class AdminDashboardView extends GetView<AdminController> {
  const AdminDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: const Text('Super Admin Control Center', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () => MainNavController.handleBack(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // KPI Financial Stats
            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: StatCardWidget(
                      title: 'Gross Volume',
                      value: Formatters.currency(controller.grossRevenue.value),
                      subtitle: 'Marketplace transactions',
                      icon: Icons.account_balance,
                      iconColor: AppColors.success,
                      iconBgColor: AppColors.successSubtle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: StatCardWidget(
                      title: 'Platform Profit',
                      value: Formatters.currency(controller.platformNetProfit.value),
                      subtitle: '10% Platform fee',
                      icon: Icons.trending_up,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Course Moderation Queue
            const Text('Course Review & Moderation Queue', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),

            Obx(() {
              if (controller.pendingCourses.isEmpty) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle_outline, color: AppColors.success, size: 20),
                        SizedBox(width: 8),
                        Text('All courses are moderated and published!', style: TextStyle(color: AppColors.textMuted, fontSize: 13)),
                      ],
                    ),
                  ),
                );
              }

              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.pendingCourses.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final course = controller.pendingCourses[index];
                  return Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.warningSubtle,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text('AWAITING REVIEW', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.warning)),
                            ),
                            const Spacer(),
                            Text(Formatters.currency(course.effectivePrice), style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(course.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        const SizedBox(height: 4),
                        Text('Instructor: ${course.instructor?.name ?? "Alex Rivera"}', style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => controller.approveCourse(course),
                                style: ElevatedButton.styleFrom(backgroundColor: AppColors.success),
                                child: const Text('Approve & Publish', style: TextStyle(color: Colors.white, fontSize: 12)),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => controller.rejectCourse(course),
                                style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.danger)),
                                child: const Text('Reject With Reason', style: TextStyle(color: AppColors.danger, fontSize: 12)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
            const SizedBox(height: 24),

            // Registered Users Overview
            const Text('Registered Users Directory', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),

            Obx(
              () => ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.users.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final u = controller.users[index];
                  return ListTile(
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: AppColors.borderLight)),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(u.avatarUrl ?? 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=300'),
                    ),
                    title: Text(u.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    subtitle: Text('${u.email} • ${u.role.toUpperCase()}', style: const TextStyle(fontSize: 11)),
                    trailing: Switch(
                      value: u.status == 'active',
                      onChanged: (val) {
                        Get.snackbar('User Status', 'User status updated.');
                      },
                      activeColor: AppColors.primary,
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
