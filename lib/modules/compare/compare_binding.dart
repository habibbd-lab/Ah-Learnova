import 'package:get/get.dart';
import 'compare_controller.dart';

class CompareBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompareController>(() => CompareController());
  }
}
