import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/colors/app_colors.dart';
import '../home/home_view.dart';
import '../courses/courses_view.dart';
import '../learning/learning_view.dart';
import '../wishlist/wishlist_view.dart';
import '../auth/profile_view.dart';
import 'main_nav_controller.dart';

class MainNavView extends GetView<MainNavController> {
  const MainNavView({super.key});

  @override
  Widget build(BuildContext context) {
    final screens = const [
      HomeView(),
      CoursesView(),
      LearningView(),
      WishlistView(),
      ProfileView(),
    ];

    return Obx(() {
      return PopScope(
        canPop: controller.currentIndex.value == 0,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          if (controller.currentIndex.value != 0) {
            controller.goToHome();
          }
        },
        child: Scaffold(
          body: IndexedStack(
            index: controller.currentIndex.value,
            children: screens,
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: controller.currentIndex.value,
            onDestinationSelected: controller.changeIndex,
            backgroundColor: Colors.white,
            elevation: 8,
            indicatorColor: AppColors.primarySubtle,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home_rounded, color: AppColors.primary),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.grid_view_outlined),
                selectedIcon: Icon(Icons.grid_view_rounded, color: AppColors.primary),
                label: 'Courses',
              ),
              NavigationDestination(
                icon: Icon(Icons.school_outlined),
                selectedIcon: Icon(Icons.school_rounded, color: AppColors.primary),
                label: 'My Learning',
              ),
              NavigationDestination(
                icon: Icon(Icons.favorite_border_rounded),
                selectedIcon: Icon(Icons.favorite_rounded, color: AppColors.danger),
                label: 'Wishlist',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person_rounded, color: AppColors.primary),
                label: 'Account',
              ),
            ],
          ),
        ),
      );
    });
  }
}
