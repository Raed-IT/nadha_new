import 'package:delevary/app/Screens/ProfileScreen/ProfileScreenController.dart';
import 'package:get/get.dart';

class ProfileScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileScreenController());
  }
}
