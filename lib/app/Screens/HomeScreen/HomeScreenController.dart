import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/Models/CategoryModel.dart';
import 'package:get/get.dart';
import 'package:helper/data/models/url_model.dart';
import 'package:helper/mixin/api_mixing.dart';
import 'package:logger/logger.dart';

class HomeScreenController extends GetxController with ApiHelperMixin {
  RxList<CategoryModel> categories = RxList([]);

  @override
  void onInit() {
    getSingleData(url: UrlModel(url: ApiRoute.home, type: "home"));
    super.onInit();
  }

  @override
  getDataFromJson({required Map<String, dynamic> json, String? type}) {
    categories.value = [];
    if (type == "home") {
      for (var category in json['data']) {
        categories.add(CategoryModel.fromJson(category));
      }
      Logger().w(categories);
    }
  }
}
