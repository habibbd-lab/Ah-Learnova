import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/colors/app_colors.dart';
import '../../core/strings/app_strings.dart';
import '../../core/widgets/section_header.dart';
import '../../core/widgets/course_card_widget.dart';
import '../../core/widgets/stat_card_widget.dart';
import '../../core/widgets/custom_text_field.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => controller.loadHomeData(),
          color: AppColors.primary,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Brand Bar with Search
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.school_rounded, color: Colors.white, size: 22),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.appName,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textDark,
                                letterSpacing: -0.5,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Production Learning Ecosystem',
                              style: TextStyle(fontSize: 11, color: AppColors.textMuted),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Get.toNamed('/compare'),
                        icon: const Icon(Icons.compare_arrows_rounded, color: AppColors.primary),
                        tooltip: 'Compare Courses',
                      ),
                      IconButton(
                        onPressed: () => Get.toNamed('/notifications'),
                        icon: const Icon(Icons.notifications_outlined, color: AppColors.textDark),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Search Bar Input
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                    hintText: AppStrings.searchPlaceholder,
                    prefixIcon: Icons.search,
                    readOnly: true,
                    onTap: () => Get.toNamed('/courses'),
                  ),
                ),
                const SizedBox(height: 20),

                // Hero Banner
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: AppColors.heroGradient,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.bgDark.withOpacity(0.25),
                          blurRadius: 15,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.verified, size: 14, color: AppColors.accent),
                              SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  'Enterprise Masterclasses',
                                  style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          AppStrings.heroTitle,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          AppStrings.heroSubtitle,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.8),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Platform KPI Stats Grid
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: StatCardWidget(
                          title: 'Students',
                          value: '10,000+',
                          icon: Icons.people_outline,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: StatCardWidget(
                          title: 'Courses',
                          value: '15 Live',
                          icon: Icons.auto_stories_outlined,
                          iconColor: AppColors.success,
                          iconBgColor: AppColors.successSubtle,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Categories Exploration
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SectionHeader(
                    title: 'Top Disciplines',
                    subtitle: 'Explore specialized software engineering roadmaps',
                    actionText: 'See All',
                    onActionTap: () => Get.toNamed('/courses'),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 42,
                  child: Obx(
                    () => ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.categories.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final cat = controller.categories[index];
                        return ActionChip(
                          avatar: const Icon(Icons.code, size: 16, color: AppColors.primary),
                          label: Text(cat.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: AppColors.borderLight),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          onPressed: () => Get.toNamed('/courses', arguments: {'category_id': cat.id}),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // Featured Masterclasses
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SectionHeader(
                    title: 'Featured Masterclasses',
                    subtitle: 'Curated by lead engineers & Google Developer Experts',
                    badgeText: 'HOT & NEW',
                    actionText: 'View All',
                    onActionTap: () => Get.toNamed('/courses'),
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 310,
                  child: Obx(
                    () => ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.featuredCourses.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 14),
                      itemBuilder: (context, index) {
                        final course = controller.featuredCourses[index];
                        return SizedBox(
                          width: 250,
                          child: CourseCardWidget(
                            course: course,
                            onWishlistToggle: () => controller.toggleWishlist(course.id),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // Bestsellers Grid / List
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SectionHeader(
                    title: 'Student Bestsellers',
                    subtitle: 'Top-rated masterclasses with verified certificates',
                    actionText: 'Browse Catalog',
                    onActionTap: () => Get.toNamed('/courses'),
                  ),
                ),
                const SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Obx(
                    () => ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.bestsellerCourses.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final course = controller.bestsellerCourses[index];
                        return CourseCardWidget(
                          course: course,
                          isHorizontal: true,
                          onWishlistToggle: () => controller.toggleWishlist(course.id),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
