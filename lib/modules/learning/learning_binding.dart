import 'package:get/get.dart';
import 'learning_controller.dart';

class LearningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LearningController>(() => LearningController(), fenix: true);
  }
}
