 import 'package:get/get.dart';
import 'package:nadha/app/pages/splash_screen/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
