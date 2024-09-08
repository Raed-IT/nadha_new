import 'package:get/get.dart';
import 'package:nadha/app/pages/offer_screen/offer_controller.dart';

class OfferScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OfferScreenController());
  }
}
