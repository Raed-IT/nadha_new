import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Services/LocaleStorageService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreenController extends GetxController {
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
}
