import 'package:delevary/app/Screens/v2/starter_pages_screen/starter_pages_screen_controller.dart';
import 'package:get/get.dart';

class StarterPageScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(StarterPageScreenController());
  }

}