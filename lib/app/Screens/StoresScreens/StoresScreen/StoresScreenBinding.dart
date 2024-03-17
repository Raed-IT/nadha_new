import 'package:delevary/app/Screens/StoresScreens/StoresScreen/StoresScreenController.dart';
import 'package:get/get.dart';

class StoresScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StoresScreenController());
  }
}
