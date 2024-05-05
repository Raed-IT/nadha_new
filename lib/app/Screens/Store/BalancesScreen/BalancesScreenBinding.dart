import 'package:delevary/app/Screens/Store/BalancesScreen/BalancesScreenController.dart';
import 'package:get/get.dart';

class BalancesScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BalancesScreenController());
  }
}
