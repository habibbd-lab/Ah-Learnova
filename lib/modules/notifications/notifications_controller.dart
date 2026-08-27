import 'package:get/get.dart';
import '../../data/models/notification_model.dart';
import '../../data/static/static_data.dart';

class NotificationsController extends GetxController {
  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    notifications.assignAll(StaticData.notifications);
  }

  void markAllAsRead() {
    notifications.refresh();
    Get.snackbar('Notifications', 'All notifications marked as read.');
  }
}
