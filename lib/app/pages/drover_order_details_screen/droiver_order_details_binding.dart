import 'package:get/get.dart';
import 'package:nadha/app/pages/drover_order_details_screen/driver_order_details_controller.dart';

class DriverOrderDetailsScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DriverOrderDetailsScreenController());
  }
}
