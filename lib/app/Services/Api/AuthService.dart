// ignore_for_file: use_build_context_synchronously

import 'package:delevary/app/Components/DropDwon.dart';
import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/UserModel.dart';
import 'package:delevary/app/Services/LocaleStorageService.dart';
import 'package:delevary/app/Services/OneSignalService.dart';
import 'package:delevary/app/Services/UI/OverlayLoaderService.dart';
import 'package:delevary/app/Services/UI/ToastService.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:helper/mixin/api_mixing.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../Data/Models/CityModel.dart';

class AuthBySocialService with ApiHelperMixin {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signin(
      {required BuildContext context, required Function() onCompleted}) async {
    try {
      await _googleSignIn.signOut();
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      int counter = 1;
      while (account == null) {
        counter++;
        account = await _googleSignIn.signIn();
        if (counter == 5) {
          break;
        }
      }
      if (account == null) {
        Fluttertoast.showToast(msg: "حدث خطأ ما الرجاء المحازلة لاحقا");
        return;
      }
      CityModel? cityModel;
      await Get.defaultDialog(
        barrierDismissible: false,
        title: "اختر المدينة",
        content: DropDownComponent<CityModel>(
          hintText: "اختر المدينة",
          items: Get.find<MainController>().cities,
          initVal: Get.find<MainController>().user.value?.city,
          onSelected: (item) {
            cityModel = item;
            Get.back();
          },
        ),
      );
      String? deviceToken = await OnSignalService.getDeviceNotificationToken();
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.deviceInfo;
      final allInfo = deviceInfo.data;
      OverlayLoaderService.show(context);
      await postData(
          url: ApiRoute.loginBySocial,
          data: {
            "city_id": cityModel?.id,
            "name": account.displayName,
            "email": account.email,
            "password": "tasawoqe.password",
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
              onCompleted();
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
      OverlayLoaderService.hide();
    } catch (e) {
      Fluttertoast.showToast(msg: "$e");
    }
  }
}
