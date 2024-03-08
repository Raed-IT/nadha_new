import 'package:delevary/app/Screens/CartScreen/CartScreenController.dart';
import 'package:get/get.dart';

class CartScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CartScreenController());
  }
}
