import 'package:delevary/app/Screens/AuthScreens/MainAuthScreen/MainAuthController.dart';
import 'package:get/get.dart';

class MainAuthScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainAuthScreenController());
  }
}
