import 'package:get/get.dart';
import 'package:nadha/app/pages/home_screen/home_controller.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeScreenController());
  }
}
