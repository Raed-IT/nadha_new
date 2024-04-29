import 'package:delevary/app/Screens/Store/Products/UpdateProductScreen/UpdateProductScreenController.dart';
import 'package:get/get.dart';

class UpdateProductScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UpdateProductScreenController());
  }
}
