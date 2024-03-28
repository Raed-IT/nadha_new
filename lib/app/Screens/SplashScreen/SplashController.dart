import 'package:delevary/app/Data/Models/UserModel.dart';
import 'package:delevary/app/data/ApiRoute.dart';
import 'package:delevary/app/Data/Models/CityModel.dart';
import 'package:delevary/app/data/Models/SettingModel.dart';
import 'package:delevary/app/route/Routs.dart';
import 'package:get/get.dart';
import 'package:helper/data/models/url_model.dart';
import 'package:helper/mixin/api_mixing.dart';
import 'package:logger/logger.dart';

import '../../Data/MainController.dart';

class SplashScreenController extends GetxController with ApiHelperMixin {
  late DateTime startTime ;
  @override
  void onReady() {
    startTime=DateTime.now();
    getSingleData(
        url: UrlModel(
            url: ApiRoute.settings,
            type: "settings",
            parameter: {"token": Get.find<MainController>().token.value}));
    super.onReady();
  }

  @override
  getDataFromJson({required Map<String, dynamic> json, String? type}) {
    Get.find<MainController>().setting.value =
        SettingModel.fromJson(json['data']['setting']);
    List<CityModel> cities = [];
    for (var city in json['data']['cities']) {
      cities.add(CityModel.fromJson(city));
    }
    if (json['data'].containsKey("user")) {
      Get.find<MainController>().user.value =
          UserModel.fromJson(json['data']['user']);
    }

    DateTime now = DateTime.now();
    if (now.difference(startTime) > 3.seconds) {
      Get.find<MainController>().cities.value = cities;
      Get.offAllNamed(AppRoutes.mainScaffoldScreen);
    } else {
      Future.delayed(
        3.seconds - now.difference(startTime),
        () {
          Get.find<MainController>().cities.value = cities;
          Get.offAllNamed(AppRoutes.mainScaffoldScreen);
        },
      );
    }
  }
}
