import 'package:get/get.dart';
import 'package:nadha/app/pages/balance_screen/balance_controller.dart';

class BalanceScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BalanceScreenController());
  }
}
