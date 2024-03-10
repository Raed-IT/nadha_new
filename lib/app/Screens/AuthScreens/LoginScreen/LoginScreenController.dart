import 'package:delevary/app/Services/Api/AuthService.dart';
import 'package:delevary/app/Services/UI/OverlayLoaderService.dart';
import 'package:delevary/app/Services/UI/ToastService.dart';
import 'package:delevary/app/data/ApiRoute.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:helper/mixin/api_mixing.dart';

import '../../../Data/Models/UserModel.dart';
import '../../../Route/Routs.dart';
import '../../../Services/LocaleStorageService.dart';
import '../../../Services/OneSignalService.dart';

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

  Future<void> login({required BuildContext context}) async {
    if (formKey.currentState!.validate()) {
      OverlayLoaderService.show(context);
      String? deviceToken = await OnSignalService.getDeviceNotificationToken();

      await postData(
          url: ApiRoute.login,
          data: {
            "email": emailTextController.text,
            "password": passwordTextController.text,
            if (deviceToken != null) "device_token": deviceToken
          },
          onSuccess: (res, ty) {
            if (res.data['status'] == "SUCCESS") {
              ToastService.showSuccessToast(
                  context: context, title: 'تم تـسجيل الدخول ');
              LocaleStorageService.setUserData(
                  user: UserModel.fromJson(res.data['data']['user']),
                  token: res.data['data']['token']);
              Get.offAllNamed(AppRoutes.mainScaffoldScreen);
            } else {
              ToastService.showErrorToast(
                  context: context,
                  title: 'خطاء في تسجيل الدخول  ',
                  description: res.data['data']['message']);
            }
          },
          onError: (ex, t) {
            ToastService.showErrorToast(
                context: context,
                title: 'خطاء في تسجيل الدخول  ',
                description: "${ex.statusCode ?? ''}");
          });
      Loader.hide();
    }
  }
}
