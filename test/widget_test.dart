import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:learnova_lms/main.dart';
import 'package:learnova_lms/modules/certificate/certificate_print_view.dart';
import 'package:learnova_lms/modules/main_nav/main_nav_controller.dart';
import 'package:learnova_lms/modules/main_nav/main_nav_view.dart';
import 'package:learnova_lms/modules/wishlist/wishlist_controller.dart';
import 'package:learnova_lms/modules/courses/courses_controller.dart';
import 'package:learnova_lms/modules/learning/learning_controller.dart';
import 'package:learnova_lms/modules/auth/auth_controller.dart';
import 'package:learnova_lms/modules/home/home_controller.dart';
import 'package:learnova_lms/routes/app_pages.dart';

void main() {
  testWidgets('Learnova app initializes successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const LearnovaApp());
    expect(find.byType(LearnovaApp), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 3));
  });

  testWidgets('CertificatePrintView renders without overflow on narrow mobile screens', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    Get.reset();
    Get.put(MainNavController());
    Get.put(HomeController());
    Get.put(CoursesController());
    Get.put(LearningController());
    Get.put(WishlistController());
    Get.put(AuthController());

    await tester.pumpWidget(
      GetMaterialApp(
        home: const CertificatePrintView(),
        getPages: AppPages.routes,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('AH-LEARNOVA ACADEMY'), findsOneWidget);
    expect(find.text('CERTIFICATE OF COMPLETION'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('Wishlist tab back button navigates back to Home tab', (WidgetTester tester) async {
    Get.reset();
    Get.put(MainNavController());
    Get.put(HomeController());
    Get.put(CoursesController());
    Get.put(LearningController());
    Get.put(WishlistController());
    Get.put(AuthController());

    await tester.pumpWidget(
      const GetMaterialApp(
        home: MainNavView(),
      ),
    );
    await tester.pumpAndSettle();

    final navCtrl = Get.find<MainNavController>();
    // Switch to Wishlist tab (index 3)
    navCtrl.changeIndex(3);
    await tester.pumpAndSettle();
    expect(navCtrl.currentIndex.value, 3);
    expect(find.text('Saved Wishlist'), findsOneWidget);

    // Tap back button in Saved Wishlist AppBar
    final backBtn = find.descendant(
      of: find.byType(AppBar),
      matching: find.byIcon(Icons.arrow_back),
    );
    expect(backBtn, findsOneWidget);
    await tester.tap(backBtn);
    await tester.pumpAndSettle();

    // Verify it smoothly returned to Home tab (index 0)
    expect(navCtrl.currentIndex.value, 0);
  });
}
