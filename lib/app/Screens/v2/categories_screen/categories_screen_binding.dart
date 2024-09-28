 import 'package:delevary/app/Screens/v2/categories_screen/categories_screen_controller.dart';
import 'package:get/get.dart';

class CategoriesScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(CategoriesScreenController());
  }

}