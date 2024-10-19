import 'package:delevary/app/Data/Enums/ProductUnitTypeEnum.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/CartItemModel.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:helper/mixin/api_mixing.dart';
import '../Screens/CartScreen/Components/AddToCartDialogComponent.dart';

class CartService with ApiHelperMixin {
  double getTotal() {
    double total = 0;
    Get.find<MainController>().cart.forEach((cartItem) {
      total += double.tryParse(cartItem.total) ?? 0;
    });
    return total;
  }

  bool inCart({required ProductModel product}) {
    bool inCart = false;
    Get.find<MainController>().cart.forEach((cartItem) {
      if (cartItem.product!.id == product.id) {
        inCart = true;
      }
    });
    return inCart;
  }

  replaceProduct(CartItemModel newCartItem) {
    //replace product from bottom sheet add product
    int cartItemIndex = Get.find<MainController>().cart.indexWhere(
        (cartItem) => cartItem.product?.id == newCartItem.product?.id);
    if (cartItemIndex != -1) {
      Get.find<MainController>().cart[cartItemIndex] = newCartItem;
    }
  }

//mor
  double? increaseProductQty(
      {required ProductModel product, Function? onSetState}) {
    int index = Get.find<MainController>()
        .cart
        .indexWhere((cartItem) => cartItem.product!.id == product.id);
    if (index != -1) {
      double qty = Get.find<MainController>().cart[index].qty!.value;
      Get.find<MainController>().cart[index].qty!.value = qty + product.minQty!;
      onSetState?.call();
      return qty + product.minQty!;
    }
    return null;
  }

  //min
  double? decreaseProductQty(
      {required ProductModel product, Function? onSetState}) {
    int index = Get.find<MainController>()
        .cart
        .indexWhere((cartItem) => cartItem.product!.id == product.id);
    if (index != -1) {
      double qty = Get.find<MainController>().cart[index].qty!.value;
      if (qty >= (product.minQty! * 2)) {
        Get.find<MainController>().cart[index].qty!.value =
            qty - product.minQty!;
        onSetState?.call();
        return qty - product.minQty!;
      } else {
        // removeFromCart(product: product);
        onSetState?.call();
      }
    }
    return null;
  }

  double getQty({required ProductModel product}) {
    double qty = 0;
    Get.find<MainController>().cart.forEach((cartItem) {
      if (product.id == cartItem.product!.id) {
        qty = cartItem.qty!.value;
      }
    });
    return qty;
  }

  Future<bool> addToCard({
    required ProductModel product,
    Function? onSetState,
    required BuildContext context,
    Function(GlobalKey key, bool addFromOnAddAnimation)? onAddAnimation,
  }) async {
    if (product.unit != ProductUnitTypeEnum.piece) {
      ProductUnitTypeEnum? unitType;
      double? qty;
      if (inCart(product: product)) {
        CartItemModel item = Get.find<MainController>()
            .cart
            .firstWhere((cartItem) => cartItem.product?.id == product.id);
        unitType = item.unit;
        qty = item.qty?.value;
      }
      bool status = await showAddToCartBottomSheet(
        unit: unitType,
        qty: qty,
        product,
        context: context,
        onAdd: (qty, kye, unit) {
          if (!inCart(product: product)) {
            Get.find<MainController>().cart.add(
                  CartItemModel(
                    unit: unit,
                    product: product,
                    qty: RxDouble(qty),
                    price: double.parse(product.getPrice!),
                  ),
                );
          } else {
            replaceProduct(
              CartItemModel(
                unit: unit,
                product: product,
                qty: RxDouble(qty),
                price: double.parse(product.getPrice!),
              ),
            );
          }
          if (onAddAnimation != null) {
            onAddAnimation(kye, true);
          }
        },
      );
      if (onSetState != null) {
        onSetState();
      }
      return status;
    } else {
      if (!inCart(product: product)) {
        Get.find<MainController>().cart.add(
              CartItemModel(
                unit: product.unit,
                product: product,
                qty: RxDouble(product.minQty ?? 1),
                price: double.parse(product.getPrice!),
              ),
            );
      } else {
        increaseProductQty(product: product);
      }
      if (onAddAnimation != null) {
        onAddAnimation(GlobalKey(), false);
      }
    }

    return true;
  }

  void removeFromCart(
      {required ProductModel product, Function? onSetState}) async {
    int index = Get.find<MainController>().cart.indexWhere(
            (cartItem) => cartItem.product!.id == product.id);
    if (index != -1) {
      Get.find<MainController>().cart.removeAt(index);
      onSetState?.call();
    }
  }

  addCustomQty(
      {required double qty,
      required ProductModel product,
      Function? onSetState}) {
    int index = Get.find<MainController>()
        .cart
        .indexWhere((cartItem) => cartItem.product!.id == product.id);
    if (index != -1) {
      Get.find<MainController>().cart[index].qty!.value = qty;
      onSetState?.call();
    }
  }

  void clearCart() {
    Get.find<MainController>().cart.clear();
  }
}
