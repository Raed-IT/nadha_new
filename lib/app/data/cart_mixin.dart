import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nadha/app/data/enums/unit_product_type_enum.dart';
import 'package:nadha/app/data/inital/main_controller.dart';
import '../services/cart_serveice.dart';
import 'helper.dart';
import 'model/cart_item_model.dart';

mixin CartMixin {
  RxList<CartItemModel> cartItems = RxList([]);
  final CartService cartService = CartService();

  bool get isAddFar {
    return Get.find<MainController>().option.value!.minBill! >= totalPrice;
  }

  double get totalPrice {
    double currentTotal = 0;
    for (CartItemModel item in cartItems) {
      // get price from
      double price = 0;
      if (item.product!.isDiscount!) {
        price = item.product!.discount!;
      } else {
        price = item.product!.price!;
      }
      if (item.fromAmount) {
        // buy from price
        currentTotal += item.price!;
      } else {
        if (item.product!.unit == UnitProductType.gram.name) {
          currentTotal += (price / 1000) * item.quantity!.value;
        } else {
          currentTotal += item.quantity! * price;
        }
      }
    }

    return currentTotal;
  }

  decrementQtyProduct({required CartItemModel item}) async {
    int? index = cartItems
        .indexWhere((cartItem) => cartItem.product?.id == item.product?.id);
    if (index != -1) {
      CartItemModel cItem = cartItems[index];
      if (cItem.quantity!.value - cItem.product!.qtyNum > 0) {
        cartItems[index].quantity!.value =
            cItem.quantity!.value - cItem.product!.qtyNum;
      }
    }
    await Helper.setCartItemToLocaleStorage();
  }

  Future<void> addCartItem({
    required CartItemModel item,
    bool isIncrease = true,
  }) async {
    ///[ isIncrease ] if true add qty for local item else add new item to server
    // if (!isIncrease) {
      // await cartService.addProductToCart(cartItem: item);
    // } else {
      int? index = cartItems
          .indexWhere((cartItem) => cartItem.product?.id == item.product?.id);
      if (index != -1) {
        if (item.product!.unit == UnitProductType.piece.name) {
          cartItems[index].quantity!.value += 1;
        } else {
          cartItems[index] = item;
        }
      }else{
        cartItems.add(item);
      }
    // }
    await Helper.setCartItemToLocaleStorage();
  }

  Future<bool> deleteCartItem({
    required CartItemModel item,
  }) async {
    bool status = await cartService.deleteCartItem(cartItem: item);
    await Helper.setCartItemToLocaleStorage();
    return status;
  }
}
