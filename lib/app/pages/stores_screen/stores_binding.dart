import 'package:get/get.dart';
import 'package:nadha/app/pages/stores_screen/stores_controller.dart';

class StoresScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StoresScreenController());
  }
}
