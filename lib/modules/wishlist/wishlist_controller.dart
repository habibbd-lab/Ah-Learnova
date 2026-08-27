import 'package:get/get.dart';
import '../../data/models/course_model.dart';
import '../../data/repositories/course_repository.dart';

class WishlistController extends GetxController {
  final CourseRepository _courseRepo = CourseRepository();

  final RxList<CourseModel> wishlistCourses = <CourseModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadWishlist();
  }

  void loadWishlist() {
    wishlistCourses.assignAll(_courseRepo.getWishlistedCourses());
  }

  void toggleWishlist(int courseId) {
    _courseRepo.toggleWishlist(courseId);
    loadWishlist();
  }
}
