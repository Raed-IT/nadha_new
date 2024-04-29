import 'package:delevary/app/Screens/Store/Sliders/UpdateSliderScreen/UpdateSliderScreenController.dart';
import 'package:get/get.dart';

class UpdateSliderScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UpdateSliderScreenController());
  }
}
