import 'package:delevary/app/Screens/Store/Sliders/SlidersScreen/SlidersScreenController.dart';
import 'package:get/get.dart';

class SlidersStoreScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SlidersStoreScreenController());
  }
}
