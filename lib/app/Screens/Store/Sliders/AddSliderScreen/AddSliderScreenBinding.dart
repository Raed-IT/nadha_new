import 'package:delevary/app/Screens/Store/Sliders/AddSliderScreen/AddSliderScreenController.dart';
import 'package:get/get.dart';

class AddSliderScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddSliderScreenController());
  }
}
