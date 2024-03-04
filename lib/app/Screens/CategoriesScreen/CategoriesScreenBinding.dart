import 'package:delevary/app/Screens/CategoriesScreen/CategoriesScreenController.dart';
import 'package:get/get.dart';

class CategoriesScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CategoriesScreenController());
  }
}
