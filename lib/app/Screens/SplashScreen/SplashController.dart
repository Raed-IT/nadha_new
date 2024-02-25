import 'package:delevary/app/route/Routs.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  @override
  void onReady() {
    Future.delayed(
        Duration(seconds: 3), () => Get.offNamed(AppRoutes.mainAuthScreen));
    super.onReady();
  }
}
