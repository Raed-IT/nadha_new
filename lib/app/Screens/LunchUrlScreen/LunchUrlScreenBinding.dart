import 'package:delevary/app/Screens/LunchUrlScreen/LunchUrlScreenController.dart';
import 'package:get/get.dart';

class LunchUrlScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LunchUrlScreenController());
  }
}
