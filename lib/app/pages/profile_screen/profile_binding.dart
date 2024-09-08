import 'package:get/get.dart';
import 'package:nadha/app/pages/profile_screen/profile_controller%20.dart';

class ProfileScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileScreenController());
  }
}
