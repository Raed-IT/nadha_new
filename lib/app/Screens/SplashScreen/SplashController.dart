import 'dart:math';

import 'package:delevary/app/Data/Models/UserModel.dart';
import 'package:delevary/app/Services/LocaleStorageService.dart';
import 'package:delevary/app/Services/deepLinkService.dart';
import 'package:delevary/app/data/ApiRoute.dart';
import 'package:delevary/app/Data/Models/CityModel.dart';
import 'package:delevary/app/data/Models/SettingModel.dart';
import 'package:delevary/app/route/Routs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:helper/data/models/url_model.dart';
import 'package:helper/mixin/api_mixing.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../Data/MainController.dart';

class SplashScreenController extends GetxController with ApiHelperMixin {
  late DateTime startTime;
  bool hasError = false;

  @override
  void onReady() {
    getFreshData();
    super.onReady();
  }

  getFreshData() {
    Logger().w(Get.find<MainController>().token.value);
    hasError = false;
    startTime = DateTime.now();
    String token =
        "${Get.find<MainController>().token.value}${generateRandomString(5)}";
    Logger().w(token);
    getSingleData(
      url: UrlModel(url: ApiRoute.settings, type: "settings", parameter: {
        if (Get.find<MainController>().token.value != null) "token": token
      }),
      onError: () {
        hasError = true;
      },
    );
  }

  @override
  getDataFromJson({required Map<String, dynamic> json, String? type}) async {
    Get.find<MainController>().setting.value =
        SettingModel.fromJson(json['data']['setting']);
    List<CityModel> cities = [];
    for (var city in json['data']['cities']) {
      cities.add(CityModel.fromJson(city));
    }
    if (json['data'].containsKey("user")) {
      Get.find<MainController>().user.value =
          UserModel.fromJson(json['data']['user']);
    } else {
      LocaleStorageService.deleteUserData();
    }

    DateTime now = DateTime.now();
    if (now.difference(startTime) > 3.seconds) {
      Get.find<MainController>().cities.value = cities;
      Get.offAllNamed(AppRoutes.mainScaffoldScreen);
    } else {
      Future.delayed(
        2.seconds - now.difference(startTime),
        () {
          Get.find<MainController>().cities.value = cities;
          Get.offAllNamed(AppRoutes.mainScaffoldScreen);
        },
      );
    }
  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }
}
