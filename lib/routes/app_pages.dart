import 'package:get/get.dart';
import 'app_routes.dart';
import '../modules/splash/splash_view.dart';
import '../modules/splash/splash_binding.dart';
import '../modules/main_nav/main_nav_view.dart';
import '../modules/main_nav/main_nav_binding.dart';
import '../modules/auth/login_view.dart';
import '../modules/auth/register_view.dart';
import '../modules/auth/profile_view.dart';
import '../modules/auth/auth_binding.dart';
import '../modules/courses/courses_view.dart';
import '../modules/courses/courses_binding.dart';
import '../modules/course_details/course_details_view.dart';
import '../modules/course_details/course_details_binding.dart';
import '../modules/compare/compare_view.dart';
import '../modules/compare/compare_binding.dart';
import '../modules/learning/learning_view.dart';
import '../modules/learning/learning_player_view.dart';
import '../modules/learning/learning_binding.dart';
import '../modules/quiz/quiz_take_view.dart';
import '../modules/quiz/quiz_result_view.dart';
import '../modules/quiz/quiz_binding.dart';
import '../modules/certificate/certificate_view.dart';
import '../modules/certificate/certificate_print_view.dart';
import '../modules/certificate/certificate_verify_view.dart';
import '../modules/certificate/certificate_binding.dart';
import '../modules/wishlist/wishlist_view.dart';
import '../modules/wishlist/wishlist_binding.dart';
import '../modules/checkout/checkout_view.dart';
import '../modules/checkout/checkout_success_view.dart';
import '../modules/checkout/checkout_binding.dart';
import '../modules/instructor/instructor_dashboard_view.dart';
import '../modules/instructor/instructor_course_builder_view.dart';
import '../modules/instructor/instructor_earnings_view.dart';
import '../modules/instructor/instructor_binding.dart';
import '../modules/admin/admin_dashboard_view.dart';
import '../modules/admin/admin_binding.dart';
import '../modules/notifications/notifications_view.dart';
import '../modules/notifications/notifications_binding.dart';

class AppPages {
  AppPages._();

  static const initial = AppRoutes.splash;

  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => const MainNavView(),
      binding: MainNavBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.courses,
      page: () => const CoursesView(),
      binding: CoursesBinding(),
    ),
    GetPage(
      name: AppRoutes.courseDetails,
      page: () => const CourseDetailsView(),
      binding: CourseDetailsBinding(),
    ),
    GetPage(
      name: AppRoutes.compare,
      page: () => const CompareView(),
      binding: CompareBinding(),
    ),
    GetPage(
      name: AppRoutes.learning,
      page: () => const LearningView(),
      binding: LearningBinding(),
    ),
    GetPage(
      name: AppRoutes.learningPlayer,
      page: () => const LearningPlayerView(),
      binding: LearningBinding(),
    ),
    GetPage(
      name: AppRoutes.quizTake,
      page: () => const QuizTakeView(),
      binding: QuizBinding(),
    ),
    GetPage(
      name: AppRoutes.quizResult,
      page: () => const QuizResultView(),
      binding: QuizBinding(),
    ),
    GetPage(
      name: AppRoutes.certificates,
      page: () => const CertificateView(),
      binding: CertificateBinding(),
    ),
    GetPage(
      name: AppRoutes.certificatePrint,
      page: () => const CertificatePrintView(),
      binding: CertificateBinding(),
    ),
    GetPage(
      name: AppRoutes.certificateVerify,
      page: () => const CertificateVerifyView(),
      binding: CertificateBinding(),
    ),
    GetPage(
      name: AppRoutes.wishlist,
      page: () => const WishlistView(),
      binding: WishlistBinding(),
    ),
    GetPage(
      name: AppRoutes.checkout,
      page: () => const CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: AppRoutes.checkoutSuccess,
      page: () => const CheckoutSuccessView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: AppRoutes.instructorDashboard,
      page: () => const InstructorDashboardView(),
      binding: InstructorBinding(),
    ),
    GetPage(
      name: AppRoutes.instructorBuilder,
      page: () => const InstructorCourseBuilderView(),
      binding: InstructorBinding(),
    ),
    GetPage(
      name: AppRoutes.instructorEarnings,
      page: () => const InstructorEarningsView(),
      binding: InstructorBinding(),
    ),
    GetPage(
      name: AppRoutes.adminDashboard,
      page: () => const AdminDashboardView(),
      binding: AdminBinding(),
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
  ];
}
