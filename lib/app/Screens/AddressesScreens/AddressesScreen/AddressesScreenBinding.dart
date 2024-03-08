import 'package:delevary/app/Screens/AddressesScreens/AddressesScreen/AddressesScreenController.dart';
import 'package:get/get.dart';

class AddressesScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddressesScreenController());
  }
}
