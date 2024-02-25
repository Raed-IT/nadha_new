import 'package:delevary/app/Screens/SplashScreen/SplashController.dart';
import 'package:get/get.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashScreenController());
  }
}
