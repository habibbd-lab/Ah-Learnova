import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/colors/app_colors.dart';
import '../../core/utils/formatters.dart';
import '../main_nav/main_nav_controller.dart';
import 'notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: const Text('Notifications Center', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () => MainNavController.handleBack(context),
        ),
          actions: [
            IconButton(
              icon: const Icon(Icons.done_all),
              tooltip: 'Mark All as Read',
              onPressed: controller.markAllAsRead,
            ),
          ],
        ),
      body: Obx(() {
        if (controller.notifications.isEmpty) {
          return const Center(child: Text('No notifications available.'));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.notifications.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final n = controller.notifications[index];
            return Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: n.type == 'success' ? AppColors.successSubtle : AppColors.primarySubtle,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      n.type == 'success' ? Icons.check_circle_outline : Icons.notifications_none,
                      color: n.type == 'success' ? AppColors.success : AppColors.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(n.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        const SizedBox(height: 4),
                        Text(n.message, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
                        const SizedBox(height: 6),
                        Text(Formatters.dateTime(n.createdAt), style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
                      ],
                    ),
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
