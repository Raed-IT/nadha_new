import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:helper_plugin/helper.dart';
import 'package:helper_plugin/utilitis/url_model.dart';
import 'package:logger/logger.dart';
import 'package:nadha/app/data/api_routs.dart';
import 'package:nadha/app/data/helper.dart';
import 'package:nadha/app/data/inital/main_controller.dart';
import '../../data/model/cart_item_model.dart';
import 'componnets/build_card.dart';

class CartScreenController extends GetxController with ApiHelperMixin {
  final lisKey = GlobalKey<AnimatedListState>();

  // saved card in address controller ....
  @override
  void onInit() {
    urlsGetRequest = [UrlModel(url: ApiRouts.cart, type: "cart")];
    getData();
    super.onInit();
  }

  @override
  void getModelFromJsonUsing(json, String urlType) async {
    for (var cartItem in json['data']['carts']) {
      CartItemModel cart = CartItemModel.fromJson(cartItem);
      int index = Get.find<MainController>()
          .cartItems
          .indexWhere((p0) => p0.product?.id == cart.product?.id);
      if (index == -1) {
        Get.find<MainController>().cartItems.add(cart);
      } else {
        //replace product from sever for price is changed
        Get.find<MainController>().cartItems[index].product = cart.product;
      }
    }
  }

  Future<bool> deleteProduct({required CartItemModel cartItem}) async {
    int index = Get.find<MainController>().cartItems.indexWhere(
          (p0) => p0.product!.id == cartItem.product!.id,
        );
    deleteCartItemFromList(cartItem: cartItem, index: index);
    Helper.setCartItemToLocaleStorage();
    return true;
  }

  deleteCartItemFromList(
      {required CartItemModel cartItem, required int index}) {
    lisKey.currentState!.removeItem(
      index,
      (context, animation) => BuildCardCartItemComponent(
          cartItem: cartItem, animation: animation, index: index),
    );
    Get.find<MainController>().cartItems.removeAt(index);

  }
}
