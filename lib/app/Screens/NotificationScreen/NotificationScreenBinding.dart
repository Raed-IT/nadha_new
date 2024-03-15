import 'package:delevary/app/Screens/NotificationScreen/NotificationScreenController.dart';
import 'package:get/get.dart';

class NotificationScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NotificationScreenController());
  }
}
