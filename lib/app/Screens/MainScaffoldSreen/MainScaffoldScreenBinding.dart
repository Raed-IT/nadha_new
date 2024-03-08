import 'package:delevary/app/Screens/HomeScreen/HomeScreenController.dart';
import 'package:delevary/app/Screens/MainScaffoldSreen/MainScaffoldScreenController.dart';
import 'package:get/get.dart';

class MainScaffoldScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainScaffoldScreenController());
    Get.lazyPut(() => HomeScreenController());
  }
}
