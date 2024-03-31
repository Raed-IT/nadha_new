import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Services/Api/AuthService.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MainAuthScreenController extends GetxController {
  loginWithGoogle(BuildContext context) {
    AuthBySocialService auth = AuthBySocialService();
    auth.signin(
        context: context,
        onCompleted: () => Get.offAllNamed(AppRoutes.mainScaffoldScreen));
  }
}
