import 'package:delevary/app/data/ApiRoute.dart';
 import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:helper/mixin/api_mixing.dart';

import '../../../services/AuthService.dart';

class LoginScreenController extends GetxController with ApiHelperMixin {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  RxBool keyboardVisible = RxBool(false);

  Future<void> loginWithGoogle() async {
    AuthBySocialService authService = AuthBySocialService();

    authService.signin(onCompleted: (data) {
      Get.snackbar("تم ", data?.email ?? '');
    });
  }

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      postData(
          url: ApiRoute.login,
          data: {},
          onSuccess: (res, t) {},
          onError: (res, t) {
          });
    }
  }
}
