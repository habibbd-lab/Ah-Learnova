import 'package:get/get.dart';
import '../../data/models/course_model.dart';
import '../../data/repositories/course_repository.dart';

class CourseDetailsController extends GetxController {
  final CourseRepository _courseRepo = CourseRepository();

  final Rx<CourseModel?> course = Rx<CourseModel?>(null);
  final RxBool isWishlisted = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is CourseModel) {
      course.value = Get.arguments as CourseModel;
    } else if (Get.arguments is String) {
      course.value = _courseRepo.getCourseBySlug(Get.arguments as String);
    } else {
      course.value = _courseRepo.getCourses().first;
    }
    isWishlisted.value = course.value?.isWishlisted ?? false;
  }

  void toggleWishlist() {
    if (course.value != null) {
      _courseRepo.toggleWishlist(course.value!.id);
      isWishlisted.value = !isWishlisted.value;
      course.value!.isWishlisted = isWishlisted.value;
    }
  }
}
