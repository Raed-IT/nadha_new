import 'package:delevary/app/Screens/StoresScreens/ShowStoreScreen/ShowStoreScreenController.dart';
import 'package:get/get.dart';

class ShowStoreScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ShowStoreScreenController());
  }
}
