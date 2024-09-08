import 'package:get/get.dart';
import 'package:nadha/app/pages/product_details_screen/product_details_controller.dart';

class ProductDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductDetailsController());
  }
}
