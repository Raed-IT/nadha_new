import 'package:get/get.dart';
import 'package:nadha/app/pages/order_details_screen/order_details_controller.dart';

class OrderDetailsScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OrderDetailsScreenController());
  }
}
