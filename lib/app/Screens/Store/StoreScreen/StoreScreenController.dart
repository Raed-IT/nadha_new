import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/StoreModel.dart';
import 'package:delevary/app/Data/Models/StoreStatisticsModel.dart';
import 'package:get/get.dart';
import 'package:helper/data/models/url_model.dart';
import 'package:helper/mixin/api_mixing.dart';
import 'package:logger/logger.dart';

class StoreScreenController extends GetxController with ApiHelperMixin {
  StoreModel store = Get.find<MainController>().user.value!.store!;
  Rxn<StoreStatisticsModel> statistics = Rxn();

  @override
  void onInit() {
    super.onInit();
    getSingleData(
        url: UrlModel(
            url: "${ApiRoute.stores}/profile/${store.id}", type: "store"));
  }

  @override
  getDataFromJson({required Map<String, dynamic> json, String? type}) {
    statistics.value = StoreStatisticsModel.fromJson(json['data']['data']);
  }
}
