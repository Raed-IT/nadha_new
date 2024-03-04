import 'package:delevary/app/Data/Models/UserModel.dart';
import 'package:delevary/app/Services/LocaleStorageService.dart';
import 'package:delevary/app/data/Models/CityModel.dart';
import 'package:delevary/app/data/Models/SettingModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helper/data/constant.dart';

class MainController extends GetxController {
  // @override
  // void onReady() {
  //   LocaleStorageService.logOut();
  //   super.onReady();
  // }
  Rxn<String> token = Rxn(null);
  Rxn<UserModel> user = Rxn(null);
  Rxn<SettingModel> setting = Rxn<SettingModel>();
  RxList<CityModel> cities = RxList<CityModel>();
  Rx<ThemeMode> themeMode = Rx(ThemeMode.dark);

  @override
  void onInit() {
    token.listen((p0) {
      HelperConstant.globalHeader['Authorization'] = 'Bearer $p0';
    });
    LocaleStorageService.getThemMode();
    super.onInit();
  }
}
