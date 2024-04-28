import 'package:delevary/app/Screens/Store/Products/ProductsScreenController.dart';
import 'package:get/get.dart';

class StoreProductsScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StoreProductsScreenController());
  }
}
