import 'package:delevary/app/Screens/HomeScreen/HomeScreenController.dart';
import 'package:get/get.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeScreenController());
  }
}
