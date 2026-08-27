import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainNavController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }

  void goToHome() {
    currentIndex.value = 0;
  }

  static void handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else if (Get.isRegistered<MainNavController>() && Get.find<MainNavController>().currentIndex.value != 0) {
      Get.find<MainNavController>().goToHome();
    } else if (Get.key.currentState?.canPop() ?? false) {
      Get.back();
    } else {
      Get.offAllNamed('/main');
    }
  }
}
