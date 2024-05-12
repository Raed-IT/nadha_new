import 'package:delevary/app/Screens/Store/Orders/OrderStoreScreenController.dart';
import 'package:get/get.dart';

class OrderStoreScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OrderStoreScreenController());
  }
}
