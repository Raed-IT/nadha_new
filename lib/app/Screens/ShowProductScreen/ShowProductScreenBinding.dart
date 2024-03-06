import 'package:delevary/app/Screens/ShowProductScreen/ShowProductScreenController.dart';
import 'package:get/get.dart';

class ShowProductScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ShowProductScreenController());
  }
}
