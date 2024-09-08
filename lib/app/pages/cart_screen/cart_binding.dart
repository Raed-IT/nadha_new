import 'package:get/get.dart';
import 'package:nadha/app/pages/cart_screen/cart_controller.dart';

class CartScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CartScreenController());
  }
}
