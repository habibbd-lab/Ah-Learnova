import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../colors/app_colors.dart';
import '../utils/formatters.dart';
import '../../data/models/course_model.dart';
import 'rating_stars_widget.dart';

class CourseCardWidget extends StatelessWidget {
  final CourseModel course;
  final VoidCallback? onTap;
  final VoidCallback? onWishlistToggle;
  final bool isHorizontal;

  const CourseCardWidget({
    super.key,
    required this.course,
    this.onTap,
    this.onWishlistToggle,
    this.isHorizontal = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isHorizontal) {
      return _buildHorizontalCard(context);
    }
    return _buildVerticalCard(context);
  }

  Widget _buildVerticalCard(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => Get.toNamed('/courses/details', arguments: course),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderLight),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail Image & Badges
            Stack(
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  color: AppColors.primarySubtle,
                  child: Image.network(
                    course.thumbnail ?? 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=800',
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => const Center(
                      child: Icon(Icons.school, size: 40, color: AppColors.primary),
                    ),
                  ),
                ),
                if (course.isBestseller)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(
                        gradient: AppColors.goldGradient,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'BESTSELLER',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Material(
                    color: Colors.white.withValues(alpha: 0.9),
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: onWishlistToggle,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(
                          course.isWishlisted ? Icons.favorite : Icons.favorite_border,
                          size: 16,
                          color: course.isWishlisted ? AppColors.danger : AppColors.textMuted,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Content Body
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Badge
                  if (course.category != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.bgLight,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.borderLight),
                      ),
                      child: Text(
                        course.category!.name,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                  const SizedBox(height: 4),

                  // Title
                  Text(
                    course.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: AppColors.textDark,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 3),

                  // Instructor Name
                  if (course.instructor != null)
                    Text(
                      course.instructor!.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                  const SizedBox(height: 4),

                  // Rating & Students
                  RatingStarsWidget(
                    rating: course.averageRating,
                    reviewsCount: course.reviewsCount,
                    starSize: 11,
                  ),
                  const SizedBox(height: 6),

                  // Price
                  Row(
                    children: [
                      Text(
                        Formatters.currency(course.effectivePrice),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppColors.primary,
                        ),
                      ),
                      if (course.discountPrice != null && course.discountPrice! < course.price) ...[
                        const SizedBox(width: 6),
                        Text(
                          Formatters.currency(course.price),
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 11,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalCard(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => Get.toNamed('/courses/details', arguments: course),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderLight),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: Image.network(
                course.thumbnail ?? 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=800',
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      course.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    RatingStarsWidget(rating: course.averageRating, starSize: 10, reviewsCount: course.reviewsCount),
                    const Spacer(),
                    Text(
                      Formatters.currency(course.effectivePrice),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
