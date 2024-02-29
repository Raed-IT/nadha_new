import 'package:delevary/app/Screens/AuthScreens/RegisterScreen/RegisterScreenController.dart';
import 'package:get/get.dart';

class RegisterScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RegisterScreenController());
  }
}
