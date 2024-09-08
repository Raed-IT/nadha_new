import 'package:get/get.dart';
import 'package:nadha/app/pages/show_store_screen/show_store_controller.dart';

class ShowStoreScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ShowStoreScreenController());
  }
}
