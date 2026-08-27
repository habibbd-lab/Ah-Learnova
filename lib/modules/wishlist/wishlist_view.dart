import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/colors/app_colors.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/course_card_widget.dart';
import '../main_nav/main_nav_controller.dart';
import 'wishlist_controller.dart';

class WishlistView extends GetView<WishlistController> {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: const Text('Saved Wishlist', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () => MainNavController.handleBack(context),
        ),
      ),
      body: Obx(() {
        if (controller.wishlistCourses.isEmpty) {
          return EmptyState(
            icon: Icons.favorite_border_rounded,
            title: 'Your Wishlist is Empty',
            description: 'Save interesting masterclasses and return to them anytime.',
            actionText: 'Browse Courses',
            onActionPressed: () => Get.toNamed('/courses'),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.wishlistCourses.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final course = controller.wishlistCourses[index];
            return CourseCardWidget(
              course: course,
              isHorizontal: true,
              onWishlistToggle: () => controller.toggleWishlist(course.id),
            );
          },
        );
      }),
    );
  }
}
