import 'package:get/get.dart';
import 'main_nav_controller.dart';
import '../home/home_controller.dart';
import '../courses/courses_controller.dart';
import '../wishlist/wishlist_controller.dart';
import '../learning/learning_controller.dart';
import '../auth/auth_controller.dart';

class MainNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainNavController>(() => MainNavController(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<CoursesController>(() => CoursesController(), fenix: true);
    Get.lazyPut<WishlistController>(() => WishlistController(), fenix: true);
    Get.lazyPut<LearningController>(() => LearningController(), fenix: true);
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
  }
}
