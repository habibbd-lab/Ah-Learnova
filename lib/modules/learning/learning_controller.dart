import 'package:get/get.dart';
import '../../data/models/course_model.dart';
import '../../data/models/lesson_model.dart';
import '../../data/repositories/course_repository.dart';

class LearningController extends GetxController {
  final CourseRepository _courseRepo = CourseRepository();

  final RxList<CourseModel> enrolledCourses = <CourseModel>[].obs;
  final Rx<CourseModel?> activeCourse = Rx<CourseModel?>(null);
  final Rx<LessonModel?> activeLesson = Rx<LessonModel?>(null);
  final RxDouble progressPercentage = 0.0.obs;
  final RxBool isPlaying = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadEnrolledCourses();
  }

  void loadEnrolledCourses() {
    enrolledCourses.assignAll(_courseRepo.getEnrolledCourses());
    if (enrolledCourses.isNotEmpty && activeCourse.value == null) {
      setActiveCourse(enrolledCourses.first);
    }
  }

  void setActiveCourse(CourseModel course) {
    activeCourse.value = course;
    progressPercentage.value = course.progressPercentage;
    if (course.sections.isNotEmpty && course.sections.first.lessons.isNotEmpty) {
      activeLesson.value = course.sections.first.lessons.first;
    }
  }

  void selectLesson(LessonModel lesson) {
    activeLesson.value = lesson;
  }

  void toggleLessonCompletion(LessonModel lesson) {
    lesson.isCompleted = !lesson.isCompleted;

    if (activeCourse.value != null) {
      final totalLessons = activeCourse.value!.totalLessonsCount;
      int completedLessons = 0;
      for (var sec in activeCourse.value!.sections) {
        completedLessons += sec.lessons.where((l) => l.isCompleted).length;
      }
      final newProgress = (completedLessons / (totalLessons == 0 ? 1 : totalLessons)) * 100;
      progressPercentage.value = newProgress;
      activeCourse.value!.progressPercentage = newProgress;

      if (newProgress >= 100.0) {
        Get.snackbar(
          'Congratulations! 🎓',
          'Course 100% completed! Your Certificate of Achievement has been issued.',
          duration: const Duration(seconds: 4),
        );
      }
    }
    activeLesson.refresh();
  }
}
