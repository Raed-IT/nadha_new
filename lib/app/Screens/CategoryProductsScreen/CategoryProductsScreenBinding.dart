import 'package:delevary/app/Screens/CategoryProductsScreen/CategoryProductsScreenController.dart';
import 'package:get/get.dart';

class CategoryProductsScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CategoryProductsScreenController());
  }
}
