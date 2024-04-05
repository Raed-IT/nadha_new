import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/CartItemModel.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:helper/mixin/api_mixing.dart';

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

  void addToCard({required ProductModel product, Function? onSetState}) {
    if (!inCart(product: product)) {
      Get.find<MainController>().cart.add(CartItemModel(
          product: product,
          qty: RxDouble(product.minQty ?? 1),
          price: double.parse(product.getPrice!)));
    } else {
      increaseProductQty(product: product);
    }
    onSetState?.call();
  }

  void removeFromCart(
      {required ProductModel product, Function? onSetState}) async {
    await Get.bottomSheet(Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          20.verticalSpace,
          Text(
            "حذف عنصر ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
          ),
          20.verticalSpace,
          Text(
            "سيتم حذف `${product.name}` من السلة ",
            textAlign: TextAlign.center,
          ),
          20.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton.icon(
                style: ButtonStyle(
                  surfaceTintColor: MaterialStateProperty.all(Colors.red),
                ),
                onPressed: () {
                  int index = Get.find<MainController>().cart.indexWhere(
                      (cartItem) => cartItem.product!.id == product.id);
                  if (index != -1) {
                    Get.find<MainController>().cart.removeAt(index);
                    onSetState?.call();
                  }
                  Get.back();
                },
                icon: Icon(
                  FontAwesomeIcons.remove,
                ),
                label: Text('حذف'),
              ),
              OutlinedButton(
                onPressed: () => Get.back(),
                child: Text("إالغاء"),
              ),
            ],
          )
        ],
      ),
    ));
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
