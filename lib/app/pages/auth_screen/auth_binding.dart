import 'package:get/get.dart';
import 'package:nadha/app/pages/auth_screen/auth_controller.dart';

class AuthScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthScreenController());
  }
}
