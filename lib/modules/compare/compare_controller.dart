import 'package:get/get.dart';
import '../../data/models/course_model.dart';
import '../../data/repositories/course_repository.dart';

class CompareController extends GetxController {
  final CourseRepository _courseRepo = CourseRepository();

  final RxList<CourseModel> selectedCourses = <CourseModel>[].obs;
  final RxList<CourseModel> allCourses = <CourseModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    final list = _courseRepo.getCourses();
    allCourses.assignAll(list);
    if (list.length >= 2) {
      selectedCourses.assignAll([list[0], list[1]]);
    }
  }

  void addCourse(CourseModel course) {
    if (selectedCourses.length < 4 && !selectedCourses.contains(course)) {
      selectedCourses.add(course);
    } else {
      Get.snackbar('Limit Reached', 'You can compare up to 4 courses at a time.');
    }
  }

  void removeCourse(CourseModel course) {
    if (selectedCourses.length > 2) {
      selectedCourses.remove(course);
    } else {
      Get.snackbar('Notice', 'At least 2 courses are required for comparison.');
    }
  }
}
