import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/Models/CategoryModel.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:get/get.dart';
import 'package:helper/data/models/url_model.dart';
import 'package:helper/mixin/api_mixing.dart';

class CategoryProductsScreenController extends GetxController
    with ApiHelperMixin {
  CategoryModel category = Get.arguments['category'];
  RxList<ProductModel> products = RxList([]);

  @override
  void onInit() {
    getSingleData(
        url: UrlModel(
            url: ApiRoute.products,
            type: "products",
            parameter: {"category_id": category.id}));
    super.onInit();
  }

  @override
  getDataFromJson({required Map<String, dynamic> json, String? type}) {
    if (type == "products") {
      for (var product in json['data']['products']) {
        products.add(ProductModel.fromJson(product));
      }
    }
  }
}
