import 'package:delevary/app/Components/v2/address_list_component/controller.dart';
import 'package:delevary/app/Screens/v2/checkout_screen/checkout_screen_controller.dart';
import 'package:get/get.dart';

class CheckoutScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(AddressListController());
    Get.put(CheckoutScreenController());
  }

}