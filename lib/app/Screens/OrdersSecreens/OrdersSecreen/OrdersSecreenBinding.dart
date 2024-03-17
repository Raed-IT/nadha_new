import 'package:delevary/app/Screens/OrdersSecreens/OrdersSecreen/OrdersSecreenController.dart';
import 'package:get/get.dart';

class OrdersSecreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OrdersSecreenController());
  }
}
