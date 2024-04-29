import 'package:delevary/app/Screens/Store/Categories/CategoriesScreen/CategoriesScreenController.dart';
import 'package:get/get.dart';

class CategoriesStoreScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CategoriesStoreScreenController());
  }
}
