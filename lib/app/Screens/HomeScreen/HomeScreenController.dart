import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/Models/CategoryModel.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:delevary/app/Data/Models/SliderModel.dart';
import 'package:delevary/app/Mixins/AddToCartMixin.dart';
import 'package:delevary/app/Screens/MainScaffoldSreen/MainScaffoldScreenController.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:helper/data/models/url_model.dart';
import 'package:helper/mixin/api_mixing.dart';
import '../../Services/CartService.dart';

class HomeScreenController extends GetxController with ApiHelperMixin {
  RxList<CategoryModel> categories = RxList([]);
  RxList<SliderModel> sliders = RxList([]);
  RxList<ProductModel> products = RxList([]);
  final CartService cartService = CartService();
  final GlobalKey<CartIconKey> cartKey =
      Get.find<MainScaffoldScreenController>().cartKey;

  @override
  void onInit() {
    getSingleData(url: UrlModel(url: ApiRoute.home, type: "home"));
    super.onInit();
  }

  addToCart(ProductModel product, GlobalKey key) {
    cartService.addToCard(product: product);
    Get.find<MainScaffoldScreenController>()
        .addToCartAnimation(widgetKey: key, cartKey: cartKey);
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
      for (var slid in json['data']['products']) {
        products.add(ProductModel.fromJson(slid));
      }
    } else {
      Fluttertoast.showToast(msg: json['data']?['message']);
    }
  }
}
