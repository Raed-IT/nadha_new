import 'package:delevary/app/Screens/Store/Products/AddProductScreen/AddProductScreenController.dart';
import 'package:get/get.dart';

class AddProductScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddProductScreenController());
  }
}
