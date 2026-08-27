abstract class AppRoutes {
  AppRoutes._();

  static const splash = '/splash';
  static const main = '/main';
  static const home = '/home';
  static const login = '/auth/login';
  static const register = '/auth/register';
  static const profile = '/auth/profile';

  static const courses = '/courses';
  static const courseDetails = '/courses/details';
  static const compare = '/compare';

  static const learning = '/learning';
  static const learningPlayer = '/learning/player';

  static const quizTake = '/quiz/take';
  static const quizResult = '/quiz/result';

  static const certificates = '/certificates';
  static const certificatePrint = '/certificate/print';
  static const certificateVerify = '/certificate/verify';

  static const wishlist = '/wishlist';
  static const checkout = '/checkout';
  static const checkoutSuccess = '/checkout/success';

  static const instructorDashboard = '/instructor/dashboard';
  static const instructorBuilder = '/instructor/builder';
  static const instructorEarnings = '/instructor/earnings';

  static const adminDashboard = '/admin/dashboard';
  static const notifications = '/notifications';
}
