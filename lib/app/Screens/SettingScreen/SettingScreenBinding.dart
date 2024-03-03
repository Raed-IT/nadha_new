import 'package:delevary/app/Screens/SettingScreen/SettingScreenController.dart';
import 'package:get/get.dart';

class SettingScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SettingScreenController());
  }
}
