 import 'package:get/get.dart';

import 'ProductsScreenController.dart';

class StoreProductsScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StoreProductsScreenController());
  }
}
