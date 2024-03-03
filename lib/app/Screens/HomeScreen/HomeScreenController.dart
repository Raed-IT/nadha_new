import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/CategoryModel.dart';
import 'package:delevary/app/Data/Models/SliderModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:helper/data/models/url_model.dart';
import 'package:helper/mixin/api_mixing.dart';
import 'package:logger/logger.dart';

class HomeScreenController extends GetxController with ApiHelperMixin {
  RxList<CategoryModel> categories = RxList([]);
  RxList<SliderModel> sliders = RxList([]);

  @override
  void onInit() {
    getSingleData(url: UrlModel(url: ApiRoute.home, type: "home"));
    super.onInit();
  }

  @override
  getDataFromJson({required Map<String, dynamic> json, String? type}) {
    categories.value = [];
    if (type == "home" && json['status'] == "SUCCESS") {
      for (var category in json['data']['categories']) {
        categories.add(CategoryModel.fromJson(category));
      }
      for (var slid in json['data']['sliders']) {
        sliders.add(SliderModel.fromJson(slid));
      }
    } else {
      Fluttertoast.showToast(msg: json['data']?['message']);
    }
  }
}
