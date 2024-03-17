import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/CartItemModel.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:get/get.dart';
import 'package:helper/mixin/api_mixing.dart';

class CartService with ApiHelperMixin {
  double getTotal() {
    double total = 0;
    Get.find<MainController>().cart.forEach((cartItem) {
      total += double.parse(cartItem.product.getPrice!) * cartItem.qty.value;
    });
    return total;
  }

  bool inCart({required ProductModel product}) {
    bool inCart = false;
    Get.find<MainController>().cart.forEach((cartItem) {
      if (cartItem.product.id == product.id) {
        inCart = true;
      }
    });
    return inCart;
  }

//mor
  double? increaseProductQty({required ProductModel product}) {
    int index = Get.find<MainController>()
        .cart
        .indexWhere((cartItem) => cartItem.product.id == product.id);
    if (index != -1) {
      double qty = Get.find<MainController>().cart[index].qty.value;
      Get.find<MainController>().cart[index].qty.value = qty + product.minQty!;
      return qty + product.minQty!;
    }
    return null;
  }

  //min
  double? decreaseProductQty({required ProductModel product}) {
    int index = Get.find<MainController>()
        .cart
        .indexWhere((cartItem) => cartItem.product.id == product.id);
    if (index != -1) {
      double qty = Get.find<MainController>().cart[index].qty.value;
      if (qty >= (product.minQty! * 2)) {
        Get.find<MainController>().cart[index].qty.value =
            qty - product.minQty!;
        return qty - product.minQty!;
      } else {
        removeFromCart(product: product);
        return null;
      }
    }
  }

  double getQty({required ProductModel product}) {
    double qty = 0;
    Get.find<MainController>().cart.forEach((cartItem) {
      if (product.id == cartItem.product.id) {
        qty = cartItem.qty.value;
      }
    });
    return qty;
  }

  void addToCard({required ProductModel product}) {
    if (!inCart(product: product)) {
      Get.find<MainController>().cart.add(CartItemModel(
          product: product,
          qty: RxDouble(1),
          price: double.parse(product.getPrice!)));
    } else {
      increaseProductQty(product: product);
    }
  }

  void removeFromCart({required ProductModel product}) {
    int index = Get.find<MainController>()
        .cart
        .indexWhere((cartItem) => cartItem.product.id == product.id);
    if (index != -1) {
      Get.find<MainController>().cart.removeAt(index);
    }
  }

  addCustomQty({required double qty, required ProductModel product}) {
    int index = Get.find<MainController>()
        .cart
        .indexWhere((cartItem) => cartItem.product.id == product.id);
    Get.find<MainController>().cart[index].qty.value = qty;
  }

  void deleteCart() {}
}
