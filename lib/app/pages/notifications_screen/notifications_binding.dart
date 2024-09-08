import 'package:get/get.dart';
import 'package:nadha/app/pages/notifications_screen/notifications_controller.dart';

class NotificationsScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NotificationsScreenController());
  }
}
