import 'package:delevary/app/Screens/Delivery/MapScreen/MapScreenController.dart';
import 'package:get/get.dart';

class MapScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MapScreenController());
  }
}
