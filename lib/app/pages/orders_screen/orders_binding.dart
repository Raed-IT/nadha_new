import 'package:get/get.dart';
import 'package:nadha/app/pages/orders_screen/orders_controller.dart';

class OrdersScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OrdersScreenController());
  }
}
