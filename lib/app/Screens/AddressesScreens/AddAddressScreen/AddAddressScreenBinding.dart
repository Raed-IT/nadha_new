import 'package:delevary/app/Screens/AddressesScreens/AddAddressScreen/AddAddressScreenController.dart';
import 'package:get/get.dart';

class AddAddressScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddAddressScreenController());
  }
}
