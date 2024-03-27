import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/Enums/GenderTypeEnum.dart';
import 'package:delevary/app/Data/Models/CityModel.dart';
import 'package:delevary/app/Data/Models/UserModel.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Services/LocaleStorageService.dart';
import 'package:delevary/app/Services/UI/OverlayLoaderService.dart';
import 'package:delevary/app/Services/UI/ToastService.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:helper/mixin/api_mixing.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../../Data/Enums/MaritalStatusEnum.dart';
import '../../../Services/Api/AuthService.dart';
import '../../../Services/OneSignalService.dart';

class RegisterScreenController extends GetxController with ApiHelperMixin {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();
  RxInt currentWidget = RxInt(0);
  RxBool keyboardVisible = RxBool(false);
  Rxn<GenderTypeEnum> gender = Rxn();
  Rxn<MaritalStatusEnum> maritalStatus = Rxn();
  CityModel? currentCity;

  Future<void> register(BuildContext context) async {
    if (gender.value == null) {
      ToastService.showErrorToast(
          context: context, title: 'الرجاء اختيار جميع الخيارات ');

      return;
    }
    if (maritalStatus.value == null) {
      ToastService.showErrorToast(
          context: context, title: 'الرجاء اختيار الحالة الإجتماعية ');

      return;
    }
    if (currentCity == null) {
      ToastService.showErrorToast(
          context: context, title: 'الرجاء اختيار المدينة ');
      Future.delayed(200.ms, () => currentWidget.value = 0);
      return;
    }
    OverlayLoaderService.show(context);
    String? deviceToken = await OnSignalService.getDeviceNotificationToken();

    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    final allInfo = deviceInfo.data;

    await postData(
        url: ApiRoute.register,
        data: {
          "name": nameTextController.text,
          "email": emailTextController.text,
          "password": passwordTextController.text,
          "city_id": currentCity?.id,
          if (deviceToken != null) "device_token": deviceToken,
          "android_id": allInfo['id'],
        },
        onSuccess: (res, ty) {
          if (res.data['status'] == "SUCCESS") {
            ToastService.showSuccessToast(
                context: context, title: 'تم تـسجيل الدخول ');
            LocaleStorageService.setUserData(
                user: UserModel.fromJson(res.data['data']['user']),
                token: res.data['data']['token']);
            OneSignal.shared.setExternalUserId(
                "${res.data['data']['user']['id']}${allInfo['id']}");
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

  Future<void> loginWithGoogle() async {
    AuthBySocialService authService = AuthBySocialService();
    authService.signin(onCompleted: (data) {
      Get.snackbar("تم ", data?.email ?? '');
    });
  }
}
