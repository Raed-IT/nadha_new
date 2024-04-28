import 'package:delevary/app/Screens/Store/StoreScreen/StoreScreenController.dart';
import 'package:get/get.dart';

class StoreScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(StoreScreenController());
  }

}