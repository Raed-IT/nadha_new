import 'package:get/get.dart';
import 'package:nadha/app/pages/address_screen/address_controller.dart';

class AddressScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddressScreenController());
  }
}
