import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:get/get.dart';
import 'package:helper/data/models/url_model.dart';
import 'package:helper/mixin/api_mixing.dart';

class FavoriteScreenController extends GetxController with ApiHelperMixin {
  RxList<ProductModel> products = RxList([]);

  @override
  void onInit() {
    getDataFromApi();
    super.onInit();
  }

  getDataFromApi() {
    getSingleData(url: UrlModel(url: ApiRoute.favorites, type: "favorites"));
  }

  @override
  getDataFromJson({required Map<String, dynamic> json, String? type}) {
    if (type == "favorites") {
      products.value = [];
      for (var product in json['data']['products']) {
        products.add(ProductModel.fromJson(product));
      }
    }
  }
}
