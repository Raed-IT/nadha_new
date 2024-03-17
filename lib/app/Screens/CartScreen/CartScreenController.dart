import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Data/Models/CartItemModel.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Services/CartService.dart';
import 'package:delevary/app/Services/UI/OverlayLoaderService.dart';
import 'package:delevary/app/Services/UI/ToastService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:helper/mixin/api_mixing.dart';

class CartScreenController extends GetxController with ApiHelperMixin {
  CartService cartService = CartService();
  TextEditingController noteTextController = TextEditingController();

  void createOrder(BuildContext context) async {
    List<CartItemModel> cart = Get.find<MainController>().cart;
    dio.FormData data = dio.FormData.fromMap({});
    for (int i = 0; i < cart.length; i++) {
      data.fields
          .add(MapEntry("items[$i][product_id]", "${cart[i].product!.id!}"));
      data.fields.add(MapEntry("items[$i][quantity]", "${cart[i].qty!.value}"));
    }
    data.fields.add(MapEntry("address_id",
        "${Get.find<MainController>().selectedAddress.value?.id}"));
    data.fields.add(MapEntry("note", noteTextController.text));

    OverlayLoaderService.show(context);
    await postData(
        url: ApiRoute.orders,
        data: data,
        onSuccess: (res, type) {
          if (res.data['status'] == "SUCCESS") {
            ToastService.showSuccessToast(
              context: context,
              title: 'تم ارسال الطلب',
            );
            cartService.clearCart();
            Get.offNamed(AppRoutes.orders);
            // Get.reset();
          } else {
            ToastService.showErrorToast(
                context: context,
                title: 'خطاء في ارسال الطلب   ',
                description: res.data['data']['message']);
          }
        },
        onError: (ex, ty) {
          ToastService.showErrorToast(
              context: context, title: 'خطاء في ارسال الطلب   ');
        });
    Loader.hide();
  }
}
