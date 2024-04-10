// import 'package:package_info_plus/package_info_plus.dart';

import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/Models/CategoryModel.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:delevary/app/Data/Models/SliderModel.dart';
import 'package:delevary/app/Screens/MainScaffoldSreen/MainScaffoldScreenController.dart';
 import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:helper/data/models/url_model.dart';
import 'package:helper/mixin/api_mixing.dart';
import 'package:helper/mixin/pagination_mixing.dart';
import 'package:logger/logger.dart';
import '../../Services/CartService.dart';
 class HomeScreenController extends GetxController
    with ApiHelperMixin, PaginationMixin<ProductModel> {
  RxList<CategoryModel> categories = RxList([]);
  RxList<SliderModel> sliders = RxList([]);

  final CartService cartService = CartService();
  final GlobalKey<CartIconKey> cartKey =
      Get.find<MainScaffoldScreenController>().cartKey;

  @override
  void onInit() {

    paginationUrl = ApiRoute.products;
    getFreshData();
    super.onInit();
  }


  test() async {

    // PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // String version = packageInfo.version;
    // String buildNumber = packageInfo.buildNumber;
    // Logger().w("version=>$version  buildNumber=>$buildNumber");
  }

  Future getFreshData() async {
    getPaginationData(isRefresh: true);
    await getSingleDataWithSync(
      url: UrlModel(url: ApiRoute.home, type: "home"),
    );
    paginationUrl = ApiRoute.products;
  }

  loadMore() {
    getPaginationData(isRefresh: false);
  }

  @override
  getDataFromJson({required Map<String, dynamic> json, String? type}) {
    if (json['status'] == "SUCCESS") {
      if (type == "home") {
        categories.value = [];
        for (var category in json['data']['categories']) {
          categories.add(CategoryModel.fromJson(category));
        }
        sliders.value = [];
        for (var slid in json['data']['sliders']) {
          sliders.add(SliderModel.fromJson(slid));
        }
      }
    } else {
      Fluttertoast.showToast(msg: json['data']?['message']);
    }
  }

  @override
  List<ProductModel> getModelFromPaginationJsonUsing(
      Map<String, dynamic> json) {
    List<ProductModel> products = [];
    for (var product in json['data']['products']) {
      products.add(ProductModel.fromJson(product));
    }
    return products;
  }

  @override
  String? getNextPageUrlFrom(Map<String, dynamic> json) {
    return json['data']['pagination']["next_page_url"];
  }
}
