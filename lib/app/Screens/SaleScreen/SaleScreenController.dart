import 'package:get/get.dart';
import 'package:helper/data/models/url_model.dart';
import 'package:helper/mixin/api_mixing.dart';

import '../../Data/ApiRoute.dart';
import '../../Data/Models/ProductModel.dart';

class SaleScreenController extends GetxController with ApiHelperMixin {
  RxList<ProductModel> products = RxList([]);

  @override
  void onInit() {
    getDataFromApi();
    super.onInit();
  }

  getDataFromApi() {
    getSingleData(
        url: UrlModel(url: "${ApiRoute.products}/sale", type: "sale"));
  }

  @override
  getDataFromJson({required Map<String, dynamic> json, String? type}) {
    if (type == "sale") {
      products.value = [];
      for (var product in json['data']['products']) {
        products.add(ProductModel.fromJson(product));
      }
    }
  }
}
