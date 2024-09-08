import 'package:get/get.dart';
import 'package:nadha/app/pages/vendor_store_screen/store_controller.dart';

class StoreScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StoreScreenController());
  }
}
