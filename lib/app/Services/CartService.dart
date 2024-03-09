import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/CartItemModel.dart';
import 'package:delevary/app/Data/Models/ProductModel.dart';
import 'package:get/get.dart';
import 'package:helper/mixin/api_mixing.dart';

class CartService with ApiHelperMixin {
  double getTotal() {
    double total = 0;
    Get.find<MainController>().cart.forEach((cartItem) {
      total += cartItem.product.getPrice! * cartItem.qty.value;
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
  void increaseProductQty({required ProductModel product}) {
    int index = Get.find<MainController>()
        .cart
        .indexWhere((cartItem) => cartItem.product.id == product.id);
    if (index != -1) {
      int qty = Get.find<MainController>().cart[index].qty.value;
      Get.find<MainController>().cart[index].qty.value = qty + 1;
    }
  }

  //min
  void decreaseProductQty({required ProductModel product}) {
    int index = Get.find<MainController>()
        .cart
        .indexWhere((cartItem) => cartItem.product.id == product.id);
    if (index != -1) {
      int qty = Get.find<MainController>().cart[index].qty.value;
      if (qty >= 2) {
        Get.find<MainController>().cart[index].qty.value = qty - 1;
      } else {
        removeFromCart(product: product);
      }
    }
  }

  int getQty({required ProductModel product}) {
    int qty = 0;
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
          product: product, qty: RxInt(1), price: product.getPrice!));
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

  void deleteCart() {}
}
