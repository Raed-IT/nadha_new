import 'package:delevary/app/Data/Models/CategoryModel.dart';
import 'package:delevary/app/data/ApiRoute.dart';
import 'package:get/get.dart';
import 'package:helper/data/models/url_model.dart';
import 'package:helper/mixin/api_mixing.dart';

class CategoriesScreenController extends GetxController with ApiHelperMixin {
  CategoryModel category = Get.arguments['category'];
  RxList<CategoryModel> categories = RxList([]);

  @override
  void onInit() {
    getSingleData(
        url: UrlModel(
            url: "${ApiRoute.categories}/${category.id}", type: "categories"));
    super.onInit();
  }

  @override
  getDataFromJson({required Map<String, dynamic> json, String? type}) {
    for (var category in json['data']['categories']) {
      categories.add(CategoryModel.fromJson(category));
    }
  }
}
