import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/UserModel.dart';
import 'package:delevary/app/Data/StorageController.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocaleStorageService {
  static void setUserData({required UserModel user, required String token}) {
    Get.find<MainController>().token.value = token;
    Get.find<MainController>().user.value = user;
    StorageController.setData(key: "token", value: token);
  }

  static void setThemMode({required ThemeMode theme}) {
    StorageController.setData(key: "them", value: theme.name);
  }

  static Future<void> getThemMode() async {
    if (StorageController.hasData(key: "them")) {
      String them = await StorageController.getData(key: "them");
      ThemeMode currentThem;
      if (them == ThemeMode.light.name) {
        currentThem = ThemeMode.light;
      } else if (them == ThemeMode.system.name) {
        currentThem = ThemeMode.system;
      } else {
        currentThem = ThemeMode.dark;
      }
      Get.find<MainController>().themeMode.value = currentThem;
    }
  }

  static Future<void> getUserData() async {
    String? token = await StorageController.getData(key: "token");
    Get.find<MainController>().token.value = token;
  }

  static Future<void> logOut() async {
    StorageController.removeKey(key: "token");
    Get.find<MainController>().token.value = null;
    Get.find<MainController>().user.value = null;
    Get.offAllNamed(AppRoutes.mainAuthScreen);
  }
}
