import 'package:delevary/app/data/ApiRoute.dart';
import 'package:delevary/app/data/MainController.dart';
import 'package:delevary/app/data/Models/CityModel.dart';
import 'package:delevary/app/data/Models/SettingModel.dart';
import 'package:delevary/app/route/Routs.dart';
import 'package:get/get.dart';
import 'package:helper/data/models/url_model.dart';
import 'package:helper/mixin/api_mixing.dart';
import 'package:helper/utility/api_exceptions.dart';
import 'package:logger/logger.dart';

class SplashScreenController extends GetxController with ApiHelperMixin {
  @override
  void onReady() {
    // urls = [
    //   UrlModel(url: ApiRoute.settings, type: 'settings'),
    // ];
    getSingleData(url: UrlModel(url: ApiRoute.settings, type: "settings"));
    //
    // Future.delayed(
    //     Duration(seconds: 3), () => Get.offNamed(AppRoutes.mainAuthScreen));
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
    Get.find<MainController>().cities.value = cities;
  }
}
