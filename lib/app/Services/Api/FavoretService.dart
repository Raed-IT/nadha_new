import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Services/UI/ToastService.dart';
import 'package:flutter/cupertino.dart';
import 'package:helper/mixin/api_mixing.dart';
import '../../Data/Models/ProductModel.dart';

class FavoriteService with ApiHelperMixin {
  Future<bool> favoriteTrigger(
      {required ProductModel product, required BuildContext context}) async {
    bool status = false;
    String method = "POST";
    if (product.isFavorite!) {
      method = "DELETE";
    }
    await postData(
        url:
            "${ApiRoute.favorites}${product.isFavorite! ? '/${product.id}' : ''}",
        data: {
          "product_id": product.id,
          "_method": method,
        },
        onSuccess: (res, type) {
          status = true;
          ToastService.showSuccessToast(
              context: context, title: '${res.data['data']}');
          product.isFavorite = product.isFavorite;
        },
        onError: (exp, t) {});
    return status;
  }
}
