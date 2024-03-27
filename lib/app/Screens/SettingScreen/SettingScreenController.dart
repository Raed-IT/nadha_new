import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Services/LocaleStorageService.dart';
import 'package:delevary/app/Services/UI/OverlayLoaderService.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helper/mixin/api_mixing.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class SettingScreenController extends GetxController with ApiHelperMixin {
  void treggerDarkMode() {
    if (Get.find<MainController>().themeMode.value == ThemeMode.dark) {
      Get.find<MainController>().themeMode.value = ThemeMode.light;
    } else {
      Get.find<MainController>().themeMode.value = ThemeMode.dark;
    }
    LocaleStorageService.setThemMode(
        theme: Get.find<MainController>().themeMode.value);
  }

  void changeDarkModeToSystem() {
    if (Get.find<MainController>().themeMode.value != ThemeMode.system) {
      Get.find<MainController>().themeMode.value = ThemeMode.system;
    } else {
      Get.find<MainController>().themeMode.value = ThemeMode.light;
    }
  }

  logout(BuildContext context) async {
    OverlayLoaderService.show(context);
    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    final allInfo = deviceInfo.data;
    await postData(
        url: ApiRoute.logout,
        data: {
          "device_id":
              "${Get.find<MainController>().user.value?.id}${allInfo['id']}"
        },
        onSuccess: (res, t) {
          LocaleStorageService.logOut();
          OneSignal.shared.removeExternalUserId();
          Get.offAllNamed(AppRoutes.mainAuthScreen);
        },
        onError: (ex, t) {});
    OverlayLoaderService.hide();
  }
}
