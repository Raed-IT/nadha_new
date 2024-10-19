import 'package:delevary/app/Screens/v2/order_complete_screen/order_complete_screen_controller.dart';
import 'package:get/get.dart';

class OrderCompleteScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(OrderCompleteScreenController());
  }

}