import 'package:delevary/app/Components/v2/address_list_component/controller.dart';
import 'package:delevary/app/Screens/AddressesScreens/AddressesScreen/AddressesScreenController.dart';
import 'package:get/get.dart';

class AddressesScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddressListController());
    Get.put(AddressesScreenController());
  }
}
