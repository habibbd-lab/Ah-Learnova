import 'package:get/get.dart';
import 'instructor_controller.dart';

class InstructorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InstructorController>(() => InstructorController());
  }
}
