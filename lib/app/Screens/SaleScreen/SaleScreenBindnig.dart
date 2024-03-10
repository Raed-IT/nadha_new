import 'package:delevary/app/Screens/SaleScreen/SaleScreenController.dart';
import 'package:get/get.dart';

class SaleScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SaleScreenController());
  }
}
