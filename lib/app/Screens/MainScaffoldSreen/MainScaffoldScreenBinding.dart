import 'package:delevary/app/Screens/HomeScreen/HomeScreenController.dart';
import 'package:delevary/app/Screens/MainScaffoldSreen/MainScaffoldScreenController.dart';
import 'package:delevary/app/Screens/ProfileScreen/ProfileScreenController.dart';
import 'package:delevary/app/Screens/SaleScreen/SaleScreenController.dart';
import 'package:delevary/app/Screens/StoresScreens/StoresScreen/StoresScreenController.dart';
import 'package:get/get.dart';

class MainScaffoldScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainScaffoldScreenController(), permanent: true);
    Get.lazyPut(() => HomeScreenController());
    Get.lazyPut(() => SaleScreenController());
    Get.lazyPut(() => StoresScreenController());
    Get.lazyPut(() => ProfileScreenController());
  }
}
