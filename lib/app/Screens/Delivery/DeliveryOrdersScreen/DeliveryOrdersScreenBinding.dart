 import 'package:get/get.dart';

import 'DeliveryOrdersScreenController.dart';

class DeliveryOrdersScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DeliveryOrdersScreenController());
  }
}
