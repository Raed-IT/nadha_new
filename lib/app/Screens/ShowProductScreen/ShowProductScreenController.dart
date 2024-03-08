import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:delevary/app/Mixins/AddToCartMixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:helper/data/models/url_model.dart';
import 'package:helper/mixin/api_mixing.dart';

class ShowProductScreenController extends GetxController
    with ApiHelperMixin, AddToCartMixin {
  String? heroPrefix = Get.arguments?["hero"];
  Rx<ProductModel> product = Rx(Get.arguments?['product']);
  RxList<ProductModel> products = RxList([]);


  @override
  void onInit() {
    getSingleData(
      url: UrlModel(
        url: ApiRoute.products,
        type: "products",
        parameter: {
          "category_id": product.value.category?.id,
        },
      ),
    );
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
