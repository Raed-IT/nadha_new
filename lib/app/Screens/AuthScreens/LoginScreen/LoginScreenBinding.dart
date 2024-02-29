import 'package:delevary/app/Screens/AuthScreens/LoginScreen/LoginScreenController.dart';
import 'package:get/get.dart';

class LoginScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginScreenController());
  }
}
