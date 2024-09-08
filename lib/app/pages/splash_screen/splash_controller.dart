import 'package:get/get.dart';
import 'package:helper_plugin/helper.dart';
import 'package:helper_plugin/utilitis/url_model.dart';
import 'package:nadha/app/data/api_routs.dart';
import 'package:nadha/app/data/inital/main_controller.dart';
import 'package:nadha/app/data/model/city_model.dart';
import 'package:nadha/app/data/model/setting_model.dart';
import '../../data/helper.dart';
import '../../route/routs.dart';

class SplashController extends GetxController with ApiHelperMixin {
  @override
  void onInit() {
    urlsGetRequest = [
      UrlModel(url: ApiRouts.cities),
    ];
    getAppData();
    super.onInit();
  }

  Future<void> getAppData() async {
    await getData().then((value) => Get.offAllNamed(AppRoutes.HOME_SCREEN));
  }

  @override
  void getModelFromJsonUsing(json, String urlType) async {
    Get.find<MainController>().setting = Rx(
      SettingModel.fromJson(json['data']['settings']),
    );
    Get.find<MainController>().notificationsCount.value =
        int.tryParse("${json['data']['count']}") ?? 0;
    for (var city in json['data']['cities']) {
      Get.find<MainController>().cities.add(CityModel.fromJson(city));
    }

    await Helper.getCartsFromLocaleStorage();
  }
}
