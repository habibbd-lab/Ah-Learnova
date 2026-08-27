import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/colors/app_colors.dart';
import '../../data/models/course_model.dart';
import '../main_nav/main_nav_controller.dart';
import 'learning_controller.dart';

class LearningPlayerView extends GetView<LearningController> {
  const LearningPlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    if (Get.arguments is CourseModel) {
      controller.setActiveCourse(Get.arguments as CourseModel);
    }

    return Obx(() {
      final course = controller.activeCourse.value;
      final lesson = controller.activeLesson.value;

      if (course == null) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: AppColors.bgLight,
          appBar: AppBar(
            backgroundColor: AppColors.bgDark,
            foregroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              tooltip: 'Back',
              onPressed: () => MainNavController.handleBack(context),
            ),
            title: Text(course.title, style: const TextStyle(fontSize: 15)),
              bottom: const TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: AppColors.textMutedDark,
                indicatorColor: AppColors.primaryLight,
                tabs: [
                  Tab(icon: Icon(Icons.menu_book, size: 16), text: 'Curriculum'),
                  Tab(icon: Icon(Icons.info_outline, size: 16), text: 'Overview'),
                  Tab(icon: Icon(Icons.forum_outlined, size: 16), text: 'Q&A Forum'),
                ],
              ),
            ),
          body: Column(
            children: [
              // Interactive Video Screen Container
              Container(
                height: 220,
                width: double.infinity,
                color: Colors.black,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      course.thumbnail ?? 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=800',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Container(color: Colors.black.withOpacity(0.55)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton(
                          heroTag: 'player_btn',
                          onPressed: () {
                            controller.isPlaying.value = !controller.isPlaying.value;
                          },
                          backgroundColor: AppColors.primary,
                          shape: const CircleBorder(),
                          child: Icon(
                            controller.isPlaying.value ? Icons.pause : Icons.play_arrow_rounded,
                            size: 36,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            lesson?.title ?? 'Lesson Stream',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    // Checkoff button overlay
                    if (lesson != null)
                      Positioned(
                        bottom: 12,
                        right: 12,
                        child: FilledButton.tonalIcon(
                          onPressed: () => controller.toggleLessonCompletion(lesson),
                          icon: Icon(
                            lesson.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                            color: lesson.isCompleted ? AppColors.success : Colors.white,
                            size: 16,
                          ),
                          label: Text(
                            lesson.isCompleted ? 'Completed' : 'Mark Complete',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: lesson.isCompleted ? AppColors.success : Colors.white,
                            ),
                          ),
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.black.withOpacity(0.7),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Progress Bar
              LinearProgressIndicator(
                value: controller.progressPercentage.value / 100,
                backgroundColor: AppColors.borderLight,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                minHeight: 4,
              ),

              // Tabs Body
              Expanded(
                child: TabBarView(
                  children: [
                    // Tab 1: Curriculum List
                    ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: course.sections.length,
                      itemBuilder: (context, sIndex) {
                        final section = course.sections[sIndex];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ExpansionTile(
                            initiallyExpanded: sIndex == 0,
                            title: Text(section.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                            subtitle: Text('${section.lessons.length} lessons', style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                            children: section.lessons.map((l) {
                              final isCurrent = l.id == lesson?.id;
                              return ListTile(
                                dense: true,
                                selected: isCurrent,
                                selectedTileColor: AppColors.primarySubtle,
                                leading: IconButton(
                                  icon: Icon(
                                    l.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                                    color: l.isCompleted ? AppColors.success : AppColors.textMuted,
                                    size: 18,
                                  ),
                                  onPressed: () => controller.toggleLessonCompletion(l),
                                ),
                                title: Text(
                                  l.title,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                                    color: isCurrent ? AppColors.primary : AppColors.textDark,
                                  ),
                                ),
                                trailing: Text('${l.durationMinutes}m', style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                                onTap: () => controller.selectLesson(l),
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),

                    // Tab 2: Overview & Resources
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(lesson?.title ?? 'Lesson Overview', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 8),
                          Text(
                            lesson?.description ?? 'This lesson covers architecture setup, reactive streams, and production deployment patterns.',
                            style: const TextStyle(fontSize: 13, color: AppColors.textMuted, height: 1.4),
                          ),
                          const SizedBox(height: 20),
                          const Text('Attached Materials', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          const SizedBox(height: 8),
                          ListTile(
                            leading: const Icon(Icons.picture_as_pdf, color: AppColors.danger),
                            title: const Text('Lecture Notes & Cheatsheet', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                            subtitle: const Text('PDF • 1.4 MB', style: TextStyle(fontSize: 11)),
                            trailing: IconButton(
                              icon: const Icon(Icons.download, size: 20),
                              onPressed: () => Get.snackbar('Download', 'Lecture Notes downloaded successfully!'),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Tab 3: Q&A Forum
                    ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.borderLight),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  CircleAvatar(radius: 14, child: Text('JD', style: TextStyle(fontSize: 10))),
                                  SizedBox(width: 8),
                                  Text('John Doe', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                  Spacer(),
                                  Text('2h ago', style: TextStyle(fontSize: 10, color: AppColors.textMuted)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Text('How do we configure GetX nested routing in web builds?', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.primarySubtle,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.verified, size: 14, color: AppColors.primary),
                                    SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        'Instructor Sarah: Use GetRouterOutlet with named sub-routes in AppPages.',
                                        style: TextStyle(fontSize: 12, color: AppColors.primaryDark),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
