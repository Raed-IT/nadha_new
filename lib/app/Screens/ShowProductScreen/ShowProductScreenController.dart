import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:delevary/app/Data/Models/StoreModel.dart';
import 'package:delevary/app/Mixins/AddToCartMixin.dart';
import 'package:delevary/app/Services/CartService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helper/data/models/url_model.dart';
import 'package:helper/mixin/api_mixing.dart';

class ShowProductScreenController extends GetxController
    with ApiHelperMixin, AddToCartMixin {
  StoreModel? store = Get.arguments['store'];
  String? heroPrefix = Get.arguments?["hero"];
  Rx<ProductModel> product = Rx(Get.arguments?['product']);
  RxList<ProductModel> products = RxList([]);
  CartService cartService = CartService();
  RxBool showExtendedImage = RxBool(true);

  @override
  void onInit() {
    getSingleData(
      url: UrlModel(
        url: ApiRoute.products,
        type: "products",
        parameter: {
          "category_id": product.value.category?.id,
          if (store != null) "store_id": store?.id,
        },
      ),
    );

    super.onInit();
  }

  void listenerToController(
      DraggableScrollableController draggableScrollableController) {
    draggableScrollableController.addListener(() {
      if (draggableScrollableController.pixels > Get.height * 0.8) {
        showExtendedImage.value = false;
      } else {
        showExtendedImage.value = true;
      }
    });
    super.onReady();
  }

  @override
  getDataFromJson({required Map<String, dynamic> json, String? type}) {
    if (type == "products") {
      for (var productJson in json['data']['products']) {
        ProductModel productModel = ProductModel.fromJson(productJson);
        if (productModel.id != product.value.id) {
          products.add(productModel);
        }
      }
    }
  }
}
