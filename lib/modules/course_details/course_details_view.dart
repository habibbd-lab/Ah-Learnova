import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/colors/app_colors.dart';
import '../../core/utils/formatters.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/rating_stars_widget.dart';
import '../main_nav/main_nav_controller.dart';
import 'course_details_controller.dart';

class CourseDetailsView extends GetView<CourseDetailsController> {
  const CourseDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final c = controller.course.value;
      if (c == null) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      return Scaffold(
        backgroundColor: AppColors.bgLight,
        appBar: AppBar(
          title: Text(c.title, maxLines: 1, overflow: TextOverflow.ellipsis),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Back',
            onPressed: () => MainNavController.handleBack(context),
          ),
          actions: [
            Obx(
              () => IconButton(
                icon: Icon(
                  controller.isWishlisted.value ? Icons.favorite : Icons.favorite_border,
                  color: controller.isWishlisted.value ? AppColors.danger : AppColors.textDark,
                ),
                onPressed: controller.toggleWishlist,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.share_outlined),
              onPressed: () => Get.snackbar('Share', 'Course link copied to clipboard!'),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Preview Video / Thumbnail
              Container(
                height: 220,
                width: double.infinity,
                color: Colors.black,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      c.thumbnail ?? 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=800',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Container(color: Colors.black.withOpacity(0.4)),
                    FloatingActionButton(
                      onPressed: () {
                        Get.toNamed('/learning', arguments: c);
                      },
                      backgroundColor: Colors.white,
                      shape: const CircleBorder(),
                      child: const Icon(Icons.play_arrow_rounded, size: 36, color: AppColors.primary),
                    ),
                    const Positioned(
                      bottom: 12,
                      child: Text(
                        'Preview Course Masterclass',
                        style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

              // Title, Subtitle, Meta
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (c.category != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primarySubtle,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          c.category!.name,
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    const SizedBox(height: 10),
                    Text(
                      c.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                        letterSpacing: -0.5,
                      ),
                    ),
                    if (c.subtitle != null) ...[
                      const SizedBox(height: 6),
                      Text(
                        c.subtitle!,
                        style: const TextStyle(fontSize: 14, color: AppColors.textMuted, height: 1.4),
                      ),
                    ],
                    const SizedBox(height: 12),

                    // Rating & Enrolled count
                    Row(
                      children: [
                        RatingStarsWidget(
                          rating: c.averageRating,
                          reviewsCount: c.reviewsCount,
                          starSize: 14,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${c.studentsCount} students',
                          style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Instructor Row
                    if (c.instructor != null)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.borderLight),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 22,
                              backgroundImage: NetworkImage(
                                c.instructor!.avatarUrl ?? 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=300',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Created by ${c.instructor!.name}',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                  ),
                                  if (c.instructor!.headline != null)
                                    Text(
                                      c.instructor!.headline!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 20),

                    // What You'll Learn
                    if (c.whatWillLearn.isNotEmpty) ...[
                      const Text(
                        "What You'll Learn",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.borderLight),
                        ),
                        child: Column(
                          children: c.whatWillLearn.map((item) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.check_circle_rounded, size: 18, color: AppColors.success),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      item,
                                      style: const TextStyle(fontSize: 13, color: AppColors.textDark, height: 1.3),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Curriculum Sections Accordion
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Course Curriculum',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark),
                        ),
                        Text(
                          '${c.sections.length} sections • ${c.totalLessonsCount} lessons',
                          style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    ...c.sections.map((section) {
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ExpansionTile(
                          title: Text(
                            section.title,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          subtitle: Text(
                            '${section.lessons.length} lessons • ${Formatters.duration(section.totalMinutes)}',
                            style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                          ),
                          children: section.lessons.map((lesson) {
                            return ListTile(
                              dense: true,
                              leading: Icon(
                                lesson.isPreview ? Icons.play_circle_outline : Icons.lock_outline,
                                size: 20,
                                color: lesson.isPreview ? AppColors.primary : AppColors.textMuted,
                              ),
                              title: Text(lesson.title, style: const TextStyle(fontSize: 13)),
                              trailing: Text(
                                '${lesson.durationMinutes}m',
                                style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomSheet: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: const Border(top: BorderSide(color: AppColors.borderLight)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total Price', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                  Text(
                    Formatters.currency(c.effectivePrice),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: CustomButton(
                  text: c.isEnrolled ? 'Go to Classroom' : 'Enroll in Masterclass',
                  onPressed: () {
                    if (c.isEnrolled) {
                      Get.toNamed('/learning', arguments: c);
                    } else {
                      Get.toNamed('/checkout', arguments: c);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
