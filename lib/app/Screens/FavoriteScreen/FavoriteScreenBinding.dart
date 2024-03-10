import 'package:delevary/app/Screens/FavoriteScreen/FavoriteScreenController.dart';
import 'package:get/get.dart';

class FavoriteScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FavoriteScreenController());
  }
}
