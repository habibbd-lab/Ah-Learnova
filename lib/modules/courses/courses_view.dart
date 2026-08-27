import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/colors/app_colors.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../core/widgets/course_card_widget.dart';
import '../../core/widgets/empty_state.dart';
import '../main_nav/main_nav_controller.dart';
import 'courses_controller.dart';

class CoursesView extends GetView<CoursesController> {
  const CoursesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: const Text('Browse Masterclasses', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () => MainNavController.handleBack(context),
        ),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list_rounded),
              onPressed: () => _showFilterBottomSheet(context),
            ),
          ],
        ),
      body: Column(
        children: [
          // Search & Filter Header
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hintText: 'Search 15+ courses, skills...',
                    prefixIcon: Icons.search,
                    controller: controller.searchController,
                    onChanged: controller.onSearchChanged,
                  ),
                ),
                const SizedBox(width: 10),
                IconButton.filledTonal(
                  onPressed: () => _showFilterBottomSheet(context),
                  icon: const Icon(Icons.tune, color: AppColors.primary),
                  style: IconButton.styleFrom(backgroundColor: AppColors.primarySubtle),
                ),
              ],
            ),
          ),

          // Categories Horizontal Chips
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(bottom: 12),
            child: SizedBox(
              height: 38,
              child: Obx(
                () => ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildCategoryChip('All Categories', 0),
                    ...controller.categories.map((c) => _buildCategoryChip(c.name, c.id)),
                  ],
                ),
              ),
            ),
          ),
          const Divider(height: 1, color: AppColors.borderLight),

          // Courses Grid
          Expanded(
            child: Obx(() {
              if (controller.filteredCourses.isEmpty) {
                return EmptyState(
                  icon: Icons.search_off_rounded,
                  title: 'No courses match your criteria',
                  description: 'Try adjusting your search query, price filter, or level options.',
                  actionText: 'Reset Filters',
                  onActionPressed: controller.resetFilters,
                );
              }

              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 320,
                  mainAxisExtent: 310,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                ),
                itemCount: controller.filteredCourses.length,
                itemBuilder: (context, index) {
                  final course = controller.filteredCourses[index];
                  return CourseCardWidget(
                    course: course,
                    onWishlistToggle: () => controller.toggleWishlist(course.id),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, int id) {
    final isSelected = controller.selectedCategoryId.value == id;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.white : AppColors.textDark,
          ),
        ),
        selected: isSelected,
        selectedColor: AppColors.primary,
        backgroundColor: AppColors.bgLight,
        side: BorderSide(color: isSelected ? AppColors.primary : AppColors.borderLight),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        showCheckmark: false,
        onSelected: (_) => controller.selectCategory(id),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.fromLTRB(22, 16, 22, 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 25,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: AppColors.borderLight,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filter & Sort Courses',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      color: AppColors.textDark,
                      letterSpacing: -0.4,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.resetFilters();
                      Get.back();
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Reset All',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Skill Level Filter
              const Text(
                'Skill Level',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: AppColors.textMuted,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 10),
              Obx(
                () => Wrap(
                  spacing: 8,
                  runSpacing: 10,
                  children: [
                    _buildChoiceChip('All Levels', 'all', controller.selectedLevel.value, controller.selectLevel),
                    _buildChoiceChip('Beginner', 'beginner', controller.selectedLevel.value, controller.selectLevel),
                    _buildChoiceChip('Intermediate', 'intermediate', controller.selectedLevel.value, controller.selectLevel),
                    _buildChoiceChip('Advanced', 'advanced', controller.selectedLevel.value, controller.selectLevel),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Price Tier Filter
              const Text(
                'Price Tier',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: AppColors.textMuted,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 10),
              Obx(
                () => Wrap(
                  spacing: 8,
                  runSpacing: 10,
                  children: [
                    _buildChoiceChip('All Prices', 'all', controller.selectedPriceType.value, controller.selectPriceType),
                    _buildChoiceChip('Free Preview', 'free', controller.selectedPriceType.value, controller.selectPriceType),
                    _buildChoiceChip('Paid Masterclasses', 'paid', controller.selectedPriceType.value, controller.selectPriceType),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Sort By Option
              const Text(
                'Sort By',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: AppColors.textMuted,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 10),
              Obx(
                () => Wrap(
                  spacing: 8,
                  runSpacing: 10,
                  children: [
                    _buildChoiceChip('Most Popular', 'popular', controller.selectedSortBy.value, controller.selectSortBy),
                    _buildChoiceChip('Highest Rated', 'rating', controller.selectedSortBy.value, controller.selectSortBy),
                    _buildChoiceChip('Price: Low to High', 'price_low', controller.selectedSortBy.value, controller.selectSortBy),
                    _buildChoiceChip('Price: High to Low', 'price_high', controller.selectedSortBy.value, controller.selectSortBy),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Submit Button
              Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Apply Filters',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildChoiceChip(String label, String value, String currentSelected, Function(String) onSelect) {
    final isSelected = currentSelected == value;
    return InkWell(
      onTap: () => onSelect(value),
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.borderLight,
            width: 1.2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? Colors.white : AppColors.textDark,
          ),
        ),
      ),
    );
  }
}
